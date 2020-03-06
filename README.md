# terraform-module-kubernetes-redis-exporter

Terraform module to deploy redis_exporter on kubernetes.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| kubernetes | >= 1.10.0 |
| random | >= 2.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| annotations | Additionnal annotations that will be merged on all resources. | `map` | `{}` | no |
| deployment\_annotations | Additionnal annotations that will be merged on the deployment. | `map` | `{}` | no |
| deployment\_labels | Additionnal labels that will be merged on the deployment. | `map` | `{}` | no |
| deployment\_name | Name of the deployment that will be create. | `string` | `"redis-exporter"` | no |
| deployment\_template\_annotations | Additionnal annotations that will be merged on the deployment template. | `map` | `{}` | no |
| deployment\_template\_labels | Additionnal labels that will be merged on the deployment template. | `map` | `{}` | no |
| enabled | Whether or not to enable this module. | `bool` | `true` | no |
| environment\_variables | Map of key/values that will be injected as environement variables to configure redis-exporter. More information [here](https://github.com/oliver006/redis_exporter). | `map` | `{}` | no |
| image\_name | Name of the docker image to use. | `string` | `"oliver006/redis_exporter"` | no |
| image\_pull\_policy | Image pull policy on the main container. | `string` | `"IfNotPresent"` | no |
| image\_version | Tag of the docker image to use. | `string` | `"latest"` | no |
| labels | Additionnal labels that will be merged on all resources. | `map` | `{}` | no |
| namespace | Namespace in which the module will be deployed. | `string` | `"default"` | no |
| replicas | Number of replicas to deploy. | `number` | `1` | no |
| service\_annotations | Additionnal annotations that will be merged for the service. | `map` | `{}` | no |
| service\_labels | Additionnal labels that will be merged for the service. | `map` | `{}` | no |
| service\_name | Name of the service that will be create | `string` | `"redis-exporter"` | no |

## Outputs

| Name | Description |
|------|-------------|
| deployment\_name | Name of the deployment created by the module. |
| prometheus\_alert\_groups | List of alerts that you can import in prometheus. |
| service\_name | Name of the service created by the module. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
