#!/bin/bash
#emacsclient --create-frame --no-wait --socket-name 'le_server' --alternate-editor='' --frame-parameters='(quote (name . "org capture"))' --eval '(cl-flet ((SPC_KEYS nil (vconcat (kbd "SPC") (kbd "nrf") (string-to-vector (base64-decode-string "aW5ib3g=")) (kbd "RET")))) (call-interactively (lambda () (interactive) (execute-kbd-macro (SPC_KEYS)))))'
#source ~/.bashrc

#vsp nrf -r "inbox" RET 
emacs --daemon=foo
env SPC_CLIENT_OPTS="--create-frame --socket-name foo" 
SPC nrf -r "inbox" RET

