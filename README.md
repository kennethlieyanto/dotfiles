# CHAD MAN dotfiles

Long live GNU Stow...

What it does in a nutshell:
1. Copy dotfiles as usual
2. Install packages (fedora only)
3. Change shell to zsh
4. Custom prompt with starship
5. Install ghostty terminfo
6. Add all personal github's public key pair to authorized keys to that machine

https
```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply kennethlieyanto
```

ssh
```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --ssh --apply kennethlieyanto
```

## Debug

```sh
chezmoi execute-template '{{ .chezmoi.hostname }}'
```
