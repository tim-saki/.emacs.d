;; no backup
(setq make-backup-files nil)

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
