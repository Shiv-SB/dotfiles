# dotfiles

Uses chezmoi for syncing of dotfiles

On new machines:
```bash
chezmoi diff # See what changes will be applied
chezmoi apply -v # apply changes (verbose)
chezmoi init https://github.com/$GITHUB_USERNAME/dotfiles.git 
chezmoi apply

# And to update:
chezmoi update -v
```
