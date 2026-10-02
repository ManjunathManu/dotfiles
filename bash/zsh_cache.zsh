# Startup cache for slow `eval "$(tool init)"` / `source <(tool completion)` lines.
# Sourced by zprofile.symlink and zshrc.symlink (not linked into $HOME).
#
#   _cached_source <name> <tool> <command...>
#
# Runs <command...> once and saves its output to ~/.cache/zsh/<name>.zsh, then
# sources the saved file on later shells. The cache is regenerated when <tool>
# resolves to a different real path (e.g. `brew upgrade` repoints the symlink
# to a new Cellar version) or its file changes. Delete ~/.cache/zsh to reset.

(( $+functions[_cached_source] )) && return

_ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"

_cached_source() {
    local name=$1 tool=$2; shift 2
    local bin=${commands[$tool]:-$tool}
    [[ -x $bin ]] || return 1
    local real=${bin:A} file="$_ZSH_CACHE_DIR/$name.zsh" stamp first
    local -a mtime
    zstat -A mtime +mtime -- "$real" 2>/dev/null
    stamp="# $real ${mtime[1]}"

    [[ -r $file ]] && read -r first < "$file"
    if [[ $first != "$stamp" ]]; then
        mkdir -p "$_ZSH_CACHE_DIR"
        { print -r -- "$stamp"; "$@" } >| "$file.tmp" 2>/dev/null \
            && mv -f "$file.tmp" "$file" \
            || { rm -f "$file.tmp"; return 1; }
    fi
    source "$file"
}

zmodload -F zsh/stat b:zstat 2>/dev/null
