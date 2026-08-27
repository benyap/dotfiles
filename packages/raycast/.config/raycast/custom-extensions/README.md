# Local Raycast extensions

These extensions are private, machine-local tools. They are developed and installed directly into Raycast and are not intended for publication to the public Raycast Store.

## Prerequisites

- Raycast must be installed and running.
- Node.js and pnpm must be installed. This workspace requires pnpm 10 or newer.
- The Raycast CLI must be available as `ray`.

From this directory, install the workspace dependencies:

```sh
pnpm install
```

## Author an extension

Create a directory under `packages/`, using a short lowercase name:

```sh
mkdir -p packages/my-extension
```

Each extension needs its own `package.json`. Use `packages/timestamp` as the reference. At minimum, define:

- Raycast metadata such as `name`, `title`, `description`, `icon`, `author`, and `commands`.
- A dependency on `@raycast/api`.
- `dev`, `build`, and `lint` scripts.
- A TypeScript entry point for each command in the `src/` directory.

Keep dependency versions exact. The repository `.npmrc` configures pnpm to save exact versions for newly added dependencies:

```sh
pnpm --filter my-extension add @raycast/api
pnpm --filter my-extension add -D typescript
```

After adding or changing dependencies, update the lockfile from the workspace root:

```sh
pnpm install
```

## Develop and build

Run one extension in Raycast development mode:

```sh
pnpm --filter my-extension dev
```

Run all package development commands:

```sh
pnpm dev
```

Build one extension:

```sh
pnpm --filter my-extension build
```

The default build target is the development environment. To build for the production environment, use:

```sh
pnpm --filter my-extension build -- --environment dist
```

`ray build` writes compiled files to its output directory. It does not create a `.ray` bundle for local installation.

Build every extension in the workspace:

```sh
pnpm build
```

Run linting for one extension with `pnpm --filter my-extension lint`.

## Install on this machine

Use Raycast development mode to install and run an extension on this machine:

```sh
pnpm --filter my-extension dev
```

The dev command performs two separate actions:

1. It builds and installs the extension into the local Raycast application.
2. It starts a development watcher that rebuilds the extension as files change.

The extension is available in Raycast without publishing it to the public Store. Stopping the dev command with `Ctrl-C` stops the watcher, but does not uninstall the extension. Raycast keeps the last successfully installed build available, so the extension can still be run afterward.

Restart the dev command after making changes to install an updated build. To remove the extension, delete it from Raycast's extension management interface.
