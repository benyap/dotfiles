# Emulates the export keyword like in bash / zsh
# https://stackoverflow.com/a/29387647

function export
    if [ $argv ]
        set -gx (echo $argv | cut -f1 -d=) (echo $argv | cut -f2 -d=)
    end
end
