1 For Question1, Code refer to
    1.1 .buildkite/pipeline.yml is pipeline code, based on Buildkite Agent
    1.2 script.sh is pipeline used bash script
    1.3 for AWS credentials (authentication), i prefer use Cloudformation to created Buildkite Agent which mean dont need to store AWS credentials externally
    1.4 In Terraform Folder all terraform based code, environments directory refer to different AWS envs *(e.g Dev, Test and Prod)
    1.5 AEcapital directory refer to sample .NET

2 For question2, Code refer to
    2.1 BASH directory

3 For Infra improvment, can refer to the way we created Buildkite Agent, How to store credentials, terraform State file store and AWS resources created seprately.
