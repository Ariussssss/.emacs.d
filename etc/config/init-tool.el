;;; Commentary:
;;; Package --- init-tool :

;;; 

;;; Code:


;; 撤销树
(use-package 
  undo-tree 
  :hook (after-init . global-undo-tree-mode)
  :bind (
	 ("C-_" . undo-tree-undo))
  :init (setq undo-tree-visualizer-timestamps t undo-tree-enable-undo-in-region nil undo-tree-auto-save-history nil)

  ;; HACK: keep the diff window
  (with-no-warnings (make-variable-buffer-local 'undo-tree-visualizer-diff) 
		    (setq-default undo-tree-visualizer-diff t)))

;; 括号匹配
(use-package 
  smartparens
  :ensure t
  :hook ('prog-mode . 'smartparens-global-mode))


;; 窗口管理器
(use-package 
  windmove
  :ensure t
  :bind(
	(
	 ("M-s-p" . windmove-right)
	 ("M-s-j" . windmove-up)
	 ("M-s-k" . windmove-down)
	 ("M-s-n" . windmove-left)
	 ;; ("M-s-j" . windmove-left)
	 ;; ("M-s-i" . windmove-up)
	 ;; ("M-s-k" . windmove-right)
	 ;; ("M-s-l" . windmove-right)
	 )
	)
  )


;; 项目管理
(use-package 
  projectile
  :ensure t)

;; 定位
(use-package 
  find-file-in-project
  :ensure t
  :bind (
	 ("C-c C-t" . find-file-in-project)))

;; git
(use-package magit
  :ensure t
  :custom
  (git-rebase-hash "plum3")
  :config
  (progn 
    ;; magit
    ;; Arius magit blame mode))
    (defalias 'Armb 'magit-blame)
    ;; Arius magit check-out
    (defalias 'Armco 'magit-file-checkout)
    ;; Arius magit diff
    (defalias 'Armd 'magit-diff-unstaged)
    ;; Arius magit stash list
    (defalias 'Armsl 'magit-stash-list)
    ;; Arius magit log
    (defalias 'Arml 'magit-log-all)
    ;; Arius magit log file
    (defalias 'Armlf 'magit-log-buffer-file)
    ;; Arius magit reflog
    (defalias 'Armrl 'magit-reflog-current))
  (set-face-attribute 'magit-hash nil :foreground "light pink")
  )

(use-package multiple-cursors
  :ensure t
  :bind (
	 ("C->" . mc/mark-next-like-this)
	 ("C-<" . mc/mark-previous-like-this)
	 ("C-c C->" . mc/mark-all-like-this)))

;; Emacs下最好用的终端仿真器，需要编译库，默认不开启
;; (use-package 
;;   vterm
;;   :ensure t
;;   :defer 2
;;   :config
;;   (progn
;;     (add-hook 'vterm-set-title-hook 'vterm--auto-rename-buffer)
;;     (defun vterm--set-title (title)
;;       (rename-buffer (format "%s" title)))
;;     )
;;   )
;; (defalias 'Artv 'vterm)

(use-package
  elescope
  :custom
  (elescope-root-folder "~/Packages")
  (elescope-clone-depth 1)
  (elescope-use-full-path t)
  :config
  (progn
    (defalias 'Arc 'elescope-checkout)
    (setq elescope-github-token nil)

    )
  )

(use-package
  osx-dictionary
  :disabled
  :ensure t
  :bind (("C-c d" .  osx-dictionary-search-pointer))
  )

(use-package
  youdao-dictionary
  :ensure t
  :config (setq url-automatic-caching nil) 
  (which-key-add-key-based-replacements "C-x y" "有道翻译") 
  :bind (("C-x y t" . 'youdao-dictionary-search-at-point+) 
         ("C-x y p" . 'youdao-dictionary-play-voice-at-point)
	 ("C-x y g" . 'youdao-dictionary-search-at-point-posframe) 
         ("C-x y r" . 'youdao-dictionary-search-and-replace) 
         ("C-x y i" . 'youdao-dictionary-search-from-input)))

;; 更改窗格布局
(use-package rotate
  :ensure t
  :bind ("C-<tab>" . 'rotate-window)
  )

;; 管理员模式编辑
(use-package sudo-edit
  :ensure t)

(use-package 
  howdoyou 
  :hook (after-init . howdoyou-mode)
  :bind ("C-x q" . 'howdoyou-region)
  :config
  (progn
    (defalias 'Ask 'howdoyou-query)
    (defalias 'Ans 
      (lambda ()
	(interactive)
	(switch-to-buffer "*How Do You*")))
    ))

(use-package
  recentf
  :ensure t
  :bind
  ("C-x C-r" . recentf-open-files)
  :custom
  (recentf-max-saved-items 50)
  (recentf-max-menu-items 50)
  )

(recentf-mode 1)

(use-package
  auto-save
  :custom
  (auto-save-slient nil)
  (auto-save-idle 2)
  :config
  (auto-save-enable)
  )

(use-package
  git-emoji
  :load-path"../site-vendor/git-emoji/git-emoji.el")

(use-package
  unity
  :load-path"../site-vendor/unity-mode.el/unity-mode.el")

(use-package
  zoom
  :disabled
  :ensure t
  :custom
  ;; (zoom-size '(0.618 . 0.618))
  (zoom-size '(0.5 . 0.5))
  :config
  (global-set-key (kbd "C-x +") 'zoom)
  )

(use-package
  zoom-window
  :ensure t
  :custom
  (zoom-window-mode-line-color "dark violet"))


;; hs-minor-mode
(use-package
  hideshow
  :ensure t
  :hook
  (hs-minor-mode .
	  (lambda ()
	    (progn
	      (defalias 'Arsc 'hs-hide-block)
	      (defalias 'Arst 'hs-toggle-hiding)
	      (defalias 'Arsl 'hs-hide-level)
	      (defalias 'Arss 'hs-show-all)))
	  )
  )

(use-package
  origami
  :ensure t
  :hook
  (origami-mode-hook .
	  (lambda ()
	    (progn
	      (defalias 'Arst 'origami-toggle-node)
	      (defalias 'Arsl 'origami-show-only-node)
	      (defalias 'Arss 'origami-open-all-nodes)))
))

(use-package
  ace-window
  :ensure t
  )

(use-package
  simple-httpd
  :ensure t)

(use-package
  quickrun
  :ensure t)

(use-package
  keyfreq
  :ensure t
  :config
  (setq keyfreq-excluded-commands
	'(self-insert-command
          forward-char
          backward-char
          previous-line
          next-line))
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1)
  )

;; Atom-like move regine/current line up and down.
(use-package move-text
  :ensure t
  :bind (("M-p" . move-text-up) ("M-n" . move-text-down)))

;; Built-in minor mode to open files at last-edited position.
(use-package saveplace
  ;; Don't set `:ensure t` for built-in packages, it will mess things up when
  ;; using `package-activate-all` instead of `package-initialize`.
  ;; Don't defer this if you want it to work on the first file you opened.
  :config
  (save-place-mode 1)
  :custom
  (save-place-file (locate-user-emacs-file ".local/places")))

(provide 'init-tool)
;;; init-tool.el ends here
