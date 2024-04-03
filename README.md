# pretext-build-action

Github action to build PreTeXt source. Include in a github workflow to build a PreTeXt document.

# Usage

For the latest version:

```yml
- name: Build with PreTeXt
  uses: siefkenj/pretext-build-action@main
```

## Full Example

Below is a full example for building a pretext project for `web`. This example assumes
that your pretext project is located in `my_project` and that `my_project/project.ptx`
lists `web` as a build target.

```yml
name: Build and Deploy to Github Pages
on:
    # Runs both on pull requests and when a pull request is merged.
    push:
        branches: ["master", "main"]
    pull_request:
        branches: ["master", "main"]

jobs:
    # This job builds the book. You can download the resulting build "artifact" by
    # navigating to your actions manager in Github, selecting this run, and clicking
    # "download artifact" on the "webpage" artifact.
    build:
        runs-on: ubuntu-latest

        steps:
            - name: Checkout source
              uses: actions/checkout@v4

            - name: Build with PreTeXt
              uses: siefkenj/pretext-build-action@main
              with:
                  project-root: "my_project"
                  output-dir: "."

            - name: Bundle output/web as artifact
              uses: actions/upload-artifact@v4
              with:
                  name: webpage
                  path: output/web

    # This job deploys the artifact built in the previous job to Github pages.
    deploy:
        runs-on: ubuntu-latest
        # only deploy to github pages if we have merged into main or master
        if: github.event_name == 'push' &&  (github.ref == 'refs/heads/main' || github.ref == 'refs/heads/master')
        needs: build
        permissions:
            contents: read
            pages: write
            id-token: write
        concurrency:
            group: "page"
            cancel-in-progress: false
        environment:
            name: github-pages
            url: ${{ steps.deployment.outputs.page_url }}
        steps:
            - name: Download website artifact
              uses: actions/download-artifact@v4
              with:
                  name: website
                  path: website
            - name: Setup Pages
              uses: actions/configure-pages@v4
            - name: Upload artifact
              uses: actions/upload-pages-artifact@v3
              with:
                  path: "./website"
            - name: Deploy to Github Pages
              id: deployment
              uses: actions/deploy-pages@v4
```

# Inputs

```yml
- name: Build with PreTeXt
  uses: siefkenj/pretext-build-action@main
  with:
      # (optional) Location (directory) of project.ptx in your source tree
      project-root:
      # (optional) Command for the CLI to run. E.g. `build web` will result in `pretext build web` being run on your source
      pretext-command:
      # (optional) Location (directory) where the `output/` directory should be copied
      output-dir:
      # (optional; advanced) Location of `pretext/` for using a custom version of `pretext/pretext`
      pretext-location:
      # (optional; advanced) SHA commit for using a custom version of `pretext/pretext`
      pretext-commit:
```
