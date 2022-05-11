function fish_title
    set --local repository_url (git remote get-url --all origin 2>/dev/null)
    if test -z "$repository_url"
        if [ "$PWD" = "$HOME" ]
            echo [home]
        else
            echo [dir] (pwd | string match -r '[^/]*$')
        end
    else
        echo [git] (echo $repository_url | string match -r '[^/]*$' | string replace -r '\.git$' '')
    end
end
