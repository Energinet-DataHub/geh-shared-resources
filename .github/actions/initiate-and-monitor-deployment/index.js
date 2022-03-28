const core = require('@actions/core');
const github = require('@actions/github');
const dayjs = require('dayjs');
const { nanoid } = require('nanoid')

// Args
const [, , pat_token, release_name, workflow_id, repo, owner] = process.argv;

// Define the main function
const main = async () => {
  try {
    // Initiate octokit
    const octokit = new github.getOctokit(pat_token);

    // Initiate deployment
    await octokit.rest.actions.createWorkflowDispatch({
      owner,
      repo,
      workflow_id,
      ref: 'main',
      inputs: {
        release_name,
        action_reference_id: nanoid(),
      }
    });

    // Get workflow runs
    // Generate date 5 minutes back in time, to get all runs after that
    let currentDate = dayjs().subtract(1, 'hour');
    console.log(currentDate);
    console.log(`>${currentDate.format('YYYY-MM-DDTHH:MM:SSZ')}`);
    const runs = await octokit.rest.actions.listWorkflowRuns({
      owner,
      repo,
      workflow_id,
      created: `>${currentDate.format('YYYY-MM-DDTHH:MM:SSZ')}`
    });

    console.log(runs);
  } catch (error) {
    core.setFailed(error.message);
  }
}

// Call the main function to run the action
main();