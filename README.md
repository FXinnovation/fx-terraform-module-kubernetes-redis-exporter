# terraform-module-kubernetes-redis-exporter

Terraform module to deploy redis_exporter on kubernetes.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| kubernetes | >= 1.10.0 |
| random | >= 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| kubernetes | >= 1.10.0 |
| random | >= 2.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
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
| prometheus\_alert\_groups\_rules\_annotations | Map of strings that will be merge on all prometheus alert groups rules annotations. | `map` | `{}` | no |
| prometheus\_alert\_groups\_rules\_labels | Map of strings that will be merge on all prometheus alert groups rules labels. | `map` | `{}` | no |
| replicas | Number of replicas to deploy. | `number` | `1` | no |
| service\_annotations | Additionnal annotations that will be merged for the service. | `map` | `{}` | no |
| service\_labels | Additionnal labels that will be merged for the service. | `map` | `{}` | no |
| service\_name | Name of the service that will be create | `string` | `"redis-exporter"` | no |

## Outputs

| Name | Description |
|------|-------------|
| deployment\_annotations | Map of annotations that are configured on the deployment. |
| deployment\_labels | Map of labels that are configured on the deployment. |
| deployment\_name | Name of the deployment created by the module. |
| deployment\_template\_annotations | Map of annotations that are configured on the deployment. |
| deployment\_template\_labels | Map of labels that are configured on the deployment. |
| grafana\_dashboards | List of strings, each one representing a separate grafana dashboard. |
| image\_name | Name of the docker image used for the redis-exporter container. |
| image\_pull\_policy | Image pull policy defined on the redis-exporter container. |
| image\_version | Tag of the docker image used for the redis-exporter container. |
| namespace | Name of the namespace in which the resources have been deployed. |
| prometheus\_alert\_groups | List of maps representing prometheus alerts. |
| selector\_labels | Map of the labels that are used as selectors. |
| service\_annotations | Map of annotations that are configured on the service. |
| service\_labels | Map of labels that are configured on the service. |
| service\_name | Name of the service created by the module. |
| service\_port | Port number of the service port. |
| service\_port\_name | Name of the service port. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
