;(require 'org)
;(define-key global-map "\C-cl" 'org-store-link)
;(define-key global-map "\C-ca" 'org-agenda)
;(setq org-log-done t)

;; Set up the package manager and repositories
(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

;; Install use-package if not installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))


;; Show Parenthesis Mode
(setq show-paren-delay 0)
(show-paren-mode 1)

;; Hide the toolbar and menubar
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Don't create backups
(setq make-backup-files nil)

;; Disable scroll bar
(scroll-bar-mode -1)

;; Load packages
(use-package evil
  :ensure t
  :config
  (evil-mode 1)

  ;; Evil key bindings
  (define-key evil-motion-state-map "j" 'evil-next-visual-line)
  (define-key evil-motion-state-map "k" 'evil-previous-visual-line)

  (use-package evil-leader
    :ensure t
    :config
    (global-evil-leader-mode)

    (evil-leader/set-leader "<SPC>")
    (evil-leader/set-key
      "x" 'helm-M-x
      "<SPC>" 'evil-search-highlight-persist-remove-all))

  (use-package evil-search-highlight-persist
   :ensure t
   :config
   (global-evil-search-highlight-persist t)))

(use-package gruvbox-theme
  :ensure t)

; Smooth scrolling on file limits
(use-package smooth-scrolling
  :ensure t
  :config
  (smooth-scrolling-mode 1))

; SimpleClip Super+C Super+X Super+V
(use-package simpleclip
  :ensure t
  :config
  (simpleclip-mode 1))

(use-package fill-column-indicator
  :ensure t
  :config
  ;(fci-mode)           ;activate fill-column-indicator. use lambda hook
  (set-fill-column 80))

;; Wrap lines
(global-visual-line-mode 1)

;; Show margin line numbers
(use-package nlinum
  :ensure t
  :config

  ;(global-nlinum-mode t)

  (use-package nlinum-relative
    :ensure t
    :config
   ;; something else you want
    (nlinum-relative-setup-evil)
    (setq nlinum-relative-redisplay-delay 0)
    (add-hook 'prog-mode-hook 'nlinum-relative-mode)))

(use-package linum-off
  :ensure t
  ;(setq linum-disabled-modes-list ‘(eshell-mode wl-summary-mode compilation-mode))
)

;; Zsh Tab completion for minibuffer
(use-package zlc
  :ensure t
  :config
  (zlc-mode t))

;; Spell checker
(when (executable-find "hunspell")
  (setq-default ispell-program-name "hunspell")
  (setq ispell-dictionary "es_ES")
  (setq ispell-really-hunspell t))

;; Word Count
(use-package wc-mode
  :ensure t
  :config)

;; org-mode
(setq org-ellipsis " \u2935")

(use-package org-ref
  :ensure t
  :config

  (setq org-src-preserve-indentation t)

  (setq org-latex-default-packages-alist
	(-remove-item
	 '("" "hyperref" nil)
	 org-latex-default-packages-alist))

  (add-to-list 'org-latex-default-packages-alist '("" "natbib" "") t)
  (add-to-list 'org-latex-default-packages-alist
	       '("linktocpage,pdfstartview=FitH,colorlinks,linkcolor=black,anchorcolor=black,citecolor=black,filecolor=blue,menucolor=black,urlcolor=blue"
		 "hyperref" nil)
	       t)

  (progn
    (setq org-ref-bibliography-notes "~/Drive/org/bibliography/notes.org"
          org-ref-default-bibliography '("~/Drive/org/bibliography/main.bib")
          org-ref-pdf-directory "~/Drive/org/bibliography/pdfs"
          org-latex-pdf-process
          '("pdflatex -interaction nonstopmode -output-directory %o %f"
            "bibtex %b"
            "pdflatex -interaction nonstopmode -output-directory %o %f"
            "pdflatex -interaction nonstopmode -output-directory %o %f")))

  (setq bibtex-autokey-year-length 4
      bibtex-autokey-name-year-separator "-"
      bibtex-autokey-year-title-separator "-"
      bibtex-autokey-titleword-separator "-"
      bibtex-autokey-titlewords 2
      bibtex-autokey-titlewords-stretch 1
      bibtex-autokey-titleword-length 5))

(use-package org-autolist
  :ensure t
  :config (add-hook 'org-mode-hook (lambda () (org-autolist-mode))))

(use-package org-bullets
  :ensure t)
  ;:config
  ;(progn
  ;  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  ;  (setq org-bullets-bullet-list
  ;        '("\u25c9" "\u25ce" "\u25cb" "\u25cb" "\u25cb" "\u25cb"))))

;; Add these evil keybindings in Emacs mode
(evil-add-hjkl-bindings occur-mode-map 'emacs
  (kbd "/")       'evil-search-forward
  (kbd "n")       'evil-search-next
  (kbd "N")       'evil-search-previous
  (kbd "C-d")     'evil-scroll-down
  (kbd "C-u")     'evil-scroll-up
  (kbd "C-w C-w") 'other-window)

;; Keyboard maps
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (gruvbox-dark-hard)))
 '(custom-safe-themes
   (quote
    ("7f3ef7724515515443f961ef87fee655750512473b1f5bf890e2dc7e065f240c" "65d9573b64ec94844f95e6055fe7a82451215f551c45275ca5b78653d505bc42" "5a970147df34752ed45bfdf0729233abfc085d9673ae7e40210c5e2d8f624b08" "dc9a8d70c4f94a28aafc7833f8d05667601968e6c9bf998791c39fcb3e4679c9" "125fd2180e880802ae98b85f282b17f0aa8fa6cb9fc4f33d7fb19a38c40acef0" "2b6bd2ebad907ee42b3ffefa4831f348e3652ea8245570cdda67f0034f07db93" default)))
 '(package-selected-packages (quote (ox-latex-chinese zlc helm evil))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
