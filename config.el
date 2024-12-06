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
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


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

;(server-start)
; Aparently doom emac start the server itself acording to numeral 7 on this link https://discourse.doomemacs.org/t/common-config-anti-patterns/119



;; ################ Latex editing #####################


;; ;; This to use the pdf viewer
;; (after! latex
(setq +latex-viewers '(pdf-tools))
;; (setq +latex-viewers '(okular))
;; ;; LSP server fot latex
(setq lsp-tex-server 'texlab)
;; ;(after! latex
;; ;; This is for useing xenops for rendering tables in buffer
;;
(after! latex
(add-hook 'LaTeX-mode-hook #'xenops-mode) ;
;; Turn on RefTeX in AUCTeX
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
  ;; )                                     ;
;; ; This is for inverse search  taken from https://inthearmchair.wordpress.com/2010/09/02/latex-inverse-pdf-search-with-emacs/
;; ;(add-hook ‘LaTeX-mode-hook ‘TeX-DF-mode)
;; ;'(LaTeX-command "latex -synctex=1")
;; ;'(TeX-output-view-style '(("^pdf$" "." "okular %s.pdf")))

;; ;Taken from https://michaelneuper.com/posts/efficient-latex-editing-with-emacs/#cdlatex
(map! :map cdlatex-mode-map
      :i "TAB" #'cdlatex-tab)
)

;; Activate nice interface between RefTeX and AUCTeX

;; ################ Snippets ##########################
;;
;;################# Biblio ############################
(after! citar
  (setq! citar-bibliography '("~/home/luisaam/Documents/Thesis/References/all_zotero_references.bib"))
  (setq! citar-library-paths '("~/home/luisaam/Documents/Thesis/References/"))
  (setq! citar-notes-paths '("~/references/notes")))

;; ################  Sniper package #####################
;;
(after! evil-snipe
  (evil-snipe-mode +1)
(evil-snipe-override-mode +1)
(add-hook 'magit-mode-hook 'turn-off-evil-snipe-override-mode)
(setq evil-snipe-scope 'whole-visible)
)


;; ###########################################################
;;                      Auto save
;; ###########################################################
(after! super-save
;; This auto saves the buffer when I change focus
(super-save-mode +1)
;;Saves when idle
(setq super-save-auto-save-when-idle t)
;; deactivates emacs's default autosave (it already is turned off by default in doom emacs but ill put it her anyway)
(setq auto-save-default nil)

)
