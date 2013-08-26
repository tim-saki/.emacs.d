;; no backup
(setq make-backup-files nil)

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
       '(helm
	 auto-complete)))

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
