#!/bin/bash
 emacsclient --create-frame --socket-name 'le_server' --alternate-editor='' --frame-parameters='(quote (name . "Deft"))' --no-wait --eval "(deft)"

