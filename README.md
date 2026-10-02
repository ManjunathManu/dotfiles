# dotfiles

My macOS development environment: kitty, zsh, Neovim, git and every tool, reproducible with one command.

## Setup on a new Mac

```bash
git clone git@github.com:ManjunathManu/dotfiles.git ~/workspace/source-code/personal/dotfiles
cd ~/workspace/source-code/personal/dotfiles
./install.sh
```

`install.sh` installs Homebrew, Node and Python (via [mise](https://mise.jdx.dev)), everything in the [`Brewfile`](Brewfile), links the configs into `$HOME`, and asks for your git name and email.

> **Third-party Homebrew taps** must be trusted before `brew bundle` can use them. If it stops with "untrusted tap", review and run
> `brew trust go-swagger/go-swagger localazy/tools pinecone-io/tap`, then re-run `./install.sh`.

## What's inside

| Area | Highlights |
|---|---|
| **kitty** ([`kitty/`](kitty)) | Splits and tabs without a tmux prefix; custom tab bar with AWS account + credential expiry, load and UTC time; auto dark/light themes (Tokyo Night / Modus Operandi); project sessions; scrollback in Neovim |
| **zsh** ([`bash/`](bash)) | ~0.27s startup (cached tool init); vi mode; [atuin](https://atuin.sh) history search on `Ctrl+R` (local only); fzf; starship prompt |
| **Node / Python** ([`mise/`](mise)) | mise instead of nvm + pyenv; switches versions from `.nvmrc` / `.python-version`; `mise-env` loads a repo's `.env` on demand |
| **git** ([`git/`](git)) | Rebase on pull, rerere, auto upstream on push, zdiff3 conflicts; [delta](https://github.com/dandavison/delta) diffs; per-folder email for personal vs work repos |
| **Safety** | Global [gitleaks](https://github.com/gitleaks/gitleaks) hook blocks secrets in every repo; this repo also runs shellcheck via [pre-commit](.pre-commit-config.yaml) |
| **Neovim** ([`nvim/`](nvim)) | Neovim 0.12, lazy.nvim, native LSP, treesitter |

## kitty shortcuts

| Keys | Action |
|---|---|
| `⌘D` / `⌘⇧D` | Split vertically / horizontally (same folder) |
| `⌘H` `⌘J` `⌘K` `⌘L` | Move between splits |
| `⌘;` | Back to the previous split |
| `⌘G` | Pick a split by number |
| `⌘↩` | Zoom the current split |
| `⌘R` | Resize splits (arrows / hjkl, Esc to finish) |
| `⌘W` | Close the split |
| `⌘T` / `⌘1`–`⌘9` / `⌘0` | New tab / go to tab / previous tab |
| `⌘⇧I` | Rename tab |
| `⌘↑` / `⌘↓` | Jump between command prompts |
| `⌘⇧G` | Last command's output in Neovim |
| `⌘⇧O` | Open a `file:line` from the screen in Neovim |
| `⌘⇧P` / `⌘⇧Y` / `⌘⇧E` | Insert a path / copy a git hash / open a URL from the screen |
| `⌘P` | Fuzzy file picker |
| `⌘⇧S` / `⌘⌥S` | Switch to / save a project session |

## Everyday commands

```bash
sso dev                    # AWS SSO login + credentials for dev (prod, mprod)
mise use node@20           # pin a version for this project
mise-env                   # load this repo's .env while inside it (mise-env off)
brew bundle check --file=Brewfile   # is everything installed?
pre-commit run --all-files # gitleaks + shellcheck on this repo
upkeep                     # what has updates? (also runs monthly with a notification)
```

## Layout

Files ending in `.symlink` are linked by [`install/link.sh`](install/link.sh): to `~/.name` by default, or to `~/.config/<tool>/` for tools like kitty, mise and atuin. Machine-local values (git identity, AWS settings in `config/*.local.sh`) stay out of the repo. [`CLAUDE.md`](CLAUDE.md) has the detailed notes and gotchas.
