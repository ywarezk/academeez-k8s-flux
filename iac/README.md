# academeez course IAC - OpenTofu/Terragrunt

This folder is a boilerplate for IAC using OpenTofu and Terragrunt to create managed kubernetes infrastructure on GCP. The folder also represents [academeez free IAC course](https://www.academeez.com/courses/terraform). Follow academeez IAC course and you will understand every aspect of this repository.

The course is also available as a [youtube course](https://www.youtube.com/playlist?list=PLEOJnF1eepkYPGzH278CQisotkZu-Bo0m)

## Lessons

Here is a list of academeez IAC lessons. After following these lessons you will understand every aspect in the `iac/` folder.

### Lesson 1 - Course introduction

In this lesson we are explaining everything you need to know about academeez IAC course. You will get answers to questions like:

- What technologies are we going to cover?
- What experience and prerequisites I need to this course?

The lesson is available [here](https://www.academeez.com/courses/terraform).

### Lesson 2 - Setup development environment with mise

In this lesson we will install [mise](https://mise.jdx.dev/getting-started.html) and use `mise` to set-up our development environment. The full lesson is available [here](https://www.academeez.com/courses/terraform/setup-with-mise).

You also have video tutorial of the lesson:

[![Setup development environment with mise](https://img.youtube.com/vi/my_t3v0agOQ/maxresdefault.jpg)](https://www.youtube.com/watch?v=my_t3v0agOQ)

### Lesson 3 - Introduction to Terragrunt

It's best to split our IAC big project to small mini projects where each one is stored in a seperate state. Unfortunately doing so with Terraform will be hard, but terragrunt which is a small wrapper around Terraform/OpenTofu is perfect for the job.

The full lesson is available [here](https://www.academeez.com/courses/terraform/introduction-to-terragrunt)

You also have a full video tutorial of the lesson:

[![Introduction to Terragrunt](https://img.youtube.com/vi/CBgJ5iTXLFY/maxresdefault.jpg)](https://www.youtube.com/watch?v=CBgJ5iTXLFY)

### Lesson 4 - pre-commit

We configured [pre-commit](https://pre-commit.com/) to help us manage commit hook plugins, those are tasks that we want to run before our commit.

The full lesson is available [here](https://www.academeez.com/courses/terraform/pre-commit)

And you also have a video tutorial explaining about pre-commit configuration:

[![pre-commit](https://img.youtube.com/vi/UrZI2Eic2ms/maxresdefault.jpg)](https://www.youtube.com/shorts/UrZI2Eic2ms)

### Lesson 5 - Security - Permissions, Roles, Groups, Impersonation

In this lesson we learned how to deal with permissions in our team. We assign developers and service accounts to groups, We can provide roles and permissions to group while focusing on PoLP - giving the minimal permissions needed. We also covered impersonation and how developers can impersonate a service account for creating IAC resources.

The full lesson is available [here](https://www.academeez.com/courses/terraform/permissions-roles-groups-impersonation)

And the video tutorial of this lesson can be found here:

[![Security - Permissions, Roles, Groups, Impersonation](https://img.youtube.com/vi/78-r6wQFCmI/maxresdefault.jpg)](https://www.youtube.com/watch?v=78-r6wQFCmI)

### Lesson 6 - Terragrunt Unit

A Unit represents a single instance of infrastructure managed by Terragrunt. Here are a few characteristics:

- It has its own state
- It is in a folder which has a `terragrunt.hcl` file
- It is often minimalistic and represents a small piece of infrastructure.
- A unit can interact with another unit using dependency blocks.

The full lesson is available [here](https://www.academeez.com/courses/terraform/unit)

And the video tutorial of this lesson can be found here:

[![Terragrunt Unit](https://img.youtube.com/vi/GZMh3SsQOdo/maxresdefault.jpg)](https://www.youtube.com/watch?v=GZMh3SsQOdo)

## Repo structure

Each lesson will be placed in a PR, link to the PR will be available in the lesson page.
