#!/bin/bash

# inspired by https://gist.github.com/davejamesmiller/1965569
ask() {
    local prompt default reply

    if [[ ${2:-} = 'Y' ]]; then
        prompt='Y/n'
        default='Y'
    elif [[ ${2:-} = 'N' ]]; then
        prompt='y/N'
        default='N'
    else
        prompt='y/n'
        default=''
    fi

    while true; do

        # Ask the question (not using "read -p" as it uses stderr not stdout)
        echo -n "$1 [$prompt] "

        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        read -r reply </dev/tty

        # Default?
        if [[ -z $reply ]]; then
            reply=$default
        fi

        # Check if the reply is valid
        case "$reply" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}

setup_venv() {
    echo "[IAM ZERO] Setting up a virtual environment in the .venv folder"
    python3 -m venv .venv

    echo "[IAM ZERO] Installing dependencies"
    ./.venv/bin/pip install -r requirements.txt
}

if ask "[IAM ZERO] Setup a Python virtual environment and install dependencies for the example?" Y; then
    setup_venv
fi

echo "[IAM ZERO]"
echo "[IAM ZERO] All done! To run the example, you can run the following commands:"
echo "[IAM ZERO]"
echo "[IAM ZERO] source .venv/bin/activate"
echo "[IAM ZERO] python iamzero_example.py"
