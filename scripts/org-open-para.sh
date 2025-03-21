#!/bin/bash
emacsclient --create-frame \
            --socket-name 'le_server' \
            --alternate-editor='' \
            --frame-parameters='(quote (name . "workflowy"))' \
            --no-wait \
            --eval "(my/open-para-org)"
