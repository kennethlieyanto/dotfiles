# CHAD MAN dotfiles

Long live GNU Stow...

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

## FAQ
- Why ask "is this desktop or not? Desktop will:
1. Install things like spicetify


- Why ask "is this your personal machine?" Personal machine will:
1. Put my GitHub public ssh key on the machine
2. Install and set `zsh` as default shell
3. Install and set starship for default prompt
4. Create my standard dir convention of 
- `~/Projects/github/`
- `~/Projects/work/`
- `~/Projects/personal/`
