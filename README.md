# Nix Flake · Node.js Dev Template

A reproducible, declarative Node.js dev shell powered by [purr](https://github.com/nixcafe/purr) + [git-hooks.nix](https://github.com/cachix/git-hooks.nix). One-shot init, zero global cruft.

`nix` `node` `npm` `pnpm` `yarn` `bun` `deno` `corepack` `ni` `git-hooks` `eslint` `biome` `denofmt` `direnv` `purr` `flake` `reproducible` `template`

Part of the [develop-templates](https://github.com/nixcafe/develop-templates) collection (`nix flake init`-ready).

## Usage

```bash
# initialize a project from the template
nix flake init -t "github:nixcafe/develop-templates#node" --refresh

# or create a full repo
gh repo create my-project --template nixcafe/node --clone

# enter the shell (auto-loads via direnv if .envrc is present)
direnv allow
# or without direnv:
nix develop

# bootstrap & install deps
ni init
ni add express
```

> **Tip**: Register a short alias — `nix registry add beans "github:nixcafe/develop-templates"` — then `nix flake init -t beans#node`. If you use [cattery-modules](https://github.com/nixcafe/cattery-modules), `beans` is pre-registered.

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
