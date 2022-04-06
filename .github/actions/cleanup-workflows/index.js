const core = require('@actions/core');
const github = require('@actions/github');

// Args
const [, , pat_token, repository, excluded_workflows] = process.argv;

// Since github throttles requests on 5.000, we dont want to spend all.
// To make sure a single execution does not trigger that, we will throttle at 4.000
// https://docs.github.com/en/developers/apps/building-github-apps/rate-limits-for-github-apps#user-to-server-requests
// Can possibly be capped at 15.000 by looking into Github Apps
let githubApiCallsThrottleCap = 4000;
let githubApiCallsUsed = 0;

// Define the main function
const main = async () => {
  try {
    console.log('Initiating cleanup of workflows');

    if (!repository || !pat_token) {
      console.log('repository', repository);
      console.log('pat_token', pat_token);
      throw new Error('Missing arguments');
    }

    if (excluded_workflows) {
      console.log('Skipping excluded workflows:', excluded_workflows);
    }

    // Since github variable github.repository is in the format {owner}/{repository}
    // we split it to get each value. 
    const splittedRepositoryString = repository.split('/');
    const owner = splittedRepositoryString[0];
    const repo = splittedRepositoryString[1];

    // Initiate octokit
    const octokit = new github.getOctokit(pat_token);

    // Pulling used github calls from rate_limit endpoint
    const rateLimitResponse = await octokit.request('GET /rate_limit');
    githubApiCallsUsed = rateLimitResponse.data.rate.used;
    if (githubApiCallsUsed >= githubApiCallsThrottleCap){
      throw new Error('Almost spent up all requests for this hour, aborting - please try again later.');
    }
    
    const workflowsResponse = await octokit
      .rest
      .actions
      .listRepoWorkflows({
        owner,
        repo,
      })
      .then(githubApiCallsUsed++);

    if (workflowsResponse.data.workflows){
      // Iterating through workflows
      for (let workflowIndex = 0; workflowIndex < workflowsResponse.data.workflows.length; workflowIndex++) {
        const workflow = workflowsResponse.data.workflows[workflowIndex];
        await cleanWorkflow(octokit, owner, repo, excluded_workflows, workflow);
      };
    }
  } catch (error) {
    console.log(error);
    core.setFailed(error.message);
  }

  console.log('Workflow cleanup done');
}

const cleanWorkflow = async(octokit, owner, repo, excluded_workflows, workflow) => {
  const pathWithoutPrefix = workflow.path.replace('.github/workflows/', '');
  console.log(`Initiating cleaning of workflow: ${pathWithoutPrefix}`);
  let workflowCleared = false;

  if (excluded_workflows && excluded_workflows.includes(pathWithoutPrefix)) {
    console.log(`Workflow ${pathWithoutPrefix} excluded, continuing`);
    return;
  }
  else {
    // Github only returns max 100 per request, so we need to keep iterating until runs equals 0
    while (!workflowCleared) {
      console.log(`Workflow ${pathWithoutPrefix} not excluded, getting workflow runs`);

      try {
        // Only handling non excluded workflows
        const workflowRuns = await octokit
          .rest
          .actions
          .listWorkflowRuns({
            owner,
            repo,
            workflow_id: workflow.id,
          })
          .then(githubApiCallsUsed++);

        if (githubApiCallsUsed >= githubApiCallsThrottleCap){
          throw new Error('Almost spent up all requests for this hour, aborting - please try again later.');
        }

        if (workflowRuns.data.workflow_runs.length <= 0){
          console.log('Workflow cleared');
          workflowCleared = true;
          break;
        }

        if (workflowRuns.data.workflow_runs) {
          console.log(`Cleaning runs of workflow ${workflow.name}`);

          await cleanWorkflowRuns(octokit, owner, repo, workflowRuns.data.workflow_runs);
        }
      }
      catch {
        // When the workflow is cleared, the call will fail with 404.
        // Since the workflow is completely removed
        break;
      }
    }
  }
}

const cleanWorkflowRuns = async(octokit, owner, repo, workflows) => {
  for (let index = 0; index < workflows.length; index++) {
    const workflowRun = workflows[index];

    console.log(`Deleting run with id: ${workflowRun.id}`);

    await octokit
      .rest
      .actions
      .deleteWorkflowRun({
        owner,
        repo,
        run_id: workflowRun.id,
      })
      .then(githubApiCallsUsed++);

    if (githubApiCallsUsed >= githubApiCallsThrottleCap){
      throw new Error('Almost spent up all requests for this hour, aborting - please try again later.');
    }

    console.log(`Succesfully deleted run with id: ${workflowRun.id}`);
  };
}

// Call the main function to run the action
main();