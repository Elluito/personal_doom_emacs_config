emacsclient --create-frame \
            --socket-name 'le_server' \
            --alternate-editor='' \
            --frame-parameters='(quote (name . "capture"))' \
            --no-wait \
            --eval "(my/org-roam-capture-frame)"
