# Google Cloud Platform (GCP)

GCP infrastructure for the academeez IAC course.

## Structure

| Folder | Purpose |
|--------|---------|
| [`catalog/`](catalog/) | Reusable Terragrunt units and stacks |
| [`live/`](live/) | Live environment that consumes catalog units |

Start in [`live/config/`](live/config/) to copy example config files, then run Terragrunt from the relevant unit under `live/`.
