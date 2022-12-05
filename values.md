# Variables

### Values in github workflow
Make sure to set appropriate values in your [github workflow](.github/workflows/build-deploy.yml).
- `AWS_REGION`: points to correct aws region
- `ECR_REPO`: specify correct AWS ECR repo
- `IAM_ASSUME_ROLE`: points to correct IAM role which will be assumed by Github OIDC client to access AWS resources
- `CLUSTER_NAME`: specify correct EKS cluster name

### Values in values-prod.yaml
Make sure to set appropriate values in [values-prod.yaml](helm-chart/todo-service/values-prod.yaml) of your application helm chart.
- `image.repository`: points to correct aws ecr repo
- `rails_env`: set correct rails environment name (development, porduction)
- `ingress.alb.ingress.kubernetes.io/certificate-arn`: points to correct ACM certificate ARN
- `ingress.external-dns.alpha.kubernetes.io/hostname`: points to corrct Route53 domain name
- `ingress.hosts[0].host`: points to correct Route53 domain name
