;;; Package --- init-base :

;;; Commentary:
;;; Emacs 基础功能修改

;;; Code:

;; yes-or-no-p to y-or-n-p
(fset 'yes-or-no-p 'y-or-n-p)

(setq auto-save-list-file-prefix "~/.emacs.d/var/auto-save-list/.saves-")

(setq dired-listing-switches "-alFhS")

;; 关闭工具栏
(tool-bar-mode -1)
(menu-bar-mode -1)

;; 关闭滚动条
(scroll-bar-mode -1)

;; 关闭自动调节行高
(setq auto-window-vscroll nil)

;; 选中时输入覆盖
;; (delete-selection-mode -1)

;; 高亮对应的括号
(show-paren-mode 1)

(global-display-line-numbers-mode t)

(use-package anzu
  :ensure t
  :config
  (global-anzu-mode 1))

(use-package request
  :ensure t)

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode))

(scroll-bar-mode -1)

;; 关闭自动调节行高
(setq auto-window-vscroll nil)

;; 关闭备份
;; (setq make-backup-files t auto-save-default t)

;; 更友好及平滑的滚动
(setq scroll-step 2
      scroll-margin 2
      hscroll-step 2
      hscroll-margin 2
      scroll-conservatively 101
      scroll-up-aggressively 0.01
      scroll-down-aggressively 0.01
      scroll-preserve-screen-position 'always)


(setq shell-file-name "/bin/zsh")

;; 创建新行的动作
;; 回车时创建新行并且对齐
(global-set-key (kbd "RET") 'newline-and-indent)

(use-package
  git-gutter
  :ensure t
  :config
  (set-face-attribute 'git-gutter:added nil :foreground "light pink")
  )

(global-git-gutter-mode t)

;; 键位提示
(use-package which-key
  :ensure t
  :custom
  ;; 弹出方式，底部弹出
  (which-key-popup-type 'side-window)
  :config
  (which-key-mode))

(use-package posframe
  :ensure t)

(use-package
  which-key-posframe
  :load-path "../site-vendor/which-key-posframe/which-key-posframe.el"
  :config
  (which-key-posframe-mode))

;; 让光标无法离开视线
(setq mouse-yank-at-point nil)

;; 增强了搜索功能
(use-package swiper
  :ensure t
  :bind
  (
   ("M-i" . swiper-thing-at-point)
   ("C-c C-r" . ivy-resume)
   ("M-x" . counsel-M-x))
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-height 28)
    (set-face-attribute 'ivy-current-match nil :foreground "violet red")
    (setq ivy-use-virtual-buffers t)
    (setq ivy-display-style 'fancy)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)))


(use-package posframe
  :ensure t)

(winner-mode t)
(global-set-key (kbd "C-c p") 'winner-undo)
(global-set-key (kbd "C-c n") 'winner-redo)
(global-set-key (kbd "C-x p") 'previous-buffer)
(global-set-key (kbd "C-x n") 'next-buffer)

(use-package so-long
  :ensure t
  :config (global-so-long-mode 1))

(use-package all-the-icons-ivy
  :ensure t
  :init (add-hook 'after-init-hook 'all-the-icons-ivy-setup))

(use-package 
  all-the-icons-ivy-rich 
  :ensure t 
  :init (all-the-icons-ivy-rich-mode 1))

(use-package 
  ivy-rich 
  :ensure t 
  :init (ivy-rich-mode 1) 
  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)
  :custom
  (ivy-posframe-parameters '((alpha . 85)))
  :config (setq
	   ivy-rich-display-transformers-list
	   '(ivy-switch-buffer 
	     (:columns ((ivy-rich-switch-buffer-icon 
			 (:width 2)) 
			(ivy-rich-candidate 
			 (:width 30)) 
			(ivy-rich-switch-buffer-size 
			 (:width 7)) 
			(ivy-rich-switch-buffer-indicators 
			 (:width 4 
				 :face error 
				 :align right)) 
			(ivy-rich-switch-buffer-major-mode 
			 (:width 12 
				 :face warning)) 
			(ivy-rich-switch-buffer-project 
			 (:width 15 
				 :face success)) 
			(ivy-rich-switch-buffer-path 
			 (:width (lambda (x) 
				   (ivy-rich-switch-buffer-shorten-path
				    x
				    (ivy-rich-minibuffer-width
				     0.3)))))) 
		       :predicate (lambda (cand) 
				    (get-buffer cand)))
	     counsel-find-file 
	     (:columns ((ivy-read-file-transformer) 
			(ivy-rich-counsel-find-file-truename 
			 (:face font-lock-doc-face))))
	     counsel-M-x 
	     (:columns ((counsel-M-x-transformer 
			 (:width 40)) 
			(ivy-rich-counsel-function-docstring 
			 (:face font-lock-doc-face)))) ; return docstring of the command
	     counsel-recentf 
	     (:columns ((ivy-rich-candidate 
			 (:width 0.8)) 
			(ivy-rich-file-last-modified-time 
			 (:face font-lock-comment-face)))) ; return last modified time of the file
	     counsel-describe-function 
	     (:columns
	      ((counsel-describe-function-transformer 
		(:width 40)) 
	       (ivy-rich-counsel-function-docstring 
		(:face font-lock-doc-face)))) ; return docstring of the function
	     counsel-describe-variable 
	     (:columns
	      ((counsel-describe-variable-transformer 
		(:width 40)) 
	       (ivy-rich-counsel-variable-docstring 
		(:face font-lock-doc-face)))) ; return docstring of the variable
	     )))

(use-package counsel-projectile
  :ensure t)

(use-package ivy-posframe
  :ensure t
  :init
  (setq ivy-posframe-hide-minibuffer nil
        ivy-posframe-border-width 0
        ivy-display-function #'ivy-posframe-display-at-frame-center)
  :custom
  (ivy-posframe-width 200)
  (ivy-posframe-height 30)
  :config
  (progn
    (ivy-posframe-mode 1)
    ))

(provide 'init-base)
;;; init-base.el ends here
