#!/bin/bash
# Command Palette using fzf
# Reads from ~/.fzf/workflows.txt

WORKFLOWS_FILE="${HOME}/.fzf/workflows.txt"

if [[ ! -f "$WORKFLOWS_FILE" ]]; then
    echo "Workflows file not found: $WORKFLOWS_FILE"
    return 1
fi

# Parse workflow file (skip comments and empty lines)
selected=$(grep -v '^#' "$WORKFLOWS_FILE" | grep -v '^$' | \
    fzf --delimiter='|' \
        --with-nth=1,3 \
        --preview='echo {1}' \
        --preview-window=up:3:wrap \
        --height=80% \
        --border \
        --prompt='Command> ' \
        --header='Select command (Ctrl+C to cancel)')

if [[ -n "$selected" ]]; then
    # Extract the actual command (first field)
    command=$(echo "$selected" | awk -F'|' '{print $1}' | xargs)

    # Print selected command
    echo "Executing: $command"

    # Check if command needs parameters (contains uppercase words)
    if echo "$command" | grep -qE '[A-Z]{2,}'; then
        # Command has placeholders
        if [[ -n "$ZSH_VERSION" ]]; then
            # For zsh: pre-fill command line
            print -z "$command"
        else
            # For bash: pre-fill readline
            history -s "$command"
            echo "$command"
        fi
    else
        # Execute directly
        eval "$command"
    fi
fi
