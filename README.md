# Node.js development template

Nix flake template for Node.js projects. It provides a development shell with Node.js, Corepack, Bun, Deno, and the `ni` package manager wrapper, plus git hooks for commits. The flake is built with [purr](https://flakehub.com/f/nixcafe/purr) and [git-hooks.nix](https://flakehub.com/f/cachix/git-hooks.nix).

This repository is part of the [develop-templates](https://github.com/nixcafe/develop-templates) collection.

## Quick start

Create a project from the template:

```bash
nix flake init -t "github:nixcafe/develop-templates#node" --refresh
```

To use a shorter registry name:

```bash
nix registry add beans "github:nixcafe/develop-templates"
nix flake init -t beans#node
```

If you use [cattery-modules](https://github.com/nixcafe/cattery-modules), the `beans` registry entry already exists.

You can also create a GitHub repository from this template:

```bash
gh repo create my-node-project --template nixcafe-develop/node --clone
```

Enter the development shell and set up the project:

```bash
direnv allow

# Create package.json if the project does not have one yet.
npm init -y

# Install dependencies.
ni

# Add a dependency.
ni express
```

`ni` reads the lockfile to choose npm, pnpm, yarn, Bun, or Deno. If the project has no lockfile, it asks which package manager to use.

## What's included

| Tool | Purpose |
|------|---------|
| `node` | Node.js runtime from `pkgs.nodejs` |
| `corepack` | Package manager shim for pnpm and yarn |
| `ni`, `nr`, `nlx`, `nun`, `nci` | Commands from [@antfu/ni](https://github.com/antfu/ni) |
| `bun` | Bun runtime and bundler |
| `deno` | Deno runtime |

The shell adds `node_modules/.bin` to `PATH` when that directory exists. It also sets `COREPACK_ENABLE_DOWNLOAD_PROMPT=0` and prints the Node.js version when the shell starts.

## Customization

### Enable pre-commit hooks

All hooks are disabled by default. Edit `develop/checks/git-hooks/default.nix` and enable the hooks you need:

```nix
hooks = {
  biome.enable = true;
  # eslint.enable = true;
  # denofmt.enable = true;
};
```

See [git-hooks.nix](https://github.com/cachix/git-hooks.nix) for the full hook list.

### Pin a specific Node.js version

purr loads overlays from `develop/overlays/` and applies them to `pkgs`. Create `develop/overlays/node/default.nix`:

```nix
final: _prev: {
  nodejs = final.nodejs_22;
}
```

The shell uses `pkgs.nodejs`, so the version printed at startup also changes.

### Add system packages

Edit `develop/shells/default/default.nix` and add entries to `packages`:

```nix
packages = with pkgs; [
  node
  corepack
  ni
  bun
  deno
  ffmpeg
  openssl
];
```

## Project structure

```
.
├── flake.nix
├── .envrc
├── .gitignore
└── develop/
    ├── shells/
    │   └── default/
    │       └── default.nix
    └── checks/
        └── git-hooks/
            └── default.nix
```

## Useful commands

```bash
direnv allow        # load the development shell
nix develop         # load the shell without direnv
nix flake check     # run the flake checks, including the git hooks
ni                  # install dependencies
ni express          # add a dependency
```
