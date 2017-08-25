# Turnserver
[Turnserver](https://github.com/mrballcb/turn-server-docker-build)

Uploaded to a private Dockerhub repo at [Dockerhub Turnserver](https://hub.docker.com/r/mrballcb/turnserver/)

## Chart Details
This chart will do the following:

* Deploy a configurable number of turn servers from the mrballcb/turnserver repo on Dockerhub
* Create an ELB in AWS for the containers via a Kube service (w/ TLS)

## Build Chard Dependencies
None

## Installing the chart
To install the chart:
```bash
$ helm install . \
       -f values-STACKID.yaml \
       --name dev-turn \
       --namespace turn \
       --set image.repository=FOO/turnserver

The values-*.yaml files are excluded from the repo, so you'll need to slightly modify the default values.yaml
to set the secret to use to get the user/pass combo for Dockerhub, the ARN for the certificate for the load
balancer to use, and maybe set the uniqueStackId and image.repository (so it doesn't have to be specified on
the commandline).

## Configuration
The following table lists configurable parameters.

### Turn
| Parameter                   | Description                              | Default                    |
|-----------------------------|------------------------------------------|----------------------------|
| `image.repository`          | Name of Dockerhub repo                   | `mrballcb/turnserver`      |
| `image.tag`                 | Version of image to run                  | `latest`                   |
| `image.repoSecretName`      | Name of Dockerhub repo secret in Kube    | `dockerhub`                |
| `replicas`                  | Number of pods to start                  | `2`                        |
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

