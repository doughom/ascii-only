# ASCII Only

GitHub Action to ensure that changed files only contain ASCII characters.

## Usage

```yaml
---
name: Lint

on:
  pull_request:
    branches:
      - main

jobs:
  ascii-only:
    name: ASCII Only
    runs-on: ubuntu-24.04

    permissions:
      contents: read

    steps:
      - name: Checkout
        uses: actions/checkout@v6
        with:
          fetch-depth: 0
          persist-credentials: false

      - name: ASCII Only
        uses: doughom/ascii-only@v0.1.0
```
