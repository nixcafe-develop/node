# Nix Flake Node.js Development Template

Nix flake template for Node.js development environment — a reproducible, declarative dev shell with Node.js, npm/pnpm/yarn (corepack), [@antfu/ni](https://github.com/antfu/ni), Bun, Deno, and git pre-commit hooks. Zero-config, ready in one command.

Use this template to bootstrap a new Node.js project with a Nix flake-based development environment. No global installs, no version conflicts — everything pinned by `flake.lock`.

Part of the [develop-templates](https://github.com/nixcafe/develop-templates) collection (`nix flake init` ready).

## Usage

### Quick Start with `nix flake init`

```bash
nix flake init -t "github:nixcafe/develop-templates#node" --refresh
```

To shorten future commands, add a [Nix registry](https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-registry) entry:

```bash
nix registry add beans "github:nixcafe/develop-templates"
nix flake init -t beans#node
```

> **Tip**: If you use [cattery-modules](https://github.com/nixcafe/cattery-modules), `beans` is pre-registered — just run `nix flake init -t beans#node`.

### Create a New Repository from This Template

```bash
gh repo create my-project --template nixcafe/node --clone
```

Or click **"Use this template"** → **"Create a new repository"** on [GitHub](https://github.com/nixcafe/node).

### Enter the Dev Shell & Start Coding

```bash
direnv allow        # auto-load flake on cd
# or without direnv:
nix develop

ni init             # bootstrap package.json
ni add express      # install dependencies
```

## What's Inside

| Tool | Purpose |
|------|---------|
| `node` | Node.js runtime |
| `corepack` | pnpm / yarn package manager manager |
| `ni` / `nr` / `nlx` / `nun` / `nci` | [@antfu/ni](https://github.com/antfu/ni) — unified package manager CLI |
| `bun` | Bun JavaScript runtime & bundler |
| `deno` | Deno JavaScript/TypeScript runtime |

`node_modules/.bin` is automatically added to `PATH` when the directory exists.

## Customizing the Dev Shell

### Enable Pre-commit Hooks (Linting, Formatting)

Edit `develop/checks/git-hooks/default.nix`:

```nix
hooks = {
  biome.enable = true;
  # eslint.enable = true;
  # denofmt.enable = true;
};
```

See [git-hooks.nix](https://github.com/cachix/git-hooks.nix) for the full hook list.

### Pin a Specific Node.js Version

```nix
# flake.nix
outputs = inputs:
  inputs.purr.lib.mkFlake {
    inherit inputs;
    src = ./develop;
    override = final: prev: { nodejs = final.nodejs_22; };
  };
```

### Add Extra System Packages

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
├── flake.nix                        # Flake entry (inputs & mkFlake)
├── .envrc                           # direnv: auto-load flake
├── develop/
│   ├── shells/default/default.nix   # Dev shell definition
│   └── checks/git-hooks/default.nix # Pre-commit hook config
└── .gitignore
```
