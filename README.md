# dotfiles

Uses chezmoi for syncing of dotfiles

To update and push changes to files/templates:
```bash
# E.g editing .zshrc:
chezmoi edit ~/.zshrc

# Once changes are made, push to main:
(Make sure im logged into personal git and not work account!)
git config user.email

git add .
git commit -m "bla bla bla"
git push
```

On new machines:
```bash
chezmoi diff # See what changes will be applied
chezmoi apply -v # apply changes (verbose)
chezmoi init https://github.com/$GITHUB_USERNAME/dotfiles.git 
chezmoi apply

# And to update:
chezmoi update -v
```
