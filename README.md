# school-supervisor
Project to replace the "Ecole directe" site by collect its data and report them into a more user friendly views

## Pre-requisted
You need to have :
- an Azure active account, a free one is suffisant
- a Mongo Atlas account, a free on is suffisant
- a github account for the actions
- terraform installed 
- node installed (the actual LTS for me is the 16.15.1)

## Terraform
Terraform is use to setup the runtime environnement by creating:
- A new Ressource group (customizable in variables)
- An Azure Key Vault to store the project secrets
- An Azure App Configuration to store the project configuration (such as the db project name or collection name, the main "Ecole direct" url)

### Pre-requisted
- You must have logged in you env [Terraform Doc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs) 
- You must have defined the Mongo Atlas keys, in your environment 
```bash
$  export MONGODB_ATLAS_PUBLIC_KEY="xxxx"
$  export MONGODB_ATLAS_PRIVATE_KEY="xxxx"
```

### Execution
To run the terraform commands go to the terraform folder
> terraform init 

> terraform apply -var-file=vars/staging.tfvars

This command will first display the description of actions which will be performed if you accept them before to do anything
