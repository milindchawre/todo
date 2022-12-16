# todo app

### Intro
This is the code for a sample todo application written in ruby which uses either a mysql or postgres db.

### Steps to deploy
The resources can be deployed either [manually](#manually) or [using github actions](#using-github-actions). Prior to the deployment you need to be [prepared](#preparations).

### Preparations
Make sure the values in [values-seoul-prod.yaml](helm-chart/todo-service/values-seoul-prod.yaml), [values-osaka-prod.yaml](helm-chart/todo-service/values-osaka-prod.yaml) and [github worflow](.github/workflows/build-deploy-multi-region.yml) are appropriate before proceeding to the deployment. Use [this guide](values.md) to set appropriate values.

### Using github actions
This app can be deployed on kubernetes cluster using [this github workflow](.github/workflows/build-deploy-multi-region.yml).

### Post Deployment
Once you deploy the app, create AWS WAF rule for DDoS protection (rate limit rule) by following [this guide](https://aws.amazon.com/premiumsupport/knowledge-center/waf-mitigate-ddos-attacks/) and attach this WAF to Application load balancer created by your application's ingress resource.

### Manual Deployment
You can manually deploy this app on kubernetes cluster using `helm` tool or you can locally run this app on your workstation as mentioned below.

Run with mysql
```
docker run --rm -p 3306:3306 -e MYSQL_ROOT_HOST=% -e MYSQL_ROOT_PASSWORD=123456 mysql/mysql-server
export DATABASE_URL=mysql2://root:123456@127.0.0.1:3306/todo_app

bundle install
bundle exec rake db:setup
rails s
```


Run with postgresql
```shell
docker run --rm -p 5432:5432 -e POSTGRES_PASSWORD=123456 postgres
export DATABASE_URL=postgresql://postgres:123456@127.0.0.1:5432/todo_app

bundle install
bundle exec rake db:setup
rails s
```
