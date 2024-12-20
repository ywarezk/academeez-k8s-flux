# Advanced K8S management using Flux

This Repo is meant to be a starter kit for managing organizations mono repository that contains
- IAC (Terraform/OpenTofu)
- Terragrunt
- Managed K8S
- FluxCD

The starter kit is opinionated to some degree.
We do focus on best practice so the aim here is to create a kit that can for the basis of managing large projects with large teams.

Every aspect of this repo is documented in [this academeez course](https://www.academeez.com/courses/kubernetes/flux).

In the course we will learn how to manage your [K8S](https://kubernetes.io/) cluster in a professional way using [Flux](https://fluxcd.io/).

The course and this repo are completly free and open source (MIT Licensed)

## Lessons

Here are the lessons we are going to learn in this course. Clicking the link to the lesson will point you to the lesson article and video lesson.

### [0. Course intro](https://www.academeez.com/courses/kubernetes/flux)

Things you need to know before we start our journey. Requirements, Prerequisites, etc.

### [1. Installing Flux](https://www.academeez.com/courses/kubernetes/flux/installation)

In this lesson we will Install Flux on our K8S cluster

[![Install flux using cli](https://img.youtube.com/vi/vp-oFksFoZs/0.jpg)](https://www.youtube.com/watch?v=vp-oFksFoZs)

### [2. kustomize-controller](https://www.academeez.com/courses/kubernetes/flux/kustomize-controller)

When we installed Flux, gitops operators were installed as well. We will go over each of those operators, starting with `kustomize-controller` which collects manifests and keeps our cluster synced with the state described in those manifests.

[![kustomize-controller](https://img.youtube.com/vi/DqXDrAR4cJ4/0.jpg)](https://www.youtube.com/watch?v=DqXDrAR4cJ4)

### [3. helm-controller](https://www.academeez.com/courses/kubernetes/flux/helm-controller)

No more using the `helm` command to altar our k8s cluster state. Installing helm charts is done in a declarative gitops way using flux [helm-controller](https://www.academeez.com/en/course/kubernetes/flux/helm-controller). In this lesson we will learn about `helm-controller` by installing our first chart - [nginx ingress controller](https://docs.nginx.com/nginx-ingress-controller)

[![helm-controller](https://img.youtube.com/vi/aD5_OA3IEaA/0.jpg)](https://www.youtube.com/watch?v=aD5_OA3IEaA)

### [4. Installing FluxCD with Terraform/OpenTofu](https://www.academeez.com/courses/kubernetes/flux/installing-flux-terraform-opentofu)

There are a few advantages of installing Flux using infrastructure as code technology like Terraform.  
Especially when you will need to manage more than one cluster.

[![Installing FluxCD with Terraform/OpenTofu](https://github.com/ywarezk/academeez/blob/main/src/content/docs/courses/kubernetes/flux/installing-flux-terraform-opentofu/thumbnail.png?raw=true)](https://www.youtube.com/watch?v=68YcfitcKGI)

### [5. Introduction to Terragrunt](https://www.academeez.com/courses/kubernetes/flux/introduction-to-terragrunt)

It's best to split our IAC big project to small mini projects where each one is stored in a seperate state.
Unfortunately doing so with Terraform will be hard, but terragrunt which is a small wrapper around Terraform/OpenTofu is perfect for the job.

[![Introduction to Terragrunt](https://github.com/ywarezk/academeez/blob/main/src/content/docs/courses/kubernetes/flux/introduction-to-terragrunt/thumbnail.png?raw=true)](https://www.youtube.com/watch?v=CBgJ5iTXLFY)

## Repo structure

Since all this course is using the same repo, and we still want you to examine source code for each lesson, therefor each lesson will have a branch created.

For example to see the source code for lesson one go to the branch [`lesson-01`](https://github.com/ywarezk/academeez-k8s-flux/tree/lesson-01)
