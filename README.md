# Advanced K8S management using Flux

In this course we will learn how to manage your [K8S](https://kubernetes.io/) cluster in a professional way using [Flux](https://fluxcd.io/).

This course is completly free and open source, and you can also view the entire course in this [link](https://www.academeez.com/en/course/kubernetes/flux)

## Lessons

Here are the lessons we are going to learn in this course. Clicking the link to the lesson will point you to the lesson article and video lesson.

### [0. Course intro](https://www.academeez.com/en/course/kubernetes/flux)

Things you need to know before we start our journey. Requirements, Prerequisites, etc.

### [1. Installing Flux](https://www.academeez.com/en/course/kubernetes/flux/installation)

In this lesson we will Install Flux on our K8S cluster

### [2. kustomize-controller](https://www.academeez.com/en/course/kubernetes/flux/kustomize-controller)

When we installed Flux, gitops operators were installed as well. We will go over each of those operators, starting with `kustomize-controller` which collects manifests and keeps our cluster synced with the state described in those manifests.

### [3. helm-controller](https://www.academeez.com/en/course/kubernetes/flux/helm-controller)

No more using the `helm` command to altar our k8s cluster state. Installing helm charts is done in a declarative gitops way using flux [helm-controller](https://www.academeez.com/en/course/kubernetes/flux/helm-controller). In this lesson we will learn about `helm-controller` by installing our first chart - [nginx ingress controller](https://docs.nginx.com/nginx-ingress-controller)

## Repo structure

Since all this course is using the same repo, and we still want you to examine source code for each lesson, therefor each lesson will have a branch created.

For example to see the source code for lesson one go to the branch [`lesson-01`](https://github.com/ywarezk/academeez-k8s-flux/tree/lesson-01)
