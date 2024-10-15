# CI/CD Example

This repository demonstrates a CI/CD pipeline using GitHub Actions. It includes workflows for deploying to development and production environments and other common CI/CD tasks.

## Prerequisites

Before running the workflows, ensure you have the following:

- Set up the following secrets in your GitHub repository:
  - **`REGISTRY_USERNAME`**: Your Docker Hub username if you are using Docker Hub. If you are using the GitHub Container Registry, set this to your GitHub username.
  - **`REGISTRY_PASSWORD`**: Your Docker Hub password if you are using Docker Hub. If you are using the GitHub Container Registry, set this to your GitHub Personal Access Token with the required scopes and expiration. Generate a new token [here](https://github.com/settings/tokens) by following these steps:
      1. Click on the `Generate new token` button. Choose `Generate new token (classic)`. Authenticate with your GitHub account.
      2. Enter/select the following details:
          - **Note**: `omnistrate-ci-cd` or any note you prefer.
          - **Expiration**: `No expiration`.
          - **Scopes**:
              - `write:packages`
              - `delete:packages`
      3. Click `Generate token` and copy the token to your clipboard.
  - **`OMNISTRATE_USERNAME`**: Your Omnistrate username (email).
  - **`OMNISTRATE_PASSWORD`**: Your Omnistrate password.


- Ensure that your Compose Spec file is correctly configured:
  - Include the `x-omnistrate-image-registry-attributes` section as shown below:
    ```yaml
    x-omnistrate-image-registry-attributes:
      ghcr.io: # Change to docker.io if you want to publish your image on docker.io
        auth:
          password: $IMAGE_REGISTRY_PASSWORD # DO NOT CHANGE. Put this placeholder exactly as it is. The workflow will replace it with the real value before building it into service.
          username: $IMAGE_REGISTRY_USERNAME # Same as above
    ```
  - Include the `x-omnistrate-service-plan` section. Refer to the [x-omnistrate-service-plan](https://docs.omnistrate.com/getting-started/compose-spec/#x-omnistrate-service-plan) for more information.
  - Put the image as a placeholder in the `image` field under the `services` section. The workflow will replace it with the real value before building it into service.
    ```yaml
    image: $IMAGE_URI
    ```

- If you are using the GitHub Container Registry, add this line to your Dockerfile to link the image to the GitHub repository:
  ```Dockerfile
  LABEL org.opencontainers.image.source=https://github.com/omnistrate-community/ci-cd-example
  ```
  
- Review the TODOs in `.github/workflows/dev-prod-deployment.yaml` and ensure that the values are correctly set for your case.

## Workflow Overview

### Dev Prod Deployment

This workflow handles building and deploying Docker images to different environments. It has three main jobs:

1. **Build and Push**: Builds the Docker image and pushes it to the GitHub Container Registry. It uses Docker Buildx to support multi-architecture builds and caches to speed up the build process.
2. **Deploy to Dev**: Updates the development environment with the new Docker image.
3. **Deploy to Prod**: Updates the production environment with the new Docker image, creating the production environment if it does not exist.

**Triggers:**
- **Release Published**: Automatically triggered when a new release is published.
- **Manual Trigger**: Can be manually triggered from the Actions tab.

### Upgrade Instances

This workflow upgrades instances to a specified target version.

**Triggers:**
- **Manual Trigger**: Can be manually triggered from the Actions tab, requiring user input for instance IDs and the target version.

## Customizing the Workflows

### Dev Prod Deployment Workflow

- **Dockerfile Path**: Change the path to the Dockerfile if it's different from `./dockerfile`.
- **Service Plans**: Update the paths to your Docker Compose files or other configuration files.
- **Omnistrate Credentials**: Ensure your Omnistrate credentials and environment names match your setup.

### Upgrade Instances Workflow

- **Instance IDs**: Provide a space-separated list of instance IDs to upgrade.
- **Target Version**: Specify the target version for the upgrade (e.g., `1.0`, `latest`, `preferred`).

Find the workflow files in `.github/workflows`. You can customize these workflows by modifying the values and paths according to your needs.