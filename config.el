;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Luis Alfredo Avendaño Muñoz"
      user-mail-address "alfredoavendano@hotmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Fira Code" :size 15 :weight 'light)
      doom-variable-pitch-font (font-spec :family "Noto Sans" :size 16)
      ;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
      ;; - `doom-symbol-font' -- for symbols

      )
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-monokai-pro)
(setq doom-theme 'doom-gruvbox)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)
;;############################## Org-mode Settings ##############
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/org/")




;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; ################ Start as server  ###################
;; This is just so it can do inverse search with okular while wirting latex documents

;; (server-start)
;; Aparently doom emac start the server itself acording to numeral 7 on this link https://discourse.doomemacs.org/t/common-config-anti-patterns/119



;; ################ Latex editing #####################
;; (after! latex
;; (setq +latex-viewers '(pdf-tools))
;; These two lines are to ensure that LaTex-mode gets activated on every .tex
;; This has to do with some issue with versions of emacs older thatn 30  see : https://github.com/doomemacs/doomemacs/issues/8191
(add-to-list 'auto-mode-alist '("\\.tex\\'" . LaTeX-mode))
(setq major-mode-remap-alist major-mode-remap-defaults)

;; This to use the pdf viewer
(setq +latex-viewers '(okular))
;; LSP server fot latex This still does not works texlab does not work as intended
(setq lsp-tex-server 'texlab)
;; ;(after! latex
;; ;; This is for useing xenops for endering tables in buffer
;;

(after! latex
  (add-hook 'LaTeX-mode-hook #'xenops-mode) ;
  ;; Turn on RefTeX in AUCTeX
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (setq reftex-plug-into-AUCTeX t)
  ;; )                                     ;
  ;; ; This is for inverse search  taken from https://inthearmchair.wordpress.com/2010/09/02/latex-inverse-pdf-search-with-emacs/
  ;; (add-hook 'LaTeX-mode-hook 'TeX-DF-mode)
  '(LaTeX-command "latex -synctex=1")
  '(TeX-output-view-style '(("^pdf$" "." "okular %s.pdf")))

  ;; ;Taken from jhttps://michaelneuper.com/posts/efficient-latex-editing-with-emacs/#cdlatex
  (map! :map cdlatex-mode-map
        :i "TAB" #'cdlatex-tab)
  )
;; Clever ref is recognised by reftex
(eval-after-load
    "latex"
  '(TeX-add-style-hook
    "cleveref"
    (lambda ()
      (if (boundp 'reftex-ref-style-alist)
          (add-to-list
           'reftex-ref-style-alist
           '("Cleveref" "cleveref"
             (("\\cref" ?c) ("\\Cref" ?C) ("\\cpageref" ?d) ("\\Cpageref" ?D)))))
      (reftex-ref-style-activate "Cleveref")
      (TeX-add-symbols
       '("cref" TeX-arg-ref)
       '("Cref" TeX-arg-ref)
       '("cpageref" TeX-arg-ref)
       '("Cpageref" TeX-arg-ref)))))

;; Activate nice interface between RefTeX and AUCTeX
;; ################ Snippets ##########################
;;
;;################# Biblio ############################
;; (after! citar
;;   (setq! citar-bibliography '("~/home/luisaam/Documents/Thesis/References/all_zotero_references.bib"))
;;   (setq! citar-library-paths '("~/home/luisaam/Documents/Thesis/bReferences/"))
;;   (setq! citar-notes-paths '("~/references/notes")))

;; (setq reftex-default-bibliography "~/home/luisaam/Documents/Thesis/References/all_zotero_references.bib")
;; ;; ################  Sniper package #####################
;; ;;
;; (after! evil-snipe
;;   (evil-snipe-mode +1)
;;   (evil-snipe-override-mode +1)
;;   (add-hook 'magit-mode-hook 'turn-off-evil-snipe-override-mode)
;;   (setq evil-snipe-scope 'whole-visible)
;;   )


;; ###########################################################
;;                      Auto save
;; ###########################################################
(after! super-save
  ;; This auto saves the buffer when I change focus
  (super-save-mode +1)
  ;;Saves when idle
  (setq super-save-auto-save-when-idle t)
  ;; deactivates emacs's default autosave (it already is turned off by default in doom emacs but ill put it here anyway)
  (setq auto-save-default nil)
  )

;; ################ Evil-mode settings #####################
;; Respect visual lines when moving
(setq visual-line-mode t)
;; This is for moving on the visual lines
(map! :n "j" #'evil-next-visual-line
      :n "k" #'evil-previous-visual-line)
;; ########### Good Scroll mode #####################
;; https://github.com/io12/good-scroll.el
;; I wanted to do something like the smooth scroll in neovide
;; (good-scroll-mode 1)

;; (defun my/org-roam-capture-frame ()
;;   "Run org-capture in its own frame."
;;   (interactive)
;;   (require 'cl-lib)
;;   (select-frame-by-name "roam-capture")
;;   (delete-other-windows)
;;   (cl-letf (((symbol-function 'switch-to-buffer-other-window) #'switch-to-buffer))
;;     (condition-case err
;;         (org-roam-capture)
;;       ;; "q" signals (error "Abort") in `org-capture'
;;       ;; delete the newly created frame in this scenario.
;;       (user-error (when (string= (cadr err) "Abort")
;;                     (delete-frame))))))

;; (defun my/delete-roam-capture-frame (&rest _)
;;   "Delete frame with its name frame-parameter set to \"capture\"."
;;   (if (equal "roam-capture" (frame-parameter nil 'name))
;;       (delete-frame)))



;; #################### org- capture config###################
;; Taken from  https://tecosaur.github.io/emacs-config/config.html
;;TODO: Fix the FIXME down here to actually use this pretty config
(after! org-capture
                                        ; <<prettify-capture>>
  (defun +doct-icon-declaration-to-icon (declaration)
    "Convert :icon declaration to icon"
    (let ((name (pop declaration))
          (set  (intern (concat "nerd-icons-" (plist-get declaration :set))))
          (face (intern (concat "nerd-icons-" (plist-get declaration :color))))
          (v-adjust (or (plist-get declaration :v-adjust) 0.01)))
      (apply set `(,name :face ,face :v-adjust ,v-adjust))))

  (defun +doct-iconify-capture-templates (groups)
    "Add declaration's :icon to each template group in GROUPS."
    (let ((templates (doct-flatten-lists-in groups)))
      (setq doct-templates (mapcar (lambda (template)
                                     (when-let* ((props (nthcdr (if (= (length template) 4) 2 5) template))
                                                 (spec (plist-get (plist-get props :doct) :icon)))
                                       (setf (nth 1 template) (concat (+doct-icon-declaration-to-icon spec)
                                                                      "\t"
                                                                      (nth 1 template))))
                                     template)
                                   templates))))

  (setq doct-after-conversion-functions '(+doct-iconify-capture-templates))
                                        ;
                                        ;FIXME: Find out what recipies.org mean
                                        ;
  (defvar +org-capture-recipies  "~/Organisation/recipies.org")

  (defun set-org-capture-templates ()
    (setq org-capture-templates
          (doct `(("Personal todo" :keys "t"
                   :icon ("nf-oct-checklist" :set "octicon" :color "green")
                   :file +org-capture-todo-file
                   :prepend t
                   :headline "Inbox"
                   :type entry
                   :template ("* TODO %?"
                              "%i %a"))
                  ("Personal note" :keys "n"
                   :icon ("nf-fa-sticky_note_o" :set "faicon" :color "green")
                   :file +org-capture-todo-file
                   :prepend t
                   :headline "Inbox"
                   :type entry
                   :template ("* %?"
                              "%i %a"))
                  ("Email" :keys "e"
                   :icon ("nf-fa-envelope" :set "faicon" :color "blue")
                   :file +org-capture-todo-file
                   :prepend t
                   :headline "Inbox"
                   :type entry
                   :template ("* TODO %^{type|reply to|contact} %\\3 %? :email:"
                              "Send an email %^{urgency|soon|ASAP|anon|at some point|eventually} to %^{recipiant}"
                              "about %^{topic}"
                              "%U %i %a"))
                  ;; ("Roam" :keys "r"
                  ;;  :icon ("nf-fa-eye" :set "faicon" :color "lcyan")
                  ;;  :prepend t
                  ;;  :headline "Roam Note"
                  ;;  :type plain
                  ;;  :children (("d" "default" plain "%?"
                  ;;              :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
                  ;;              :unnarrowed t)
                  ;;             ("b" "book notes" plain "\n* Source\n\nAuthor: %^{Author}\nTitle: ${title}\nYear: %^{Year}\n\n* Summary\n\n%?"
                  ;;              :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
                  ;;              :unnarrowed t)))
                  ("Interesting" :keys "i"
                   :icon ("nf-fa-eye" :set "faicon" :color "lcyan")
                   :file +org-capture-todo-file
                   :prepend t
                   :headline "Interesting"
                   :type entry
                   :template ("* [ ] %{desc}%? :%{i-type}:"
                              "%i %a")
                   :children (("Webpage" :keys "w"
                               :icon ("nf-fa-globe" :set "faicon" :color "green")
                               :desc "%(org-cliplink-capture) "
                               :i-type "read:web")
                              ("Article" :keys "a"
                               :icon ("nf-fa-file_text_o" :set "faicon" :color "yellow")
                               :desc ""
                               :i-type "read:research")
                              ("\tRecipie" :keys "r"
                               :icon ("nf-fa-spoon" :set "faicon" :color "dorange")
                               :file +org-capture-recipies
                               :headline "Unsorted"
                               :template "%(org-chef-get-recipe-from-url)")
                              ("Information" :keys "i"
                               :icon ("nf-fa-info_circle" :set "faicon" :color "blue")
                               :desc ""
                               :file "/home/luisaam/org/roam/20250313124731-inbox.org"
                               :i-type "read:info")
                              ("Idea" :keys "I"
                               :icon ("nf-md-chart_bubble" :set "mdicon" :color "silver")
                               :desc ""
                               :file "/home/luisaam/org/roam/20250313124731-inbox.org"
                               :i-type "idea")))
                  ("Tasks" :keys "k"
                   :icon ("nf-oct-inbox" :set "octicon" :color "yellow")
                   :file +org-capture-todo-file
                   :prepend t
                   :headline "Tasks"
                   :type entry
                   :template ("* TODO %? %^G%{extra}"
                              "%i %a")
                   :children (("General Task" :keys "k"
                               :icon ("nf-oct-inbox" :set "octicon" :color "yellow")
                               :extra "")
                              ("Task with deadline" :keys "d"
                               :icon ("nf-md-timer" :set "mdicon" :color "orange" :v-adjust -0.1)
                               :extra "\nDEADLINE: %^{Deadline:}t")
                              ("Scheduled Task" :keys "s"
                               :icon ("nf-oct-calendar" :set "octicon" :color "orange")
                               :extra "\nSCHEDULED: %^{Start time:}t")))
                  ("Project" :keys "p"
                   :icon ("nf-oct-repo" :set "octicon" :color "silver")
                   :prepend t
                   :type entry
                   :headline "Inbox"
                   :template ("* %{time-or-todo} %?"
                              "%i"
                              "%a")
                   :file ""
                   :custom (:time-or-todo "")
                   :children (("Project-local todo" :keys "t"
                               :icon ("nf-oct-checklist" :set "octicon" :color "green")
                               :time-or-todo "TODO"
                               :file +org-capture-project-todo-file)
                              ("Project-local note" :keys "n"
                               :icon ("nf-fa-sticky_note" :set "faicon" :color "yellow")
                               :time-or-todo "%U"
                               :file +org-capture-project-notes-file)
                              ("Project-local changelog" :keys "c"
                               :icon ("nf-fa-list" :set "faicon" :color "blue")
                               :time-or-todo "%U"
                               :heading "Unreleased"
                               :file +org-capture-project-changelog-file)))
                  ("\tCentralised project templates"
                   :keys "o"
                   :type entry
                   :prepend t
                   :template ("* %{time-or-todo} %?"
                              "%i"
                              "%a")
                   :children (("Project todo"
                               :keys "t"
                               :prepend nil
                               :time-or-todo "TODO"
                               :heading "Tasks"
                               :file +org-capture-central-project-todo-file)
                              ("Project note"
                               :keys "n"
                               :time-or-todo "%U"
                               :heading "Notes"
                               :file +org-capture-central-project-notes-file)
                              ("Project changelog"
                               :keys "c"
                               :time-or-todo "%U"
                               :heading "Unreleased"
                               :file +org-capture-central-project-changelog-file)))))))

  (set-org-capture-templates)
  (unless (display-graphic-p)
    (add-hook 'server-after-make-frame-hook
              (defun org-capture-reinitialise-hook ()
                (when (display-graphic-p)
                  (set-org-capture-templates)
                  (remove-hook 'server-after-make-frame-hook
                               #'org-capture-reinitialise-hook))))))
;;### It would also be nice to improve how the capture dialogue looks

;;### prettify-captureEmacs Lisp
;;### The org-capture bin is rather nice, but I’d be nicer with a smaller frame, and no modeline.

                                        ;#
(setf (alist-get 'height +org-capture-frame-parameters) 15)
;; (alist-get 'name +org-capture-frame-parameters) "❖ Capture") ;; ATM hardcoded in other places, so changing breaks stuff
;; (setq +org-capture-fn
;;       (lambda ()
;;         (interactive)
;;         (set-window-parameter nil 'mode-line-format 'none)
;;         (org-capture)))
;;
;; org mode todo toggle
;; (defun org-toggle-todo-and-fold ()
;;   (interactive)
;;   (save-excursion
;;     (org-back-to-heading t) ;; Make sure command works even if point is
;;                             ;; below target heading
;;     (cond ((looking-at "\*+ TODO")
;;            (org-todo "DONE")
;;            (hide-subtree))
;;           ((looking-at "\*+ DONE")
;;            (org-todo "TODO")
;;            (hide-subtree))
;;           (t (message "Can only toggle between TODO and DONE.")))))

;; (define-key org-mode-map (kbd "C-c C-d") 'org-toggle-todo-and-fold)

;;################ Org-capture code ########################################
;; this piece of code is taken from https://gist.github.com/progfolio/af627354f87542879de3ddc30a31adc1
(defun my/delete-capture-frame (&rest _)
  "Delete frame with its name frame-parameter set to \"capture\"."
  (if (equal "capture" (frame-parameter nil 'name))
      (delete-frame)))

(advice-add 'org-capture-finalize :after #'my/delete-capture-frame)

(defun my/org-capture-frame ()
  "Run org-capture in its own frame."
  (interactive)
  (require 'cl-lib)
  (select-frame-by-name "capture")
  (delete-other-windows)
  (cl-letf (((symbol-function 'switch-to-buffer-other-window) #'switch-to-buffer))
    (condition-case err
        (org-capture)
      ;; "q" signals (error "Abort") in `org-capture'
      ;; delete the newly created frame in this scenario.
      (user-error (when (string= (cadr err) "Abort")
                    (delete-frame))))))
;;################# Activate beacon mode ###############################
(beacon-mode 1)
;;################# Evil easy-motion ###############################

(evilem-default-keybindings "|")
(evilem-define (kbd "| s") 'evil-snipe-repeat
               :pre-hook (save-excursion (call-interactively #'evil-snipe-s))
               :bind ((evil-snipe-scope 'buffer)
                      (evil-snipe-enable-highlight)
                      (evil-snipe-enable-incremental-highlight)))

(evilem-define (kbd "| S") 'evil-snipe-repeat-reverse
               :pre-hook (save-excursion (call-interactively #'evil-snipe-s))
               :bind ((evil-snipe-scope 'buffer)
                      (evil-snipe-enable-highlight)
                      (evil-snipe-enable-incremental-highlight)))
;;;;################# Evil mode trainer ###############################
;; Trainer on all the time
(global-evil-motion-trainer-mode 1)
;;Configure the number of permitted repeated key presses:
(setq evil-motion-trainer-threshold 60)
                                        ;Enable a super annoying mode that pops a warning in a buffer:
                                        ;(setq evil-motion-trainer-super-annoying-mode t)
;; Add to the suggested alternatives for a key:
;; (emt-add-suggestion 'evil-next-line 'evil-avy-goto-char-timer)
;; (emt-add-suggestion 'evil-next-line)
;; See also: (emt-add-suggestions)
;;################# Evil owl config ###############################
;; (use-package evil-owl
;;   :config
;;   (setq evil-owl-display-method 'posframe
;;         evil-owl-extra-posframe-args '(:width 50 :height 20)
;;         evil-owl-max-string-length 50)
;;   (evil-owl-mode))
;; Using posframe
(use-package evil-owl
  :config
  (setq evil-owl-display-method 'posframe
        evil-owl-extra-posframe-args '(:width 50 :height 20)
        evil-owl-max-string-length 50)
  (evil-owl-mode))
;;################## Maximized on start up #################
;; (add-to-list 'initial-frame-alist '(fullscreen . maximized))
(add-hook 'window-setup-hook #'toggle-frame-maximized)
;; (add-hook 'window-setup-hook #'toggle-frame-fullscreen)
;; ################## Clever ref on reftex and auctex#################
(eval-after-load
    "Latex"
  '(TeX-add-style-hook
    "cleveref"
    (lambda ()
      (if (boundp 'reftex-ref-style-alist)
          (add-to-list
           'reftex-ref-style-alist
           '("Cleveref" "cleveref"
             (("\\cref" ?c) ("\\Cref" ?C) ("\\cpageref" ?d) ("\\Cpageref" ?D)))))
      (reftex-ref-style-activate "Cleveref")
      (TeX-add-symbols
       '("cref" TeX-arg-ref)
       '("Cref" TeX-arg-ref)
       '("cpageref" TeX-arg-ref)
       '("Cpageref" TeX-arg-ref)))))


;; ########### Vulpea config from https://github.com/d12frosted/vulpea ##
(use-package! vulpea
  :demand t
  :hook ((org-roam-db-autosync-mode . vulpea-db-autosync-enable)))
;; (vulpea-find :other-window t)
;;
;; ############################## org-roam-ui settings ######################
;;
(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam ;; or :after org
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))
;;############# Some oorg mode keybindings found in https://michaelneuper.com/posts/how-i-use-org-roam-to-takes-notes-for-cs/
(after! org
  (add-to-list 'org-latex-packages-alist '("" "amsmath" t))
  (add-to-list 'org-latex-packages-alist '("" "amssymb" t))
  (add-to-list 'org-latex-packages-alist '("" "mathtools" t))
  (add-to-list 'org-latex-packages-alist '("" "mathrsfs" t)))
(add-hook 'org-mode-hook #'xenops-mode)
(setq xenops-math-image-scale-factor 1.7
      xenops-reveal-on-entry t)

;; #################### Org roam ##################################
;; taken from https://systemcrafters.net/build-a-second-brain-in-emacs/capturing-notes-efficiently/
(use-package! org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/Dropbox/org/roam")
  (org-roam-completion-everywhere t)
  (org-roam-capture-templates
   ;;###### Old  templeates ##########
   '(("d" "default" plain
      "%?"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)
     ("b" "Literature note (book or article)" plain
      (file "~/org/roam/templates/literature.org")
      :target (file+head
               "reference/%<%Y%m%d%H%M%S>-literature-${slug}.org"
               "#+title: ${Year}, ${Author}: ${Title}\n#+filetags: :literature:\n\n")
      :empty-lines-before 2
      :unnarrowed t)
     ("a" "article" plain "%?"
      :if-new
      (file+head "articles/${title}.org" "#+title: ${title}\n#+filetags: :article:\n")
      :immediate-finish t
      :unnarrowed t)

     )
   )
  ;;###################################
  ;; :bind (("C-c n l" . org-roam-buffer-toggle)
  ;;        ("C-c n f" . org-roam-node-find)
  ;;        ("C-c n i" . org-roam-node-insert)
  ;;        :map org-mode-map
  ;;        ("C-M-i" . completion-at-point))
  :config
  (org-roam-setup)
  )

(cl-defmethod org-roam-node-type ((node org-roam-node))
  "Return the TYPE of NODE."
  (condition-case nil
      (file-name-nondirectory
       (directory-file-name
        (file-name-directory
         (file-relative-name (org-roam-node-file node) org-roam-directory))))
    (error "")))
(setq org-roam-node-display-template
      (concat "${type:15} ${title:*} " (propertize "${tags:10}" 'face 'org-tag)))



(defun my/org-roam-capture-frame ()
  "Run org-capture in its own frame."
  (interactive)
  (require 'cl-lib)
  (select-frame-by-name "capture")
  (delete-other-windows)
  (cl-letf (((symbol-function 'switch-to-buffer-other-window) #'switch-to-buffer))
    (condition-case err
        ;; (vulpea-create
        ;;  "Title of new note"
        ;;  "~/org/roam/Inbox/%<%Y%m%d%H%M%S>-${slug}.org")
        (org-capture)
      ;; "q" signals (error "Abort") in `org-capture'
      ;; delete the newly created frame in this scenario.
      (user-error (when (string= (cadr err) "Abort")
                    (delete-frame))))))

(defun my/delete-roam-capture-frame (&rest _)
  "Delete frame with its name frame-parameter set to \"capture\"."
  (if (equal "capture" (frame-parameter nil 'name))
      (delete-frame)))

(advice-add 'org-capture-finalize :after #'my/delete-roam-capture-frame)

(defun jethro/tag-new-node-as-draft ()
  (org-roam-tag-add '("draft")))
(add-hook 'org-roam-capture-new-node-hook #'jethro/tag-new-node-as-draft)

;;######## deft ##############################
;;
(setq deft-directory "~/Dropbox/org/"
      deft-extensions '("org" "txt" "md")
      deft-recursive t)

;;####################### AI Writer mode  ####################
;;taken from https://kodfabrik.com/journal/ia-writer-mode-for-emacs
;; (defun aiwriting-mode ()
;;   (interactive)
;;   (setq buffer-face-mode-face '(:family "dejavu sans mono" :height 150))
;;   (buffer-face-mode)
;;   (writeroom-mode 1)
;;   (blink-cursor-mode)
;;   (visual-line-mode 1)
;;   (setq truncate-lines 1)
;;   (setq-default line-spacing 5)
;;   (setq global-hl-line-mode nil)
;;   )
;; ;;We'll define a function that will be triggered whenever we want to enable it. Here is an empty function and a hook for markdown-mode

;; (add-hook 'markdown-mode-hook 'writing-mode)
;; ;;  tell Emacs to use markdown-mode in *scratch* to bring up the writing mode easily:
;; (setq initial-major-mode 'markdown-mode)

;;### Create ai writer minor mode with the base code from  https://systemcrafters.net/learning-emacs-lisp/creating-minor-modes/ and https://kodfabrik.com/journal/ia-writer-mode-for-emacs
;; (make-variable-buffer-local
;;  (defvar aiwriting-mode nil
;;    "Toggle aiwriting-mode."))

;; (defvar aiwriting-mode-map (make-sparse-keymap)
;;   "The keymap for aiwriting-mode")

;; ;; Define a key in the keymap
;; (define-key 'aiwriting-map (kbd "C-c C-. t")
;;             (lambda ()
;;               (interactive)
;;               (message "aiwriting key binding used!")))

;; (add-to-list 'minor-mode-alist '(aiwriting-mode " aiwriting"))
;; (add-to-list 'minor-mode-map-alist (cons 'aiwriting-mode aiwriting-mode-map))

;; (defun aiwriting-mode (&optional ARG)
;;   (interactive (list 'toggle))
;;   (setq aiwriting-mode
;;         (if (eq ARG 'toggle)
;;             (not aiwriting-mode)
;;
;;           (> ARG 0))
;;         (setq buffer-face-mode-face '(:family "dejavu sans mono" :height 150))
;;         (buffer-face-mode)
;;         (writeroom-mode 1)
;;         (blink-cursor-mode)
;;         (visual-line-mode 1)
;;         (setq truncate-lines 1)
;;         (setq-default line-spacing 5)
;;         (setq global-hl-line-mode nil)
;;         )

;;   ;; Take some action when enabled or disabled
;;   (if aiwriting-mode
;;       (message "aiwriting-mode activated!")
;;     (message "aiwriting-mode deactivated!")))
;;
;; Garbage collector
;; taken from https://github.com/michaelneuper/doom
(use-package! gcmh
  :init
  (setq gcmh-idle-delay 5
        gcmh-high-cons-threshold (* 256 1024 1024))  ; 256MB during idle
  :config
  (gcmh-mode 1))

(setq gc-cons-threshold 200000000) ; previous 33554432

;; Buffer-flip
;; ;; key to begin cycling buffers.  Global key.
;; (global-set-key (kbd "C-<tab>") 'buffer-flip)

;; ;; transient keymap used once cycling starts
;; (setq buffer-flip-map
;;       (let ((map (make-sparse-keymap)))
;;         (define-key map (kbd "C-<tab>")   'buffer-flip-forward)
;;         (define-key map (kbd "C-S-<tab>") 'buffer-flip-backward)
;;         (define-key map (kbd "C-ESC")     'buffer-flip-abort)
;;         map))

;; ;; buffers matching these patterns will be skipped
;; (setq buffer-flip-skip-patterns
;;       '("^\\*helm\\b"
;;         "^\\*swiper\\*$"
;;         "^\\*scratch\\*$"
;;         "^\\*messages\\*$"
;;         "^\\*doom\\*$"))
;; Buffer expose to jump visually to buffers
;;
;;(use-package! buffer-expose)
(buffer-expose-mode 1)
;; (defvar buffer-expose-mode-map
;;   (let ((map (make-sparse-keymap)))
;;     (define-key map (kbd "<C-M-tab>") 'buffer-expose)
;;     (define-key map (kbd "<C-tab>") 'buffer-expose-no-stars)
;;     (define-key map (kbd "C-c <C-tab>") 'buffer-expose-current-mode)
;;     (define-key map (kbd "C-c C-m") 'buffer-expose-major-mode)
;;     (define-key map (kbd "C-c C-d") 'buffer-expose-dired-buffers)
;;     (define-key map (kbd "C-c C-*") 'buffer-expose-stars)
;;     map)
;;   "Mode map for command `buffer-expose-mode'.")
;;

;;; Function to open one frame and show my PARA.org file
(defun my/open-para-org ()
  "Run a frame with  PARA.org file in it"
  (interactive)
  (require 'cl-lib)
  (select-frame-by-name "workflowy")
  (delete-other-windows)
  (cl-letf (((symbol-function 'switch-to-buffer-other-window) #'switch-to-buffer))
    (find-file "~/Dropbox/org/PARA.org")
    (goto-char (org-find-exact-headline-in-buffer "Inbox 📥"))
    )
  )
;;; Function to open one frame and show my journal.org file
(defun my/open-scratch-org ()
  "Run a frame with scratch.org file in it"
  (interactive)
  (require 'cl-lib)
  (select-frame-by-name "_emacs_scratchpad_")
  (delete-other-windows)
  (cl-letf (((symbol-function 'switch-to-buffer-other-window) #'switch-to-buffer))
    (find-file "~/Dropbox/org/scratch.org")
    ;; (goto-char (org-find-exact-headline-in-buffer "Inbox 📥"))
    )
  )
(defun my/open-shell-org ()
  "Run a frame with vterm in it"
  (interactive)
  (require 'cl-lib)
  (select-frame-by-name "_emacs_terminal_")
  (delete-other-windows)
  (cl-letf (((symbol-function 'switch-to-buffer-other-window) #'switch-to-buffer))
    (vterm)
    ;; (goto-char (org-find-exact-headline-in-buffer "Inbox 📥"))
    )
  )
;; (cl-letf (((symbol-function 'switch-to-buffer-other-window) #'switch-to-buffer))
;;   (condition-case err
;;       (find-file "~/Dropbox/org/PARA.org")
;;       (goto-char (org-find-exact-headline-in-buffer "Inbox 📥"))
;;       ;; "q" signals (error "Abort") in `org-capture'
;;       ;; delete the newly created frame in this scenario.
;;       (user-error (when (string= (cadr err) "Abort")
;;                     (delete-frame)))))
;; )


;;The following is for some workflowy like behaviour in org-mode taken from https://github.com/alaq/workflowy.el/blob/master/workflowy.el
;;
;;;###autoload
;; (define-minor-mode workflowy-mode
;;   "Workflowy's features in an emacs minor mode for org-mode."
;;   nil nil nil
;;   (org-indent-mode)
;;   (add-hook 'org-mode-hook 'set-olivetti)
;;   (add-hook 'org-mode-hook 'org-indent-mode)
;;   (add-hook 'org-mode-hook #'org-bullet-mode)
;;   (define-key org-mode-map (kbd "C-<")
;;               'org-go-up-one-level)
;;   (define-key org-mode-map (kbd "C->")
;;     \          'org-go-down-one-level)
;;   (define-key org-mode-map (kbd "RET")
;;               'org-better-return)
;;   (setq header-line-format (concat "%b/" (org-format-outline-path(org-get-outline-path))))
;;   )
(with-eval-after-load "org"
  (define-key org-mode-map (kbd "C-<left>")
              'org-go-up-one-level)
  (define-key org-mode-map (kbd "C-<right>")
              'org-go-down-one-level)
  ;; (map! :leader :desc "Go down one level" :n "s-<right>" #'org-go-down-one-level)
  ;; (map! :leader :desc "Go up one level" :n "s-<left>" #'org-go-up-one-level)
  ;; (define-key org-mode-map (kbd "SPC")
  ;;             nil)
  ;; (define-key org-mode-map (kbd "SPC") nil)
  ;; (map! :leader :nv "z" nil)
  ;; (map! :leader :i "z" nil)
  )

(defun org-go-up-one-level ()
  "go up one level, workflowy style"
  (interactive)
  (beginning-of-buffer)
  (widen)
  (setq header-line-format (concat "%b/" (org-format-outline-path(org-get-outline-path))))
  (save-excursion
    (org-up-element)
    (org-narrow-to-subtree))
  (beginning-of-buffer)
  (recenter-top-bottom)
  )

;; (add-hook 'org-mode-hook #'org-change-bullets-depending-on-children)
;; (add-hook 'org-mode-hook 'org-change-bullets-depending-on-children)

(defun org-go-down-one-level ()
  "drill down one level, workflowy style"
  (interactive)
  (org-narrow-to-subtree)
  (org-show-children)
  (setq header-line-format (concat "%b/" (org-format-outline-path(org-get-outline-path t)))))

(defun org-has-children-p ()
  (interactive)
  (save-excursion
    (org-goto-first-child)))

(defun org-has-parent-p ()
  (interactive)
  (save-excursion
    (org-up-element)))

;; (require 'olivetti)
;; (defun set-olivetti ()
;;   "olivetti mode with default values"
;;   (interactive)
;;   (setq header-line-format "%b/")
;;   (set-face-attribute 'header-line nil :background "#282c35")
;;   (olivetti-mode)
;;   (olivetti-set-width 100))

;; original idea from http://kitchingroup.cheme.cmu.edu/blog/2017/04/09/A-better-return-in-org-mode/
;; simplified below until a better one can be written
;; a good idea would be to look into https://github.com/calvinwyoung/org-autolist/blob/master/org-autolist.el
;; TODO RETURN in the middle of line should "cut" it
;; TODO double return should enter a note, and not a bullet
;; (defun org-better-return ()
;;   (interactive)
;;   (org-insert-heading-respect-content)
;;   (evil-insert-state))


;; ;; ;; below is wip
;; (defun org-folded-p ()
;;   "Returns non-nil if point is on a folded headline."
;;   (and (org-at-heading-p)
;;        (save-excursion (org-goto-first-child))
;;        (invisible-p (point-at-eol))))

;; (defun is-folded ()
;;   "Interactive version of org-folded-p"
;;   (interactive)
;;   (if (org-folded-p) (message "yes") (message "no")))

;; ;; replace bullets depending of the presence of child nodes or not
;; (defcustom org-content (string-to-char "◉")
;;   "Replacement for * as header prefixes."
;;   :type 'characterp
;;   :group 'org)

;; (defcustom org-no-content (string-to-char "○")
;;   "Replacement for * as header prefixes."
;;   :type 'characterp
;;   :group 'org)
;;#######################################################################
;;
;;#######################################################################
;; Next section is taken from https://zzamboni.org/post/my-doom-emacs-configuration-with-commentary/
;;#######################################################################
;;
;;#################### org-download #########################
(defun zz/org-download-paste-clipboard (&optional use-default-filename)
  (interactive "P")
  (require 'org-download)
  (let ((file
         (if (not use-default-filename)
             (read-string (format "Filename [%s]: "
                                  org-download-screenshot-basename)
                          nil nil org-download-screenshot-basename)
           nil)))
    (org-download-clipboard file)))

(after! org-download
  (setq org-download-method 'directory)
  (setq org-download-image-dir "images")
  (setq org-download-heading-lvl nil)
  (setq org-download-timestamp "%Y%m%d-%H%M%S_")
  (setq org-image-actual-width 300)
  (map! :map org-mode-map
        "C-c l a y" #'zz/org-download-paste-clipboard
        "C-M-y" #'zz/org-download-paste-clipboard))
;; ############# Org-mode-insert internal link ##############
(map! :after counsel :map org-mode-map
      "C-c l l h" #'counsel-org-link)
(after! counsel
  (setq counsel-outline-display-style 'title))
;; ############### undo-tree ####################
(global-undo-tree-mode 1)
;; ############### Harpoon config for doom emacs########;;
;;
;; ;;On vanilla (You can use another prefix instead C-c h)

;; ;; You can use this hydra menu that have all the commands
;; (global-set-key (kbd "C-c a") 'harpoon-quick-menu-hydra)
;; (global-set-key (kbd "C-c h <return>") 'harpoon-add-file)

;; ;; And the vanilla commands
;; (global-set-key (kbd "C-c h f") 'harpoon-toggle-file)
;; (global-set-key (kbd "C-c h h") 'harpoon-toggle-quick-menu)
;; (global-set-key (kbd "C-c h c") 'harpoon-clear)
;; (global-set-key (kbd "C-c h 1") 'harpoon-go-to-1)
;; (global-set-key (kbd "C-c h 2") 'harpoon-go-to-2)
;; (global-set-key (kbd "C-c h 3") 'harpoon-go-to-3)
;; (global-set-key (kbd "C-c h 4") 'harpoon-go-to-4)
;; (global-set-key (kbd "C-c h 5") 'harpoon-go-to-5)
;; (global-set-key (kbd "C-c h 6") 'harpoon-go-to-6)
;; (global-set-key (kbd "C-c h 7") 'harpoon-go-to-7)
;; (global-set-key (kbd "C-c h 8") 'harpoon-go-to-8)
;; (global-set-key (kbd "C-c h 9") 'harpoon-go-to-9)

;; On doom emacs

;; You can use this hydra menu that have all the commands
(map! :n "C-SPC" 'harpoon-quick-menu-hydra)
(map! :n "C-s" 'harpoon-add-file)

;; And the vanilla commands
(map! :leader "j c" 'harpoon-clear)
(map! :leader "j f" 'harpoon-toggle-file)
(map! :leader "1" 'harpoon-go-to-1)
(map! :leader "2" 'harpoon-go-to-2)
(map! :leader "3" 'harpoon-go-to-3)
(map! :leader "4" 'harpoon-go-to-4)
(map! :leader "5" 'harpoon-go-to-5)
(map! :leader "6" 'harpoon-go-to-6)
(map! :leader "7" 'harpoon-go-to-7)
(map! :leader "8" 'harpoon-go-to-8)
(map! :leader "9" 'harpoon-go-to-9)

;; And the vanilla commands
;; (map! :leader "j c" 'harpoon-clear)
;; (map! :leader "j f" 'harpoon-toggle-file)
(map! :leader "\\ n" 'harpoon-go-to-1)
(map! :leader "\\ e" 'harpoon-go-to-2)
(map! :leader "\\ i" 'harpoon-go-to-3)
(map! :leader "\\ o" 'harpoon-go-to-4)
;; (map! :leader "5" 'harpoon-go-to-5)
;; (map! :leader "6" 'harpoon-go-to-6)
;; (map! :leader "7" 'harpoon-go-to-7)
;; (map! :leader "8" 'harpoon-go-to-8)
;; (map! :leader "9" 'harpoon-go-to-9)
