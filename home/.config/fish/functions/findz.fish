# Use z to find files and list out their full paths

function findz
    begin
        set -l IFS
        set output (z -r -l $argv | grep '/.*' -o)
    end
    echo $output
end
