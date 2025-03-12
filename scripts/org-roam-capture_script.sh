emacsclient --create-frame \
            --socket-name 'le_server' \
            --alternate-editor='' \
            --frame-parameters='(quote (name . "Org-Roam capture"))' \
            --no-wait \
            --eval "(my/org-roam-capture-frame)"
