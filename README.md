# dotfiles

Cross-platform dotfiles managed with [chezmoi](https://chezmoi.io).
Supports macOS (Homebrew) and Linux (apt).

## New machine

1. Install chezmoi:
   - macOS: `brew install chezmoi`
   - Linux: `sh -c "$(curl -fsLS get.chezmoi.io)"`
2. Pull and apply:
   ```bash
   chezmoi init --apply https://github.com/Shiv-SB/dotfiles.git
   ```
   This writes the config and runs the bootstrap scripts (packages,
   oh-my-zsh + plugins, LazyVim plugin sync).
3. Set up the things that are deliberately **not** in the repo:
   - `gh auth login`
   - Generate or copy an SSH key to `~/.ssh/id_ed25519`
   - `gopass` (store path is machine-local)

## Daily workflow

Edit a managed file through chezmoi so the change is recorded in the source repo:

```bash
chezmoi edit ~/.zshrc      # or any managed path
chezmoi diff               # review what would change
chezmoi apply              # write it to $HOME
chezmoi cd                 # enter the source repo
git add -A && git commit -m "..." && git push
```

Pull changes made on another machine:

```bash
chezmoi update             # git pull + apply
```

## What is managed

| Path | Notes |
| --- | --- |
| `~/.zshrc` | templated: OS-specific aliases, `$HOME` paths |
| `~/.gitconfig` | templated: name/email resolved by hostname |
| `~/.zshenv`, `~/.p10k.zsh`, `~/.tmux.conf` | verbatim |
| `~/.iterm-startup.sh` | macOS only |
| `~/.config/starship.toml` | verbatim |
| `~/.config/{btop,micro,htop,spotify-player,chess-tui}/` | verbatim |
| `~/.config/nvim/` | LazyVim; plugins installed by script |
| `~/.config/opencode/` | `opencode.jsonc`, `tui.json`, `lsp-install-decisions.json` |
| `~/.ssh/config` | config only — never keys |

## Machine-specific values

- **Identity** lives in `.chezmoidata/identity.yaml`. `default` is used
  everywhere; add a hostname-keyed entry to override name/email on a
  particular machine (e.g. a work laptop).
- **Packages** live in `.chezmoidata/packages.yaml` (`darwin` / `linux`).
  Editing the list re-triggers the install script on the next `chezmoi apply`.

## Secrets — deliberately NOT tracked

Excluded via `.chezmoiignore`; set these up by hand on each machine:

- `~/.ssh/id_*` — private keys
- `~/.config/gh/hosts.yml` — GitHub token (`gh auth login`)
- `~/.config/opencode/{cli,service}.json`
- `~/.config/gopass/**`
- `~/.docker/config.json`, `~/.kube`, `~/.azure`, `~/.aws`,
  `~/.terraform.d`, `~/.m2`, `~/.nuget`
- `kv-access.*`, `0x4F*.pub.key`

Never run `chezmoi add --recursive ~` — add paths explicitly.

## Templates

Templates use chezmoi's Go template syntax, with everything under
`.chezmoidata/` merged into the data. Handy values:

- `{{ .chezmoi.os }}` — `darwin` or `linux`
- `{{ .chezmoi.hostname }}`
- `{{ .chezmoi.homeDir }}`

## Layout

```
.chezmoiignore                          # secrets + non-applied paths
.chezmoidata/packages.yaml              # per-OS package lists
.chezmoidata/identity.yaml              # git name/email per hostname
dot_zshrc.tmpl, dot_gitconfig.tmpl      # templated
dot_*.zsh, dot_config/**                # verbatim targets
run_onchange_before_install-packages.sh.tmpl
run_onchange_after_install-oh-my-zsh.sh
run_onchange_after_install-nvim-plugins.sh.tmpl
```
