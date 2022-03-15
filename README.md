## Deptwo.0

###### deptwo.0 is the new workflow to deploy to google/AWS taking experience from deployer and respawn and modifying it with the latest and greatest technologies to create a central deployment engine for google cloud compute / amazon web services. Deptwo.0 uses the following tools internally to deploy your application to google cloud compute:

- Terraform
- Jenkins
- Pipelines
- Artifactory
- groovy

##### Table of Contents

*all environments are seperated by folders.*

- dev/
- int/
- stag/
- prod/

*all blue-green configurations are seperated by folders.*

- dev/blue/
- int/blue/
- stag/blue/
- prod/blue/
- dev/green/
- int/green/
- stag/green/
- prod/green/

*all multi region configurations are seperated by folders.*

- dev/blue/virginia
- dev/blue/oregon
- dev/green/virginia
- dev/green/oregon
- so on ...

*Pass the backend in atleast one tf per environment/stack/region/ to store statefile in artifactory*

```
terraform {
  backend "artifactory" {}
}
```

*Dont pass the credentials and deptwo.0 will automatically create them for you*

Please keep your main.tf credentials empty :

```
# Configure the Google Cloud provider with credentials for project
provider "google" {
  region = "${var.region}"
  project = "${var.project_name}"
  # credentials = "${file("${var.credentials_file_path}")}" commented out as not needed by deptwo.0
}
```

```
# Configure the AWS provider with credentials for project
provider "aws" {
  region     = "us-east-1"
}
```

*Each environment/blue-green/region mantains its own tf.state file.*

To write configuration you can use the sample structuring :
- dev/blue/virginia/main.tf (seed to start from)
- dev/blue/virginia/variable.tf (store all variables here)

```json
- Please note, you can structure the tf files as you like within the environment/blue-green/region folder.
- gitignore the tfstate file as we mantain that for you in the workflow.
```

<a name="workflow"/>
<div align="center">
<a href="" target="_blank">
<img src="utils/workflow.png" alt="deptwo.0" width="500" height="400"></img>
</a>
</div>
