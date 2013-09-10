;; no backup
(setq make-backup-files nil)

;; display
(show-paren-mode t)
(global-linum-mode t)
(global-hl-line-mode t)
(setq-default show-trailing-whitespace t)

;; ui
(delete-selection-mode t)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq require-final-newline t)

;;; scroll
(setq scroll-preserve-screen-position t)
(setq scroll-conservatively 1)
(setq scroll-margin 3)

;;; winodow
(global-set-key (kbd "<left>") 'windmove-left)
(global-set-key (kbd "<right>") 'windmove-right)
(global-set-key (kbd "<up>") 'windmove-up)
(global-set-key (kbd "<down>") 'windmove-down)
(global-set-key (kbd "M-o") 'other-window)

;; recentf
(recentf-mode 1)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

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
	 )))

(el-get 'sync my-el-get-packages)

(when (require 'helm nil t)
  (global-set-key (kbd "C-c h") 'helm-mini)
  (helm-mode 1)
  )

(when (require 'auto-complete nil t)
  (setq ac-use-menu-map t)
  (setq ac-auto-start 1)
  (setq ac-ignore-case nil)
  (global-auto-complete-mode t)
  (define-key ac-menu-map (kbd "C-n") 'ac-next)
  (define-key ac-menu-map (kbd "C-p") 'ac-previous)
  ;; enable auto-complete at specific mode
  ;; (add-to-list 'ac-modes 'coffee-mode)
  )

(when (require 'markdown-mode nil t)
  (autoload 'markdown-mode "markdown-mode"
    "Major mode for editing Markdown files" t)
  (add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
  )

(when (require 'coffee-mode nil t)
  (defun coffee-custom ()
    "coffee-mode-hook"
    (and (set (make-local-variable 'tab-width) 2)
	 (set (make-local-variable 'coffee-tab-width) 2)))
  (add-hook 'coffee-mode-hook '(lambda() (coffee-custom)))
  )
