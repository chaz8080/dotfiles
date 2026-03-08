# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A macOS-focused dotfiles repository using **Dotbot** with the **dotbot-brew** plugin for configuration management. It manages terminal emulators, AI tools, Kubernetes tooling, keyboard customization, and development environment configs.

## Key Commands

```bash
./install                    # Run Dotbot to create all symlinks, install brew packages, and clone/update superpowers
task nuke-neovim             # Clear neovim cache/state (requires `task` CLI)
bash scripts/macos/defaults.sh  # Apply macOS system preferences (untested — review before running)
```

## Architecture

**Dotbot** is the core. The `install` script bootstraps dotbot via git submodules (`dotbot/` and `dotbot-brew/`), then processes `install.conf.yaml` which:
1. Cleans broken symlinks from `~`
2. Clones/updates `obra/superpowers` skills repo to `~/github/obra/superpowers`
3. Creates symlinks for all tool configs

### Directory → Symlink Target Pattern

| Directory | Links to | Purpose |
|-----------|----------|---------|
| `alacritty/` | `~/.config/alacritty/` | Terminal (Catppuccino theme) |
| `ghostty/` | `~/.config/ghostty/` | Terminal (GitHub Dark HC) |
| `karabiner/` | `~/.config/karabiner/` | Keyboard remapping |
| `logseq/` | `~/.logseq/config/` | Note-taking with Ollama integration |
| `continue/` | `~/.continue/config.json` | Continue.dev AI coding assistant |
| `ai-tools/opencode.json` | `~/.config/opencode/opencode.json` | OpenCode config |
| `ai-tools/skills/` | `~/.config/opencode/skills/` | Custom AI skills (e.g., k8s-workflows) |
| `ai-tools/prompts/` | OpenCode commands + VS Code prompts | Shared prompt files |

### AI Tool Skill Wiring

Superpowers skills from `~/github/obra/superpowers/skills/` are symlinked to three locations for tool discovery:
- `~/.claude/skills/` (Claude Code)
- `~/.copilot/skills/` (GitHub Copilot)
- `~/.config/opencode/skills/superpowers` (OpenCode — single directory link)

When adding a new superpowers skill, add symlink entries for all three tools in `install.conf.yaml`. Note: Claude/Copilot need individual per-skill symlinks while OpenCode uses a single directory link.

### Commented-Out Sections in install.conf.yaml

Several sections are commented out but preserved for optional use: Homebrew auto-install, oh-my-zsh setup, Brewfile, tmux, neovim linking, Firefox CSS. These are intentionally disabled — don't uncomment without asking.

## Adding a New Tool Config

1. Create a directory (e.g., `mytool/`) with the config files
2. Add a `link` entry in `install.conf.yaml` mapping to the target location
3. Run `./install` to apply

## Conventions

- Dotbot link entries use `relink: true` and `force: true` by default
- Config directories use `create: true` and `glob: true` for recursive linking
- The repo expects Homebrew and the tools themselves are already installed — dotbot only manages config files and symlinks
- `karabiner/automatic_backups/` contains auto-generated backups; don't manually edit these
