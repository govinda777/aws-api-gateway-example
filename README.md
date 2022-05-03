# AWS API Gateway provisioning example

This example repository showcases the deployment of infrastructure and services using terragrunt. The example shows how to deploy some services such as AWS API Gateway, a lambda etc. It uses AWS S3 to store the remote terraform state. 

## Target Infrastructure

The following figure shows a very simplified architecture overview of the target infrastructure. It hides a lot of details such as IAM, Cloudwatch, Hosted Zone etc.

![Simplified Target Architecture](./index.png)

## Project Structure

- `lambda`: The sample javascript lambda

- `terragrunt/modules`: This directory contains all the terragrunt custom modules. Each module contains multiple terraform files that are logically separated based on which resource it creates / modifies. They also include `inputs.tf` file which defines all the inputs needed for the module and `outputs.tf` file that defined the outputs that are exported by the module.

- `terragrunt/aws-account-x`: This directory contains the terragrunt deployment files. In this app, the deployment is separated per application. That is `api-gateway-example-app`, the example app. Inside each application, there is again logical separation for each dependencies eg: `api-gateway-example-app/lambda`, `api-gateway-example-app/route53`, `api-gateway-example-app/api-gateway` etc. 

- Some times you also need to setup account level resources that are shared across multiple applications. These goes to `terragrunt/aws-account-x/account-level-resources`.

## Deployment

- Set your aws account related details in `terragrunt/aws-account-x/account.yaml` file such as account number, zones etc
- You also may want to update details such as domain name, etc in most of the `terragrunt.hcl` files, `env.yaml` & `global.yaml` files
- Install `aws`, `node`, `yarn`, `terraform` and `terragrunt` cli tools
- Configure `aws` cli. See [AWS documentation](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html) for more details
- Login to your aws account using cli
- Verify you have logged in successfully by running some commands such as `aws ec2 describe-instances`
- `terragrunt plan` command will show the deployment plan like what resources needs to be added, modified or removed
- `terragrunt apply` command will apply the changes to your AWS resources
- For the first time deployment follow the order `lambda`, `acm`, `api-gteway` and `route53`

### Sample Lambda

#### Building Lambda

You can use your favourite tool (`npm` or `yarn`) to build the lambda

```sh
cd lambda
yarn install
yarn zip
```

#### Deploying Lambda

```sh
cd terragrunt/aws-account-x/api-gateway-example-app/lambda 
terragrunt plan
terragrunt apply
```

### Sample API Gateway

#### ACM (AWS Certificate Manager)

You need to first deploy your SSL certificate to ACM or create a new one using ACM. You only need to do this only when you have new certificate (for eg: a renewed certificate). In our example app case, we are creating a new `DNS` based certificate using ACM.

```sh
cd terragrunt/aws-account-x/api-gateway-example-app/acm 
terragrunt plan
terragrunt apply
```

#### API Gateway

```sh
cd terragrunt/aws-account-x/api-gateway-example-app/api-gateway 
terragrunt plan
terragrunt apply
```

#### Route53

In our example app case, we are using AWS Route53 as our DNS server. You may need to deploy this only once unless you need to change your routing information.

```sh
cd terragrunt/aws-account-x/api-gateway-example-app/route53 
terragrunt plan
terragrunt apply
```

## Testing

Do a `POST` request to the endpoint `users.{YOUR_DOMAIN_NAME_HERE}/users` with any payload & check the response