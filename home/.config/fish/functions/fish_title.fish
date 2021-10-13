function fish_title
    set --local repository_url (git remote get-url --all origin 2>/dev/null)
    if test -z "$repository_url"
        if [ "$PWD" = "$HOME" ]
            echo \uf7db
        else
            echo \uf07b (pwd | string match -r '[^/]*$')
        end
    else
        echo \ue725 (echo $repository_url | string match -r '[^/]*$' | string replace -r '\.git$' '')
    end
end
