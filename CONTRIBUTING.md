## Development Setup with mise

This repository uses [mise](https://mise.jdx.dev/) (formerly rtx) to manage tool versions.

### Prerequisites

Install mise if you haven't already:

- macOS: `brew install mise`
- Linux: `curl https://mise.run | sh`
- Or see [mise installation docs](https://mise.jdx.dev/getting-started.html)

### Setup

1. Install the required tools:

   ```bash
   mise install
   ```

2. Activate the mise environment in your shell:

   ```bash
   eval "$(mise activate zsh)"  # for zsh
   # or
   eval "$(mise activate bash)"  # for bash
   ```

   Alternatively, add this to your shell configuration file (`.zshrc` or `.bashrc`) to activate mise automatically.

3. Install pre-commit hooks:
   ```bash
   pre-commit install
   ```

The repository will automatically use the correct versions of:

- OpenTofu (1.10.7)
- Terragrunt (0.93.13)
- pre-commit (4.5.0)
