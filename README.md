# ORY's Documentation Template Repository

## Initialize Documentation

To create a new documentation for a new or existing project, copy the contents
(without `node_modules`) into the project's `./docs` directory. Next you need to
create these files (relative to the project's root directory) directory:

```js
// ./docs/config.js
//
// This file contains the project's name and slug and tag line, for example:
module.exports = {
  projectName: 'ORY Keto',
  projectSlug: 'keto',
  projectTagLine:
    'A cloud native access control server providing best-practice patterns (RBAC, ABAC, ACL, AWS IAM Policies, Kubernetes Roles, ...) via REST APIs.',
  updateTags: [
    {
      image: 'oryd/keto',
      files: ['docs/docs/configure-deploy.md']
    }
  ],
  updateConfig: {
    src: '.schema/config.schema.json',
    dst: './docs/docs/reference/configuration.md'
  }
}
```

```js
// ./docs/sidebar.js
//
// This represents the sidebar navigation, for example:
module.exports = {
  Introduction: ['index', 'install']
}
```

```
// ./docs/src/css/theme.css
// empty file is ok
```

```js
// ./docs/versions.json
// empty object is ok
{
}
```

## Adding Documentation

Next, put your markdown files in `./docs/docs`. You may also want to add the
CircleCI Orb `ory/docs` to your CI config, depending on the project type.

## Update Documentation

Check out [docusaurus-template](https://github.com/ory/docusaurus-template)
using
`git clone git@github.com:ory/docusaurus-template.git docusaurus-template`. It
is important that the directory is named `docusaurus-template`!

Then, make your changes, and run `./update.sh`.
