# ci-cd-example

This is a simple example of a CI/CD pipeline using GitHub Actions.

## Prerequisites

Before running the workflow, ensure you have set up the following GitHub repository secrets:

- `REGISTRY_USERNAME`: Your GitHub username. Set it exactly as your GitHub username.
- `REGISTRY_PASSWORD`: Your GitHub Personal Access Token with the required scope and expiration. Generate a new token [here](https://github.com/settings/tokens) following below steps:
  1. Click on the `Generate new token` button. Choose `Generate new token (classic)`. Authenticate with your GitHub account.
  2. Enter / Select the following details:
     - Enter Note:  omnistrate-ci-cd` or any other note you prefer
     - Select Expiration: `No expiration`
     - Select the following scopes:
       - `write:packages`
       - `delete:packages`
  3. Click `Generate token` and copy the token to your clipboard.
- `OMNISTRATE_USERNAME`: Your Omnistrate username (email).
- `OMNISTRATE_PASSWORD`: Your Omnistrate password.

## Workflow Triggers

- **Release Published**: The Dev Prod Deployment workflow is triggered when a new release is published.
- **Manual Trigger**: You can also manually trigger the workflow using in the Actions tab.

## Customizing the Workflow


Find the workflow files in `.github/workflows`. You can customize the workflow by changing the values suggested by the comments.