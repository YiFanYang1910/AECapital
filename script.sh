#!/bin/bash

# Install jq and curl
echo "Installing jq and curl..."
sudo apt-get update
sudo apt-get install -y jq curl

# Install .NET
echo "Installing .NET..."
curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel LTS
export PATH="$HOME/.dotnet:$PATH"
echo "export PATH=\"$HOME/.dotnet:$PATH\"" >> ~/.bashrc

# Install Docker
echo "Installing Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Install Terraform
echo "Installing Terraform..."
TERRAFORM_VERSION=$(curl -sSL https://releases.hashicorp.com/terraform/index.json | jq -r '.versions[].version' | sort -V | tail -n 1)
curl -o terraform.zip -sSL "https://releases.hashicorp.com/terraform/$TERRAFORM_VERSION/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
unzip terraform.zip
chmod +x terraform
sudo mv terraform /usr/local/bin/
rm terraform.zip

echo "Installation completed successfully!"

# build image and name version
docker build -t AECapital:0.0.1

# created ecr in AWS
terraform -chdir=terraform/infra/ecr init  -backend-config="bucket=${state s3 bucket name}" -backend-config="key=${state s3 bucekt KMS}" -backend-confiog="region=ap-southeast-2" -backend-config="encrypt=ture" -backend-config="kms_key_id=${kms alias name}" -backend-config="dynamodb_table=${dynamodb table name}"
terraform -chdir=terraform/infra/ecr validate
terraform -chdir=terraform/infra/ecr plan -var-file="../../environments/dev/ecr/values.tfvars" -lock=true -out="./output"
terraform -chdir=terraform/infra/ecr apply "./output"

# upload docker image to ecr
docker push aws_account_id.dkr.ecr.ap-southeast-2.amazonaws.com/AECapital:0.0.1

# created ecs in AWS
terraform -chdir=terraform/infra/ecs init  -backend-config="bucket=${state s3 bucket name}" -backend-config="key=${state s3 bucekt KMS}" -backend-confiog="region=ap-southeast-2" -backend-config="encrypt=ture" -backend-config="kms_key_id=${kms alias name}" -backend-config="dynamodb_table=${dynamodb table name}"
terraform -chdir=terraform/infra/ecs validate
terraform -chdir=terraform/infra/ecs plan -var-file="../../environments/dev/ecs/values.tfvars" -lock=true -out="./output"
terraform -chdir=terraform/infra/ecs apply "./output"f

echo "deploy finished, all resources created successfully"
