# Turnserver
[Turnserver](https://github.com/mrballcb/turn-server-docker-build)

Uploaded to a public Dockerhub repo at [Dockerhub Turnserver](https://hub.docker.com/r/mrballcb/turnserver/)
It should also auto build on [Dockerhub Turnserver AutoBuild(https://hub.docker.com/r/mrballcb/turn-server-docker-build/)

## Chart Details
This chart will do the following:

* Deploy a configurable number of turn servers from the mrballcb/turnserver repo on Dockerhub. (Due to a session affinity issue, it needs to just be 1.)
* Create an ELB in AWS for the containers via a Kube service (w/ TLS) using a certificate stored in AWS Certificate Manager.

Manual step required:

* Create a friendly DNS CNAME that points to the ELB.

## Build Chart Dependencies
No other docker images are required.

## Installing the chart
To install the chart:
```bash
$ helm install . \
       -f values-STACKID.yaml \
       --name dev-turn \
       --namespace turn \
       --set image.repository=FOO/turnserver

#### Method 1:
The values-*.yaml files are excluded from the repo, so you'll need to copy the values.yaml to values-STACKID.yaml
and modify the defaults.  Expected modifications:

* set the secret to use to get the user/pass combo for Dockerhub
* set the ARN for the certificate for the load balancer to use
* maybe set the uniqueStackId
* maybe set the image.repository or version

#### Method 2:
You may choose to choose to override those same settings using **--set** on the commandline.

## Configuration
The following table lists configurable parameters.

### Turn
| Parameter                   | Description                              | Default                    |
|-----------------------------|------------------------------------------|----------------------------|
| `image.repository`          | Name of Dockerhub repo                   | `mrballcb/turnserver`      |
| `image.tag`                 | Version of image to run                  | `latest`                   |
| `image.repoSecretName`      | Name of Dockerhub repo secret in Kube    | `dockerhub`                |
| `replicas`                  | Number of pods to start                  | `1`                        |
| `service.elbCertficateArn`  | Certificate ARN for AWS ELB              | See values.yaml            |
| `uniqueStackId`             | A unique stack identifier                | None                       |

There are others, but the list above is where you'll most likely find the things you'll want to change.

You can override any of these defaults by:
1. Edit the values.yaml then use helm install ...
1. Copy values.yaml to values-foo.yaml, then use helm install -f values-foo.yaml ...
1. Override on the commandline with helm install --set key=value[,key=value] ...

## Notes
* The helm chart automatically creates the ELB, but only creates an A record that points to it if the Kube
cluster has configured and is running **external-dns** pod.  If not, it must be created manually.

