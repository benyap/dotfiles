# Emulates the unset keyword like in bash / zsh

function unset
    if [ $argv ]
        set -e (echo $argv)
    end
end
