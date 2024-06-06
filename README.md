# APP DEPLOYMENT Chart

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

### Description:
Generic Helm chart to deploy all kind of services in Vedantu.


## Installing the Chart
To test the chart syntax and values:
   ```
   cd <path/to/chart>
   helm install release-name --dry-run --debug .
   ```

To install the chart with the release name my-application in default namespace:


    helm upgrade --install my-application app_deployment/ -f values.yaml \
    --set app.name=my-application \
    --set app.team=dummy \
    --set image.tag=v1  \
    --namespace default

> `values.yaml` Optional file to pass to override/supply configs


For Canary Deployment :

- keep app labels same


    helm upgrade --install my-application-canary app_deployment/ -f values.yaml \
    --set app.name=my-application \
    --set app.release=canary \
    --set app.team=dummy \
    --set image.tag=v2  \
    --namespace default \

# Configuration

Manage your deployment configurations and environment variables from [config-service].  
> Add only those required variables which you want to override, in the config service. 

#### Variables to be set from command line while installing 
| Parameter            | Description                                                                 | Default                                                          |
|:---------------------|:----------------------------------------------------------------------------|:-----------------------------------------------------------------|
| app.name             | Name of the service                                                         | `null`                                                           |
| app.release          | Specify release of the service - stable or canary                           | `stable`                                                         |
| app.team             | Team owning this service                                                    | `SRE`                                                            |
| image.repository     | Image repository for the application                                        | `617558729962.dkr.ecr.ap-south-1.amazonaws.com/vedantu-registry` |
| image.bucketName     | Name of the Application Image                                               | `same as Gitlab Project Name`                                    |
| image.tag            | Tag of the application Image                                                | `f24cd18ca0b7971c37e529e567825728011e737f`                       |
| image.pullPolicy     | Pull policy for the application image                                       | `Always`                                                         |
| deployment.podLabels | Additional Labels to add in deployment. <br/>Ex. `deployment.podLables.A=B` | `{ }`                                                            |


#### Variables to be fetched from Config Service
> DEPLOYMENT_COMMAND is required for all service

| Parameter                                                                                       | Description                                                                                                        | Default                                                                                                |
|:------------------------------------------------------------------------------------------------|:-------------------------------------------------------------------------------------------------------------------|:-------------------------------------------------------------------------------------------------------|
| DEPLOYMENT_COMMAND                                                                              | Command to start the service                                                                                       | `service`                                                                                              |
| CONTAINER_PORT                                                                                  | Ports for primary container                                                                                        | `8080`                                                                                                 |
| KUBERNETES_REPLICAS                                                                             | Replicas to be created                                                                                             | `1`                                                                                                    |
| HTTP_PROBES_ENABLED                                                                             | The livenessnes and readiness probe enabled                                                                        | `true`                                                                                                 |
| HTTP_PROBE_PATH                                                                                 | The livenessness and readiness probe path                                                                          | `/ping`                                                                                                |
| RESOURCES_REQUESTS_CPU<br/> RESOURCES_REQUESTS_MEMORY<br/>  RESOURCES_REQUESTS_EPHEMERALSTORAGE | Application pod resource requests                                                                                  | requests:<br>&nbsp;&nbsp;memory: 128Mi<br>&nbsp;&nbsp;cpu: 500m<br>&nbsp;&nbsp;ephemeral-storage: 64Mi |
| RESOURCES_LIMITS_CPU<br/> RESOURCES_LIMITS_MEMORY<br/> RESOURCES_LIMITS_EPHEMERALSTORAGE        | Application pod resource limits                                                                                    | limits:<br>&nbsp;&nbsp;memory: 1G<br>&nbsp;&nbsp;cpu: 1000m<br>&nbsp;&nbsp;ephemeral-storage: 128Mi    |
| HPA_ENABLED                                                                                     | Enable horizontal pod autoscaler                                                                                   | `false`                                                                                                |
| HPA_MIN_REPLICA                                                                                 | Sets minimum replica count when autoscaling is enabled                                                             | `2`                                                                                                    |
| HPA_MAX_REPLICA                                                                                 | Sets maximum replica count when autoscaling is enabled                                                             | `10`                                                                                                   |
| HPA_TARGET_CPU                                                                                  | Target CPU percentage for HPA, <br/> set when autoscaling is enabled                                               | `90`                                                                                                   |
| HPA_TARGET_MEMORY                                                                               | Target Memory percentage for HPA, <br/> set when autoscaling is enabled                                            | `90`                                                                                                   |
| DB_MIGRATION_COMMAND                                                                            | Command for Database Migration (Add Value to enable migration)                                                     | ``                                                                                                     |
| KUBERNETES_ROLLING_UPDATE_MAX_SURGE                                                             | -                                                                                                                  | `1`                                                                                                    |
| KUBERNETES_ROLLING_UPDATE_MAX_UNAVAILABLE                                                       | -                                                                                                                  | `1`                                                                                                    |
| KUBERNETES_ROLLING_UPDATE_MIN_READY_SECONDS                                                     | -                                                                                                                  | `0`                                                                                                    |
| KUBERNETES_SERVICE_NAME                                                                         | service name                                                                                                       | `http`                                                                                                 |
| KUBERNETES_SERVICE_PORT                                                                         | Ports for applications service                                                                                     | `80`                                                                                                   |
| READINESS_INITIAL_DELAY_SECONDS                                                                 | Number of seconds after the container has started before liveness or readiness probes are initiated                | `30`                                                                                                   |
| LIVENESS_INITIAL_DELAY_SECONDS                                                                  | Number of seconds after the container has started before liveness or readiness probes are initiated                | `30`                                                                                                   |
| READINESS_PERIOD_SECONDS                                                                        | How often (in seconds) to perform the probe                                                                        | `5`                                                                                                    |
| LIVENESS_PERIOD_SECONDS                                                                         | How often (in seconds) to perform the probe                                                                        | `5`                                                                                                    |
| READINESS_TIMEOUT_SECONDS                                                                       | Number of seconds after which the probe times out                                                                  | `1`                                                                                                    |
| LIVENESS_TIMEOUT_SECONDS                                                                        | Number of seconds after which the probe times out                                                                  | `1`                                                                                                    |
| READINESS_FAILURE_THRESHOLD                                                                     | When a probe fails, Kubernetes will try failureThreshold times before giving up                                    | `2`                                                                                                    |
| LIVENESS_FAILURE_THRESHOLD                                                                      | When a probe fails, Kubernetes will try failureThreshold times before giving up                                    | `2`                                                                                                    |
| READINESS_SUCCESS_THRESHOLD                                                                     | Minimum consecutive successes for the probe to be considered successful after having failed                        | `1`                                                                                                    |
| LIVENESS_SUCCESS_THRESHOLD                                                                      | Minimum consecutive successes for the probe to be considered successful after having failed                        | `1`                                                                                                    |
| INGRESS_ENABLED                                                                                 | Enable nginx ingress controller (not required if service is on API-gateway)                                        | `false`                                                                                                |
| INGRESS_TYPE                                                                                    | Type of nginx ingress - (`external` or `internal` )                                                                | `internal`                                                                                             |
| INGRESS_PATH_TYPE                                                                               | `ImplementationSpecific`, `Prefix` or `Exact`                                                                      | `ImplementationSpecific`                                                                               |
| INGRESS_PATH                                                                                    | The path option expects a URL path which is used for routing                                                       | `/`                                                                                                    |
| INGRESS_HOSTNAME_DOMAIN <br> INGRESS_HOSTNAME_SUBDOMAIN                                         | set up host name - subdomain.domain eg(subdomain - test <br/> domain - vedantu.com --> hostname- test.vedantu.com) | `.`                                                                                                    |


### What Next:
Onboard your service with [API-Gateway]


### Authors
- [Sameer Prajapati](sameer.prajapati@vedantu.com)
- [Pawan Saini](pawan.saini@vedantu.com)

[API-Gateway]: <https://vedantu.atlassian.net/wiki/spaces/SRE/pages/3366420705/API+Gateway>
[config-service]: <https://config.vedantu.in>