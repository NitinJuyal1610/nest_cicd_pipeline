# CI/CD Pipeline for NestJS Application

## Key Components

- Version Control: Git (GitHub)
- CI/CD Tool: GitHub Actions
- Containerization: Docker
- Database: PostgreSQL (AWS RDS)
- Deployment Infrastructure: AWS ECS
- Region: ap-south-1
- Load Balancing : Application Load Balancer
- Monitoring and Logging: AWS CloudWatch

## Workflow

### Build Job

- Triggers on push and pull_request events to the `main` branch
- Builds and tests the NestJS application for Node.js versions 19.x and 20.x
- Creates a `.env` file from secrets
- Performs linting

### Deploy Job (if build successful)

- Configures AWS credentials
- Builds and pushes a Docker image to Amazon ECR
- Updates the ECS task definition with the new image
- Deploys the updated task definition to ECS

## Prerequisites

- An AWS account with necessary permissions
- An AWS RDS PostgreSQL instance
- An AWS ECS cluster
- An Amazon ECR repository
- An AWS Application Load Balancer (configured separately)

## Configuration

 - GitHub Actions Workflow: The pipeline is defined in the .github/workflows/nestjs-ci.yml file.
 - Environment Variables: Store sensitive information in GitHub repository secrets:
      - AWS_ACCESS_KEY_ID
      - AWS_SECRET_ACCESS_KEY
      - ENV_FILE (containing environment variables for the NestJS application)
 - Task Definition: The nest-app-task-definition-revision1.json file specifies container configurations.

## Usage

1. Commit and push changes to the `main` branch to trigger the CI/CD workflow.
2. Monitor the workflow progress in the Actions tab of your GitHub repository.

## Additional Information
- Container on ECS has access to environment variables through AWS secret manager
- Task definition file: `nest-app-task-definition-revision1.json` (located in the root of the repository)
