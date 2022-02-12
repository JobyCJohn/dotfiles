(defun maximize-frame ()
  (interactive)
  (when (eq system-type 'windows-nt)
    (set-frame-width (selected-frame) 120)
    (set-frame-height (selected-frame) 36)))
(add-hook 'window-setup-hook 'maximize-frame t)

; start emacs in fullscreen mode
; (when (eq system-type 'windows-nt)
;   (add-hook 'emacs-startup-hook 'toggle-frame-maximized))

(defvar efs/default-font-size 100)
(defvar efs/default-variable-font-size 100)

(defun efs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                     (time-subtract after-init-time before-init-time)))
           gcs-done))
(add-hook 'emacs-startup-hook #'efs/display-startup-time)

; define and initialise package repositories
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
; use-package to simplify the config file
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)
(set-language-environment "UTF-8")
(column-number-mode t)
(global-display-line-numbers-mode t)

(setq use-package-always-ensure t)
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(setq display-line-numbers-type 'relative)
(setq visible-bell t)

; disable line numbers for some modes
(dolist (mode '(org-mode-hook
                 term-mode-hook
                 shell-mode-hook
                 treemacs-mode-hook
                 eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(set-face-attribute 'default nil :font "JetBrainsMono NF" :height efs/default-font-size)

; make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package undo-tree
  :after evil
  :diminish
  :config
  (evil-set-undo-system 'undo-tree)
  (global-undo-tree-mode 1))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

(use-package doom-themes
  :init
  (load-theme 'doom-gruvbox t))

(use-package all-the-icons)

(use-package doom-modeline
  :init
  (doom-modeline-mode 1)
  :custom
  ((doom-modeline-height 15)))

(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))

(use-package ivy
  :diminish
  :bind
  (("M-s" . counsel-grep-or-swiper))
  :config
  (ivy-mode 1)
  (setq ivy-initial-inputs-alist nil))

(use-package ivy-rich
  :config
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x))
  :config
  (counsel-mode 1))

(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package magit)
