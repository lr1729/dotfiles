# Dotfiles

Personal Vim/Neovim, Zsh, and desktop configuration. The installer links files from this checkout rather than copying them, so edits are shared with the repository.

## Install

```sh
./symlink.sh                     # default: $HOME
./symlink.sh /path/to/other/home
```

The installer is idempotent and **never overwrites existing files or links**. If an existing `~/.zshrc` is a real file, review and back it up before manually replacing it with a link. The tracked Neovim `init.vim` and color directory use relative symlinks, so moving or cloning the repository does not embed the original user's home path.

## Runtime dependencies

- **Zsh** and its bundled autosuggestion/history/highlighting scripts; **eza** for enhanced listings (fallback to exa or standard `ls`).
- **Neovim**, **vim-plug**, **git**, **ripgrep (`rg`)**, and **fzf** (or `sk` for directory/history pickers). For example, install `fzf` with the OS package manager, or `GOBIN="$HOME/.local/bin" go install github.com/junegunn/fzf@latest` when Go is installed.
- **Node.js** (working `node` in `PATH`) for CoC and Copilot, plus optional language-specific tools such as ESLint, Prettier, and LaTeX tooling.
- Optional: Android SDK, conda, Conky, xbindkeys and xkeysnail, depending on machine.

Install vim-plug through your package manager or use its [documented Neovim installation](https://github.com/junegunn/vim-plug#neovim):

```sh
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" \
  --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Then open Neovim and run `:PlugInstall`. Plugin repositories belong in Neovim's user data directory, **not** in this Git repository. Use `:PlugUpdate` to update installed plugins and `:PlugClean` to remove unconfigured plugins deliberately. `:checkhealth` provides optional-provider diagnostics.

## Optional Conky weather

The OpenWeather API key must **not** be committed. Supply `OPENWEATHER_API_KEY` in the environment, or store the key as a single line in `~/.config/conky/.openweather-api-key` (run `chmod 600` on that file). Optionally set `OPENWEATHER_CITY_ID`; the old ID is the default for backward compatibility. The downloader uses HTTPS and preserves the existing `~/.cache/weather.json` when a download fails.

**Security:** An older committed version of `weather.sh` contained an API key. Remove/replacing it in the current checkout does not erase it from Git history. Rotate that OpenWeather key in the provider dashboard; do not treat the old value as private.

## Quick checks

```sh
for f in .zshrc .zsh/aliases .zsh/functions .zsh/exports; do zsh -n "$f" || exit; done
bash -n symlink.sh
nvim --headless +qa
```
