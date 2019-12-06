## Setup AWS cloud with Terraform

1) To perform any operations in your cloud infrastructure terraform needs access and secret keys of user with admin permissions.
 - Go to AWS Console and retrieve Access and Secret keys
 - Setup those keys in ~/.aws/credentials
 ```text
 [default]
 aws_access_key_id = ""
 aws_secret_access_key = ""
 ```

2) Run terraform pre-setup from your local machine to create a CodePipeline project witch will run terraform whenever infrastructure config changes.

3) Add terraform files into your project repository. Terraform can automatically recognize all *.tf, *.tfvars files in the repo.

4) Add gitwebhooks to monitor project repository with CodePipeline created in step 2.

5) Adjust all config files and push to the repository, so terraform will create infrastructure.
