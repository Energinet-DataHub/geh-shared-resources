const core = require('@actions/core');
const github = require('@actions/github');

// Args
const [, , pat_token, repository] = process.argv;
const exludedWorkflows = ['ci.yml', 'cd.yml', 'cleanup-workflows.yml'];

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

    // Since github variable github.repository is in the format {owner}/{repository}
    // we split it to get each value. 
    const splittedRepositoryString = repository.split('/');
    const owner = splittedRepositoryString[0];
    const repo = splittedRepositoryString[1];

    // Initiate octokit
    const octokit = new github.getOctokit(pat_token);

    const rateLimitResponse = await octokit.request('GET /rate_limit');
    console.log('rateLimit', rateLimitResponse);
    
    // const workflowsResponse = await octokit.rest.actions.listRepoWorkflows({
    //   owner,
    //   repo,
    // });
    // githubApiCallsUsed++;

    // if (workflowsResponse.data.workflows){
    //   // Iterating through workflows
    //   workflowsResponse.data.workflows.map(async (workflow) => {
    //     const pathWithoutPrefix = workflow.path.replace('.github/workflows/', '');

    //     // Only handling non excluded workflows
    //     if (!exludedWorkflows.includes(pathWithoutPrefix)) {
    //       const workflowRuns = await octokit.rest.actions.listWorkflowRuns({
    //         owner,
    //         repo,
    //         workflow_id: workflow.id,
    //       });
    //       githubApiCallsUsed++;
    //       if (githubApiCallsUsed >= githubApiCallsThrottleCap){
    //         throw new Error('Close to spending up throttles for the current hour');
    //       }

    //       if (workflowRuns.data.workflow_runs) {
    //         console.log(`Cleaning runs of workflow ${workflow.name}`);

    //         // Iterating workflow runs
    //         workflowRuns.data.workflow_runs.map(async (workflowRun) => {
    //           await octokit.rest.actions.deleteWorkflowRun({
    //             owner,
    //             repo,
    //             run_id: workflowRun.id,
    //           });
    //           githubApiCallsUsed++;
    //           if (githubApiCallsUsed >= githubApiCallsThrottleCap){
    //             throw new Error('Close to spending up throttles for the current hour');
    //           }

    //           console.log(`Run ${workflowRun.id} deleted`);
    //         });
    //       }
    //     }
    //   });
    // }
  } catch (error) {
    console.log(error.message);
    core.setFailed(error.message);
  }

  console.log('Workflow cleanup done');
}

// Call the main function to run the action
main();