;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;; (package! some-package)
                                        ;(package! )
;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/radian-software/straight.el#the-recipe-format
;; (package! another-package
;;   :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;; (package! this-package
;;   :recipe (:host github :repo "username/repo"
;;            :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;; (package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;; (package! builtin-package :recipe (:nonrecursive t))
;; (package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see radian-software/straight.el#279)
;; (package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;; (package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;; (unpin! pinned-package)
;; ...or multiple packages
;; (unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;; (unpin! t)
;;
;;
;;################# Xenops package ##############
(package! xenops)

;;################## yasnipet ######################
(package! yasnippet
  :recipe (:host github :repo "joaotavora/yasnippet"))
;;################### Snipe package, (2-shar jump)
(package! evil-snipe)
;;################### Souround text objects with delimiters
(package! evil-surround)
;;############ Pdf tools for emacs (currently use okular for latex so I do not use this)
(package! pdf-tools)

;;############# Super-save ########################
;; For autosave when different events hapens
(package! super-save)

;; ###########  750 client for jurnaling ##############
(package! 750words
  :recipe (:host github
           :repo "zzamboni/750words-client"
           :files ("*.el")))
;; ############## doct pacakgae for org-capture ############
                                        ; Taken from config: https://tecosaur.github.io/emacs-config/config.html;
(package! doct
  :recipe (:host github :repo "progfolio/doct")
  :pin "5cab660dab653ad88c07b0493360252f6ed1d898")

;; ####################### Lean 4 prover mode ############################
                                        ;
(package! lean4-mode
  :recipe (:host github
           :repo "leanprover-community/lean4-mode"
           :files ("*.el" "data")))

;; 2048 game in emacs
(package! 2048-game)
;;                               beacon animation for cursor movement
(package! beacon)

;;################################### Undo tree ####################################
(package! undo-tree)
;;################################### evil-easymotion ####################################
(package! evil-easymotion)
;;################################### Evil motion trainer ####################################
(package! evil-motion-trainer-mode
  :recipe (:host github
           :repo "martinbaillie/evil-motion-trainer"
           :files ("*.el" "data")))
;;################################### Evil-owl (shows pop up register window) ####################################
(package! evil-owl)
