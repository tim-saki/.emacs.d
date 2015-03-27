;; no backup
(setq make-backup-files nil)
(setq auto-save-default nil)

;; display
(show-paren-mode t)
(global-linum-mode t)
(global-hl-line-mode t)
(setq-default show-trailing-whitespace t)
(setq-default indent-tabs-mode nil)
(menu-bar-mode -1)
(column-number-mode 1)

;; ui
(delete-selection-mode t)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq require-final-newline t)
(recentf-mode 1)

;;; scroll
(setq scroll-preserve-screen-position t)
(setq scroll-conservatively 1)

;;; winodow
(global-set-key (kbd "<left>") 'windmove-left)
(global-set-key (kbd "<right>") 'windmove-right)
(global-set-key (kbd "<up>") 'windmove-up)
(global-set-key (kbd "<down>") 'windmove-down)
(global-set-key (kbd "M-o") 'other-window)

;; functions
(defun indent-whole-buffer()
  "indent whole buffer"
  (interactive)
  (indent-region (point-min) (point-max) nil)
  )
(defun memo()
  "memo"
  (interactive)
  (find-file "~/memo/")
  )
(defun open()
  "open"
  (interactive)
  (shell-command (concat "open " (buffer-file-name)))
  )

;;; shortcut
(global-set-key (kbd "<f1>") 'indent-whole-buffer)
(global-set-key (kbd "<f2>") 'eval-current-buffer)

;; el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))

(setq my-el-get-packages
      (append
       '(
         helm
         auto-complete
         markdown-mode
         coffee-mode
         popwin
         direx
         zencoding-mode
         feature-mode
         undo-tree
         ruby-electric
         magit
         flycheck
         )))

(el-get 'sync my-el-get-packages)

;; helm
(when (require 'helm nil t)
  (global-set-key (kbd "C-c h") 'helm-mini)
  (helm-mode 1)
  (global-set-key (kbd "C-x C-r") 'helm-recentf)
  (global-set-key (kbd "C-x C-b") 'helm-buffers-list)
  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "M-s") 'helm-occur)
  )

;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'ruby-mode-hook
          '(lambda ()
             (setq flycheck-checker 'ruby-rubocop)
             (flycheck-mode 1)))

;; auto-complete
(when (require 'auto-complete nil t)
  (setq ac-use-menu-map t)
  (setq ac-auto-start 1)
  (setq ac-ignore-case nil)
  (global-auto-complete-mode t)
  (define-key ac-menu-map (kbd "C-n") 'ac-next)
  (define-key ac-menu-map (kbd "C-p") 'ac-previous)
  ;; enable auto-complete at specific mode
  (add-to-list 'ac-modes 'coffee-mode)
  )

;; markdown-mode
(when (require 'markdown-mode nil t)
  (autoload 'markdown-mode "markdown-mode"
    "Major mode for editing Markdown files" t)
  (add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
  )

;; coffee-mode
(when (require 'coffee-mode nil t)
  (defun coffee-custom ()
    "coffee-mode-hook"
    (and (set (make-local-variable 'tab-width) 2)
         (set (make-local-variable 'coffee-tab-width) 2)))
  (add-hook 'coffee-mode-hook '(lambda() (coffee-custom)))
  )

;; popwin
(when (require 'popwin nil t)
  (popwin-mode t))

;; direx
(when (require 'direx nil t)
  (push '(direx:direx-mode :position left :width 40 :dedicated t)
        popwin:special-display-config)
  (global-set-key (kbd "C-x C-j") 'direx:jump-to-directory-other-window)
  )

;; magit
(global-set-key (kbd "C-x g") 'magit-status)
(push '("\\*magit*" :regexp t) popwin:special-display-config)

;; zencoding-mode
(when (require 'zencoding-mode nil t)
  (add-hook 'sgml-mode-hook 'zencoding-mode)
  )

;; feature-mode
(when (require 'feature-mode nil t)
  (setq feature-default-language "ja")
  (add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))
  )

;; undo-tree
(when (require 'undo-tree nil t)
  (global-undo-tree-mode)
  )

;; python
(add-hook 'python-mode-hook
  (lambda ()
    (font-lock-add-keywords nil
      '(("^[^\n]\\{80\\}\\(.*\\)$" 1 font-lock-warning-face t)))))

;; ruby
(setq ruby-insert-encoding-magic-comment nil)

;; js
(setq js-indent-level 2)
