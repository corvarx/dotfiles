(put 'dired-find-alternate-file 'disabled nil)
(require 'mouse)


;; Oneline switch
(which-function-mode 1) ;; display function name at the mode line
(setq scroll-step 1)
(setq mouse-wheel-scroll-amount '(3 ((shift) . 1)))
(setq make-backup-files nil)
(xterm-mouse-mode t)
(global-display-line-numbers-mode t)
(unless (display-graphic-p) (menu-bar-mode -1))
(setq require-final-newline nil)
(setq-default c-basic-offset 4)
(add-hook 'python-mode-hook
	  (lambda ()
	    (setq python-indent-offset 4)))

;; Set JavaScript indentation to 4 spaces
(setq js-indent-level 4)
;; Set js2-mode indentation to 4 spaces
(add-hook 'js2-mode-hook
          (lambda ()
            (setq js2-basic-offset 4)))
;; Key-bind
(global-set-key (kbd "C-x C-b") 'ibuffer)

;;; Using C-o to search the word under cursor, no matter where the cursor is
(defun isearch-word-at-point ()
  (interactive)
  (let ((symbol (thing-at-point 'symbol))) ; Changed from 'word' to 'symbol'
    (when symbol
      (isearch-forward nil 1)
      (isearch-yank-string symbol))))
(global-set-key (kbd "C-o") 'isearch-word-at-point)

;;; Quickly open .emacs C-c e
(defun open-emacs-config ()
  "Open the Emacs configuration file."
  (interactive)
  (find-file "~/.emacs"))  ; Replace "~/.emacs" with the path to your actual config file, if different.
(global-set-key (kbd "C-c e") 'open-emacs-config)



;; Fun Pakcages
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
;; Ensure `straight.el` is installed as shown in Step 1
;; Then install the Doom themes package
(straight-use-package 'doom-themes)
(require 'doom-themes)
(load-theme 'doom-dracula t)
(doom-themes-visual-bell-config)
(doom-themes-org-config)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("e14884c30d875c64f6a9cdd68fe87ef94385550cab4890182197b95d53a7cf40" "691d671429fa6c6d73098fc6ff05d4a14a323ea0a18787daeb93fde0e48ab18b" "c8b3d9364302b16318e0f231981e94cbe4806cb5cde5732c3e5c3e05e1472434" "8b148cf8154d34917dfc794b5d0fe65f21e9155977a36a5985f89c09a9669aa0" "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" "7e377879cbd60c66b88e51fad480b3ab18d60847f31c435f15f5df18bdb18184" "6a5584ee8de384f2d8b1a1c30ed5b8af1d00adcbdcd70ba1967898c265878acf" "6f1f6a1a3cff62cc860ad6e787151b9b8599f4471d40ed746ea2819fcd184e1a" "f5f80dd6588e59cfc3ce2f11568ff8296717a938edd448a947f9823a4e282b66" "38c0c668d8ac3841cb9608522ca116067177c92feeabc6f002a27249976d7434" "88f7ee5594021c60a4a6a1c275614103de8c1435d6d08cc58882f920e0cec65e" "4594d6b9753691142f02e67b8eb0fda7d12f6cc9f1299a49b819312d6addad1d" "37b6695bae243145fa2dfb41440c204cd22833c25cd1993b0f258905b9e65577" "81f53ee9ddd3f8559f94c127c9327d578e264c574cda7c6d9daddaec226f87bb" "0c83e0b50946e39e237769ad368a08f2cd1c854ccbcd1a01d39fdce4d6f86478" "ffafb0e9f63935183713b204c11d22225008559fa62133a69848835f4f4a758c" "f4d1b183465f2d29b7a2e9dbe87ccc20598e79738e5d29fc52ec8fb8c576fcfd" "7964b513f8a2bb14803e717e0ac0123f100fb92160dcf4a467f530868ebaae3e" "8c7e832be864674c220f9a9361c851917a93f921fedb7717b1b5ece47690c098" default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; Refresh package descriptions
(when (not package-archive-contents)
  (package-refresh-contents))

;; Install markdown-mode if it's not already installed
(unless (package-installed-p 'markdown-mode)
  (package-install 'markdown-mode))


;;(add-hook 'c-mode-hook 'origami-mode)
;;(add-hook 'c++-mode-hook 'origami-mode)

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode 1))

;; (use-package emacs
;;   :init
;;   ;; Add prompt indicator to `completing-read-multiple'.
;;   ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
;;   (defun crm-indicator (args)
;;     (cons (format "[CRM%s] %s"
;; 		  (replace-regexp-in-string
;; 		   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
;; 		   crm-separator)
;; 		  (car args))
;; 	  (cdr args)))
;;   (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

;;   ;; Do not allow the cursor in the minibuffer prompt
;;   (setq minibuffer-prompt-properties
;; 	'(read-only t cursor-intangible t face minibuffer-prompt))
;;   (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

;;   ;; Support opening new minibuffers from inside existing minibuffers.
;;   (setq enable-recursive-minibuffers t)

;;   ;; Emacs 28 and newer: Hide commands in M-x which do not work in the current
;;   ;; mode.  Vertico commands are hidden in normal buffers. This setting is
;;   ;; useful beyond Vertico.
;;   (setq read-extended-command-predicate #'command-completion-default-include-p))

;; ;; Option 1: Additional bindings
;; (keymap-set vertico-map "?" #'minibuffer-completion-help)
;; (keymap-set vertico-map "M-RET" #'minibuffer-force-complete-and-exit)
;; (keymap-set vertico-map "M-TAB" #'minibuffer-complete)

;; ;; Option 2: Replace `vertico-insert' to enable TAB prefix expansion.
;; ;; (keymap-set vertico-map "TAB" #'minibuffer-complete)
;; (setq completion-styles '(substring orderless basic))
;; ;;(setq completion-styles '(basic substring partial-completion flex))


;; (setq read-file-name-completion-ignore-case t
;;       read-buffer-completion-ignore-case t
;;       completion-ignore-case t)

;; ;; Use `consult-completion-in-region' if Vertico is enabled.
;; ;; Otherwise use the default `completion--in-region' function.
;; (setq completion-in-region-function
;;       (lambda (&rest args)
;; 	(apply (if vertico-mode
;; 		   #'consult-completion-in-region
;; 		 #'completion--in-region)
;;	       args)))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 'official)) ; Use the official Emacs logo

;; (use-package helm
;;   :ensure t
;;   :bind (("M-x" . helm-M-x)
;;          ("C-x C-f" . helm-find-files)
;;          ("C-x b" . helm-buffers-list)
;;          ("C-x C-r" . helm-recentf)
;;          ("M-y" . helm-show-kill-ring))
;;   :config
;;   (helm-mode 1))


(defalias 'ro 'read-only-mode)
(defun execute-command-by-alias ()
  (interactive)
  (let ((command (completing-read "Execute command: " obarray 'commandp t nil 'command-history)))
    (when command
      (call-interactively (intern command)))))
(global-set-key (kbd "C-c x") 'execute-command-by-alias)  ; Replace 'C-c e' with your preferred key sequence


(defun my-start-gdb ()
  "Start gdb with predefined settings."
  (interactive)
  (gdb "gdb --cd=/path/to/directory -i=mi executableName"))

;; (add-hook 'c-mode-common-hook 'hs-minor-mode)
;; (define-key hs-minor-mode-map (kbd "C-c @ C-h") 'hs-hide-block)
;; (define-key hs-minor-mode-map (kbd "C-c @ C-s") 'hs-show-block)
;; (define-key hs-minor-mode-map (kbd "C-c @ C-c") 'hs-toggle-hiding)
;; (define-key hs-minor-mode-map (kbd "C-c @ C-M-h") 'hs-hide-all)
;; (define-key hs-minor-mode-map (kbd "C-c @ C-M-s") 'hs-show-all)

(defun reload-emacs-config ()
  "Reload the Emacs configuration."
  (interactive)
  (load-file "~/.emacs"))
  
(global-set-key (kbd "C-c r") 'reload-emacs-config)

;; (use-package spaceline
;;   :ensure t
;;   :config
;;   (require 'spaceline-config)
;;   (spaceline-spacemacs-theme))
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-height 15))

(unless (display-graphic-p)
  (set-face-attribute 'default nil
                      :font "3270 Nerd Font Mono"
                      :height 120))

(setq doom-modeline-icon t)
(setq doom-modeline-time t)
(setq doom-modeline-window-width-limit fill-column)
(setq doom-modeline-buffer-file-name-style 'truncate-upto-project)
(setq doom-modeline-major-mode-icon t)
(setq doom-modeline-time-analogue-clock t)
(setq doom-modeline-time-clock-size 0.7)
(setq doom-modeline-unicode-fallback nil)
(setq doom-modeline-buffer-name t)
(setq doom-modeline-enable-word-count t)
(setq doom-modeline-modal-modern-icon t)
(setq doom-modeline-time-analogue-clock t)
(setq doom-modeline-buffer-file-name-style 'relative-from-project)

;; (use-package all-the-icons-dired
;;   :ensure t
;;   :hook (dired-mode . all-the-icons-dired-mode))


(require 'ansi-color)
(defun my-colorize-compilation-buffer ()
  (when (eq major-mode 'compilation-mode)
    (ansi-color-apply-on-region compilation-filter-start (point-max))))
(add-hook 'compilation-filter-hook 'my-colorize-compilation-buffer)


;; Beautiful
(global-hl-line-mode 1)
(set-face-background 'hl-line "#5e0101")
(custom-set-faces
 '(region ((t (:background "#250394")))))
(set-face-foreground 'font-lock-comment-face "#037994")


(setq gdb-many-windows t)  ; Use a layout with multiple windows by default in GDB
(setq gdb-show-main t)     ; Show the main function automatically when GDB starts

(windmove-default-keybindings)
(global-set-key (kbd "S-<up>") 'windmove-up)
(global-set-key (kbd "S-<down>") 'windmove-down)
(global-set-key (kbd "S-<left>") 'windmove-left)
(global-set-key (kbd "S-<right>") 'windmove-right)

(use-package eyebrowse
  :ensure t
  :config
  (eyebrowse-mode t)
  (setq eyebrowse-new-workspace t))

(winner-mode 1)

;;(setq markdown-command "pandoc -f markdown -t html")
