;;; Package --- init UI :

;;; Commentary:
;;; 

;;; Code:

(setq ns-auto-hide-menu-bar nil)
(set-frame-position nil 0 -24)
(tool-bar-mode 0)
(set-frame-size nil 150 80)

;; 设置光标颜色
;; (set-cursor-color "green2")
;; 设置光标样式
(setq-default cursor-type 'box)

;; 高亮当前行
(global-hl-line-mode 1)

;; 主题包									
(use-package
  doom-themes
  :ensure t
  :config
  ;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
  ;; may have their own settings.
  ;; doom-city-lights Professional!
  ;; doom-laserwave cyberpunk
  ;; doom-ephemeral cute
  ;; doom-moonlight
  ;; doom-horizon
  ;; (load-theme 'doom-laserwave t)
  ;; (load-theme 'doom-challenger-deep t)
  (load-theme 'doom-outrun-electric t)
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  (doom-themes-neotree-config)
  (doom-themes-org-config)
  (setq doom-themes-enable-bold t ; if nil, bold is universally disabled
	doom-themes-enable-italic t
	doom-themes-treemacs-theme "doom-colors") ; if nil, italics is universally disabled
  )
;; https://github.com/doomemacs/themes/tree/screenshots

;; 图标支持
(use-package
  all-the-icons
  :ensure t)

;; dired模式图标支持
(use-package
  all-the-icons-dired
  :ensure t
  :hook
  (dired-mode . all-the-icons-dired-mode))

;; 浮动窗口支持
(use-package
  posframe
  :ensure t)

;; 竖线
(use-package
  page-break-lines
  :ensure t
  :hook (after-init . page-break-lines-mode))

(global-page-break-lines-mode)

;; 启动界面
(use-package
  dashboard
  :ensure t
  :init
  (dashboard-setup-startup-hook)
  :custom
  (dashboard-modify-heading-icons '((recents . "file-text")))
  ;; 设置标题
  (dashboard-banner-logo-title
   "En Taro Tassadar")
  ;; 设置banner
  (dashboard-items '((recents  . 5)
                     (projects . 5)
                     (agenda . 5)))
  ;; (setq show-week-agenda-p nil)
  (dashboard-image-banner-max-width 300)
  (dashboard-startup-banner "~/.emacs.d/var/banner/logo.png")
  (dashboard-center-content t) 
  (dashboard-set-heading-icons t)
  
  (dashboard-set-file-icons t)
  (dashboard-set-navigator t))


;; modeline样式
(use-package 
  doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom
  (doom-modeline-height 10)
  (doom-modeline-bar-width 3)
  (doom-modeline-buffer-file-name-style 'truncate-all)
  :config
  (custom-set-faces '(mode-line ((t 
				  (
				   ;; :family evan/font-name
				   ;; :style evan/font-style
				   :height 125)))) 
		    '(mode-line-inactive ((t 
					   (
					    ;; :family evan/font-name
					    ;; :style evan/font-size
					    :height 125))))))
;; 彩虹括号
(use-package 
  rainbow-delimiters 
  :ensure t 
  :config
  ;; 设置每一级括号的颜色
  (set-face-foreground 'rainbow-delimiters-depth-1-face "pink1") 
  (set-face-foreground 'rainbow-delimiters-depth-2-face "DodgerBlue1") 
  (set-face-foreground 'rainbow-delimiters-depth-3-face "DarkOrange2")
  (set-face-foreground 'rainbow-delimiters-depth-4-face "deep pink") 
  (set-face-foreground 'rainbow-delimiters-depth-5-face "medium orchid") 
  (set-face-foreground 'rainbow-delimiters-depth-6-face "turquoise") 
  (set-face-foreground 'rainbow-delimiters-depth-7-face "lime green") 
  (set-face-foreground 'rainbow-delimiters-depth-8-face "gold") 
  (set-face-foreground 'rainbow-delimiters-depth-9-face "cyan") 
  (set-face-bold 'rainbow-delimiters-depth-1-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-2-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-3-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-4-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-5-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-6-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-7-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-8-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-9-face "t") 
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))


;; 缩进线
(use-package
  indent-guide
  :ensure t
  :hook (prog-mode . indent-guide-mode))

;; 彩虹猫进度条
(use-package nyan-mode
  :ensure t
  :hook (after-init . nyan-mode)
  :custom
  (nyan-wavy-tail t)
  (nyan-animate-nyancat t)
  (nyan-animation-frame-interval .5)
  )
(nyan-mode)


(defun arz/custom-ui ()
  (interactive)
  ;; (setq default-frame-alist '((alpha-background . 50)) )
  (set-frame-font "Comic Mono NF 10" nil t)
  
  (set-fontset-font t 'han (font-spec :family "142\-SS Zong Yi Ti" :size 16))
  ;; (set-frame-font "Sauce Code Pro NF 10" nil t)
  (set-face-attribute 'default nil :font "Comic Mono NF" :height 100)
  (set-face-attribute 'hl-line nil :background "VioletRed4" )
  (set-face-attribute
   'region nil
   :foreground "VioletRed4"
   :background "cyan4")

  (set-face-foreground 'font-lock-comment-face "plum3")
  (set-face-foreground 'org-block-begin-line "plum3")
  (set-face-foreground 'org-code "hot pink")
  (set-face-foreground 'org-headline-done "plum3")
  (set-face-attribute 'ivy-current-match nil
		      :foreground "white"
		      :background "cyan4")
  
  (set-face-attribute
   'line-number nil
   :foreground "turquoise3"))
(arz/custom-ui)

(defun arz/reset-theme ()
  (interactive)
  (load-file "~/.emacs.d/etc/config/init-ui.el")
  )

 (provide 'init-ui)
;;; init-ui.el ends here
