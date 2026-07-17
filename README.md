# Nix Flake · Node.js Dev Template

> purr · git-hooks · nodejs · corepack · bun · direnv · nix-flake

Nix flake template for Node.js development — reproducible dev shell with Node.js runtime, Bun, Deno, unified package manager CLI (ni), and git pre-commit hooks. Built on [purr](https://flakehub.com/f/nixcafe/purr) and [git-hooks.nix](https://flakehub.com/f/cachix/git-hooks.nix).

Part of the [develop-templates](https://github.com/nixcafe/develop-templates) collection (`nix flake init`-ready).

## Quick Start

### `nix flake init`

```bash
nix flake init -t "github:nixcafe/develop-templates#node" --refresh
```

Register an alias:
```bash
nix registry add beans "github:nixcafe/develop-templates"
nix flake init -t beans#node
```

> **Tip**: With [cattery-modules](https://github.com/nixcafe/cattery-modules), `beans` is pre-registered.

### Create from Template

```bash
gh repo create my-node-project --template nixcafe/node --clone
```

### Enter the Dev Shell

```bash
direnv allow
# bootstrap & install deps
ni init
ni add express
```

## What's Inside

| Tool | Purpose |
|------|---------|
| `node` | Node.js runtime |
| `corepack` | pnpm / yarn package manager manager |
| `ni` / `nr` / `nlx` / `nun` / `nci` | [@antfu/ni](https://github.com/antfu/ni) — unified package manager CLI |
| `bun` | Bun JavaScript runtime & bundler |
| `deno` | Deno JavaScript/TypeScript runtime |

`node_modules/.bin` is auto-added to `PATH` when it exists.

## Customizing

### Enable pre-commit hooks

Edit `develop/checks/git-hooks/default.nix` — all hooks are disabled by default:

```nix
hooks = {
  biome.enable = true;
  # eslint.enable = true;
  # denofmt.enable = true;
};
```

See [git-hooks.nix](https://github.com/cachix/git-hooks.nix) for the full hook catalog.

### Pin a specific Node.js version

```nix
# flake.nix
outputs = inputs:
  inputs.purr.lib.mkFlake {
    inherit inputs;
    src = ./develop;
    override = final: prev: { nodejs = final.nodejs_22; };
  };
```

### Add system packages

```nix
# develop/shells/default/default.nix
packages = with pkgs; [
  node
  corepack
  ffmpeg
  openssl
];
```

## Project Structure

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
