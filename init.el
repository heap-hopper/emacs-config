(setq inhibit-startup-message t)
(setq visible-bell nil)
(setq ring-bell-function 'ignore)

;; ui settings
(tool-bar-mode -1)
(scroll-bar-mode -1)
(set-fringe-mode 10)
(global-display-line-numbers-mode 1)
(load-theme 'wombat)

;; backup files
(setq make-backup-files nil)
(setq auto-save-default t)

;; font config
(set-face-attribute 'default nil :height 210)
(set-face-attribute 'default nil :font "agave Nerd Font Mono")

;; macos keys 
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'none)
(setq default-input-method "MacOSX")

(require 'package)

(package-initialize)
(add-to-list 'package-archives '("elpa" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(magit dart-mode lsp-dart lsp-treemacs flycheck company lsp-ui hover)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(require 'use-package)
(setq use-package-always-ensure t)

(use-package ivy
  :diminish
  :bind(("C-s" . swiper) :map ivy-minibuffer-map
        ("TAB" . ivy-alt-done)
        ("C-l" . ivy-alt-done)
        ("C-j" . ivy-next-line))
  :config
  (ivy-mode 1)) 


(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history)))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))


(use-package evil
  :init

  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))
  

(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))


;; TODO: Check this
;; Interessant Configuration from https://emacs-lsp.github.io/lsp-dart/
(setq package-selected-packages
      '(dart-mode lsp-dart lsp-treemacs flycheck company lsp-ui hover))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc  #'package-install package-selected-packages))

(add-hook 'dart-mode-hook 'lsp)
      
;; TODO
(setq gc-cons-threshold (* 100 1024 1024)
     read-process-output-max (* 1024 1024))


;; Experimental
(use-package lsp-pascal
  :hook (pascal-mode . lsp-deferred))

;; TODO Plantuml
(use-package plantuml-mode
  :mode "\\.plantuml\\'")
(setq plantuml-jar-path "~/plantuml.jar")
(setq plantuml-default-exec-mode 'jar)
(setq plantuml-output-type "png")

(auto-image-file-mode 1)

(use-package vterm
  :ensure t)

;; Yaml support
(use-package yaml-mode)

;; C, C++ and Objective-C support
(use-package eglot
  :ensure t)

(add-to-list 'eglot-server-programs '((c++mode c-mode) "clangd"))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

;; Latex support
(use-package latex-preview-pane)
(latex-preview-pane-enable)

;; Magit Support
(use-package magit)
