# Variables

### Values in github workflow
Make sure to set appropriate values in your [github workflow](.github/workflows/build-deploy-multi-region.yml).
- `AWS_REGION`: points to correct aws region
- `ECR_REPO`: specify correct AWS ECR repo
- `IAM_ASSUME_ROLE`: points to correct IAM role which will be assumed by Github OIDC client to access AWS resources
- `AWS_REGION1`: AWS region in which primary cluster resides
- `AWS_REGION2`: AWS region in which secondary cluster resides
- `EKS_REGION1_CLUSTER_NAME`: cluster name of primary EKS cluster
- `EKS_REGION2_CLUSTER_NAME`: cluster name of secondary EKS cluster

### Values in values-seoul-prod.yaml
Make sure to set appropriate values in [values-seoul-prod.yaml](helm-chart/todo-service/values-seoul-prod.yaml) of your application helm chart.
- `image.repository`: points to correct aws ecr repo
- `rails_env`: set correct rails environment name (development, porduction)
- `primary_db_writer_endpoint`: points to primary db writer endpoint of aurora postgresql db cluster (the value can be either *region1_writer_db_endpoint* or *region2_writer_db_endpoint*, its acually the value of the key in db_creds kubernetes secret that holds the writer endpoint url for primary and secondary aurora db cluster, you need to redeploy app with correct writer endpoint in case if primary writer db cluster fails)

Inside `ingress` section:
- `ingress.alb.ingress.kubernetes.io/certificate-arn`: points to ACM certificate ARN in AWS region where primary cluster resides
- `ingress.external-dns.alpha.kubernetes.io/hostname`: points to correct Route53 domain name (the same value set in todo_app.region1_url in [tfvars file](https://github.com/milindchawre/eks-infra/blob/multi-region/infrastructure/db-setup/environments/production.tfvars))
- `external-dns.alpha.kubernetes.io/aws-failover`: set as PRIMARY, as it is primary dns failover record
- `external-dns.alpha.kubernetes.io/aws-health-check-id`: the route53 healthcheck id, that is obtained after deploying [db-setup module](https://github.com/milindchawre/eks-infra/blob/multi-region/infrastructure/db-setup/outputs.tf) (the value of *route53_heathcheck_id_region1* terraform output)
- `external-dns.alpha.kubernetes.io/set-identifier`: a unique identifier for route53 record
- `ingress.hosts[0].host`: points to correct Route53 domain name (the app url which is common for all the apps deployed on eks clusters in differet aws regions)

Inside `ingress2` section:
- `ingress.alb.ingress.kubernetes.io/certificate-arn`: points to ACM certificate ARN in AWS region where primary cluster resides
- `ingress.external-dns.alpha.kubernetes.io/hostname`: points to correct Route53 domain name (the same value set in todo_app.region1_url in [tfvars file](https://github.com/milindchawre/eks-infra/blob/multi-region/infrastructure/db-setup/environments/production.tfvars))
- `ingress.hosts[0].host`: same value as set above in `ingress.external-dns.alpha.kubernetes.io/hostname`

### Values in values-osaka-prod.yaml
Make sure to set appropriate values in [values-osaka-prod.yaml](helm-chart/todo-service/values-osaka-prod.yaml) of your application helm chart.
- `image.repository`: points to correct aws ecr repo
- `rails_env`: set correct rails environment name (development, porduction)
- `primary_db_writer_endpoint`: points to primary db writer endpoint of aurora postgresql db cluster (the value can be either *region1_writer_db_endpoint* or *region2_writer_db_endpoint*, its acually the value of the key in db_creds kubernetes secret that holds the writer endpoint url for primary and secondary aurora db cluster, you need to redeploy app with correct writer endpoint in case if primary writer db cluster fails)

Inside `ingress` section:
- `ingress.alb.ingress.kubernetes.io/certificate-arn`: points to ACM certificate ARN in AWS region where secondary cluster resides
- `ingress.external-dns.alpha.kubernetes.io/hostname`: points to correct Route53 domain name (the same value set in todo_app.region2_url in [tfvars file](https://github.com/milindchawre/eks-infra/blob/multi-region/infrastructure/db-setup/environments/production.tfvars))
- `external-dns.alpha.kubernetes.io/aws-failover`: set as SECONDARY, as it is primary dns failover record
- `external-dns.alpha.kubernetes.io/aws-health-check-id`: the route53 healthcheck id, that is obtained after deploying [db-setup module](https://github.com/milindchawre/eks-infra/blob/multi-region/infrastructure/db-setup/outputs.tf) (the value of *route53_heathcheck_id_region2* terraform output)
- `external-dns.alpha.kubernetes.io/set-identifier`: a unique identifier for route53 record
- `ingress.hosts[0].host`: points to correct Route53 domain name (the app url which is common for all the apps deployed on eks clusters in differet aws regions)

Inside `ingress2` section:
- `ingress.alb.ingress.kubernetes.io/certificate-arn`: points to ACM certificate ARN in AWS region where secondary cluster resides
- `ingress.external-dns.alpha.kubernetes.io/hostname`: points to correct Route53 domain name (the same value set in todo_app.region2_url in [tfvars file](https://github.com/milindchawre/eks-infra/blob/multi-region/infrastructure/db-setup/environments/production.tfvars))
- `ingress.hosts[0].host`: same value as set above in `ingress.external-dns.alpha.kubernetes.io/hostname`

_*Note:* Most of the values listed here will be obtained after running the [eks-infra code (multi-region branch)](https://github.com/milindchawre/eks-infra/tree/multi-region)._