# academeez course - Flux CD

In this free academeez course you will learn how to manage your kubernetes cluster state with [Flux CD](https://fluxcd.io/) in a declarative way. The full course is available [here](https://www.academeez.com/courses/fluxcd)

The course is also available as a [youtube course in this link](https://www.youtube.com/playlist?list=PLEOJnF1eepkbZKo3AoEX3yzjftC7Ba5Yb)

## Lessons

Here is a list of lessons in academeez Flux course. Each lesson contains step by step guide, video lesson, and code examples.

### Lesson 1 - Course Introduction

Talking about the course, prerequisites, installations.

The lesson is available [here](https://www.academeez.com/courses/fluxcd)

### Lesson 2 - Installing Flux with flux-cli

In this lesson we will install the flux cli and use it to install flux on our kubernetes cluster.

The lesson is available [here](https://www.academeez.com/courses/fluxcd/installation)

Checkout the video tutorial of the lesson:

[![Installing Flux with flux-cli](https://img.youtube.com/vi/vp-oFksFoZs/maxresdefault.jpg)](https://www.youtube.com/watch?v=vp-oFksFoZs)

### Lesson 3 - kustomize controller

When installing flux certain controllers and CRD's will be installed, one of those controllers is the `kustomize-controller`. the `kustomize-controller` will watch for `Kustomization` custom resource, and the resource will point to a folder containing `kustomization.yaml` that points to resources that will be applied to the cluster.

The lesson is available [here](https://www.academeez.com/courses/fluxcd/kustomize-controller)

You also have a video tutorial of the lesson:

[![kustomize controller](https://img.youtube.com/vi/DqXDrAR4cJ4/maxresdefault.jpg)](https://www.youtube.com/watch?v=DqXDrAR4cJ4)

### Lesson 4 - helm controller

No more using the `helm` command to altar our k8s cluster state. Installing helm charts is done in a declarative gitops way using flux [helm-controller](https://fluxcd.io/flux/components/helm/). In this lesson we will learn about `helm-controller` by installing our first chart - [nginx ingress controller](https://docs.nginx.com/nginx-ingress-controller)

The lesson is available [here](https://www.academeez.com/courses/fluxcd/helm-controller)

Video of the helm controller lesson is available here:

[![helm controller](https://img.youtube.com/vi/aD5_OA3IEaA/maxresdefault.jpg)](https://www.youtube.com/watch?v=aD5_OA3IEaA)

### Lesson 5 - Installing Flux with Terraform/OpenTofu

There are a few advantages of installing Flux using infrastructure as code technology like Terraform.  
Especially when you will need to manage more than one cluster.

The lesson is available [here](https://www.academeez.com/courses/fluxcd/installing-flux-terraform-opentofu)

And the full video lesson is here:

[![Installing Flux with Terraform/OpenTofu](https://img.youtube.com/vi/68YcfitcKGI/maxresdefault.jpg)](https://www.youtube.com/watch?v=68YcfitcKGI)

## Repo structure

every lesson will have a dedicated PR for that lesson.
