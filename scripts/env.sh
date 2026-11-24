#!/usr/bin/env bash
# Manage the project's Python virtual environment.
#
# This script must be *sourced* so it can change your current shell:
#   source scripts/env.sh              # activate (re-activates if already active)
#   source scripts/env.sh activate     # same as above
#   source scripts/env.sh deactivate   # deactivate the active environment
#
# On first activation, the venv is created in .venv and requirements.txt is installed.

# Detect whether we are being sourced (bash and zsh).
if [ -n "${ZSH_VERSION:-}" ]; then
    case $ZSH_EVAL_CONTEXT in *:file*) _env_sourced=1 ;; *) _env_sourced=0 ;; esac
    _env_script="${(%):-%x}"
else
    [ "${BASH_SOURCE[0]}" != "$0" ] && _env_sourced=1 || _env_sourced=0
    _env_script="${BASH_SOURCE[0]}"
fi

if [ "$_env_sourced" -ne 1 ]; then
    echo "Please source this script: source scripts/env.sh [activate|deactivate]" >&2
    exit 1
fi

_env_root="$(cd "$(dirname "$_env_script")/.." && pwd)"
_env_dir="$_env_root/.venv"
_env_action="${1:-activate}"

_env_deactivate() {
    if [ -n "${VIRTUAL_ENV:-}" ] && command -v deactivate >/dev/null 2>&1; then
        echo "Deactivating environment: $VIRTUAL_ENV"
        deactivate
    fi
}

case "$_env_action" in
    activate)
        # If an environment is already active, deactivate it first, then activate again.
        _env_deactivate
        if [ ! -d "$_env_dir" ]; then
            echo "Creating virtual environment in $_env_dir"
            python3 -m venv "$_env_dir" || return 1
            . "$_env_dir/bin/activate"
            pip install --upgrade pip
            pip install -r "$_env_root/requirements.txt"
        else
            . "$_env_dir/bin/activate"
        fi
        echo "Activated environment: $VIRTUAL_ENV"
        ;;
    deactivate)
        if [ -n "${VIRTUAL_ENV:-}" ]; then
            _env_deactivate
        else
            echo "No virtual environment is active."
        fi
        ;;
    *)
        echo "Usage: source scripts/env.sh [activate|deactivate]" >&2
        ;;
esac

unset _env_sourced _env_script _env_root _env_dir _env_action
unset -f _env_deactivate
