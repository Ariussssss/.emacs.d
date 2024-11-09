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
	 ("M-s-k" . windmove-up)
	 ("M-s-j" . windmove-down)
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
    (defalias 'Gst 'magit-status)
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
  :defer
  :init
  (add-hook 'multiple-cursors-mode-hook
            (defun my/work-around-multiple-cursors-issue ()
              (load "multiple-cursors-core.el")
              (remove-hook 'multiple-cursors-mode-hook #'my/work-around-multiple-cursors-issue)))
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
    )
  )

(use-package
  youdao-dictionary
  :ensure t
  :custom
  (youdao-dictionary-app-key "066041769a38ebb9")
  (youdao-dictionary-secret-key "m4VKNceeMwB88NfYSRyHGYVjEieP4ou7")
  :config (setq url-automatic-caching nil) 
  (which-key-add-key-based-replacements "C-x y" "有道翻译") 
  :bind (
	 ("C-x y t" . (lambda ()
			(interactive)
			(youdao-dictionary-play-voice-at-point)
			(youdao-dictionary-search-at-point+))) 
         ("C-x y p" . 'youdao-dictionary-play-voice-at-point)
	 ("C-x y g" . 'youdao-dictionary-search-at-point-posframe) 
         ("C-x y r" . 'youdao-dictionary-search-and-replace) 
         ("C-x y i" . 'youdao-dictionary-search-from-input)))

(defun arz/youdao ()
  (interactive)
  (youdao-dictionary-play-voice-at-point)
  (youdao-dictionary-search-at-point+))

(use-package xclip
  :ensure t
  :config
  (xclip-mode 1)
  (custom-set-variables '(x-select-enable-clipboard t)))

;; (use-package
;;   go-translate
;;   :ensure t
;;   :config
;;   (setq gts-default-translator (gts-translator :engines (gts-bing-engine)))
;;   (setq gts-translate-list '(("en" "zh")))
;;   )

(defun arz/bing-translate ()
  (interactive)
  (gts-translate (gts-translator
                  :picker (gts-noprompt-picker)
                  :engines (gts-bing-engine)
                  :render (gts-posframe-pop-render))))

;; (global-set-key (kbd "C-x y") 'arz/bing-translate)

(use-package fanyi
  :ensure t
  :custom
  (fanyi-providers '(;; 海词
                     ;; fanyi-haici-provider
         	     ;; Etymonline
                     ;; fanyi-etymon-provider
		     ;; Longman
                     fanyi-longman-provider
	             ;; 有道同义词词典
                     ;; fanyi-youdao-thesaurus-provider
                     ))
  :bind (
	 ;; ("C-x y t" . 'fanyi-dwim2) 
	 )
  )
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
  :disabled t
  :config
  (save-place-mode 1)
  :custom
  (save-place-file (locate-user-emacs-file "~/.local/places")))

;; Key	Action
;; RET	Visit the result, file or push button at point
;; o	Visit the result in another window
;; n and p	Move between search hits
;; M-n and M-p	Move between file headers
;; The commands deadgrep-forward and deadgrep-backward are also available to move between buttons as well as search hits.

;; Starting/stopping a search:

;; Key	Action
;; S	Change the search term
;; T	Cycle through available search types: string, words, regexp
;; C	Cycle through case sensitivity types: smart, sensitive, ignore
;; F	Cycle through file modes: all, type, glob
;; I	Switch to incremental search, re-running on every keystroke
;; D	Change the search directory
;; ^	Re-run the search in the parent directory
;; g	Re-run the search
;; TAB	Expand/collapse results for a file
;; C-c C-k	Stop a running search
;; C-u	A prefix argument prevents search commands from starting automatically.
(use-package deadgrep
  :ensure t
  )

(use-package ellama
  :ensure t
  :init
  (setopt ellama-language "German")
  (require 'llm-ollama)
  (setopt ellama-provider
	  (make-llm-ollama
	   :chat-model "codellama:latest" :embedding-model "codellama:latest")))

(use-package nov
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
  (defun my-nov-font-setup ()
    (face-remap-add-relative 'variable-pitch :family "Comic Mono NF"
                             :height 1.0))
  (add-hook 'nov-mode-hook 'my-nov-font-setup)
  )




(use-package emms
  :ensure t
  :hook
  ('emms-playlist-mode . (lambda ()
			   (progn
			     (local-set-key (kbd "R") 'arz/reload-emms)
			     (local-set-key (kbd "L") 'emms-toggle-repeat-track)
			     (local-set-key (kbd "s") 'emms-shuffle)
			     (local-set-key (kbd "l") 'arz/emms-load-type)
			     (local-set-key (kbd "m") 'arz/emms-change-type)
			     (local-set-key (kbd "C-d") 'arz/emms-delete)
			     )))
  :config
  (require 'emms-setup)
  (require 'emms-player-mpv)
  (add-to-list 'emms-player-list 'emms-player-mpv)
  (setq emms-player-mpv-parameters 
	'("--quiet" "--really-quiet" "--volume=40" "-af" "aecho=1.0:0.7:20:0.5" "--no-terminal" "--force-window"))
  )


(defun arz/reload-emms()
  (interactive)
  (progn 
    (emms-playlist-clear)
    (emms-add-directory-tree "~/Music/Spotify")
    (setq emms-repeat-track nil)
    ))


(setq arz/music-root "~/Music/Spotify/")

(defun arz/do-emms-change-type (music-type)
  (let (
	(target-file (alist-get 'name (emms-playlist-current-selected-track) )
	;; (target-file "/home/arius/Music/Spotify/emo/AYER - My Hands (Truth x Lies Remix).webm")
	)    )
    
    (let ( (mv-command (format "mv %s %s%s" (shell-quote-argument target-file) arz/music-root music-type)))
      ;; (message "%s" mv-command)
      (shell-command mv-command) 
      ;; (emms-playlist-mode-kill-track)
      (emms-add-file (format "%s%s/%s"
			     arz/music-root music-type
			     (file-name-nondirectory target-file)))
      ;; (arz/reload-emms)
      )
  ) )

(defun arz/emms-change-type ()
  (interactive)
  (let (	
	(music-type 
	 (ivy-read
	  "Move to:"
	  (split-string
	   (s-trim
	    (shell-command-to-string (concat
				      "find "
				      arz/music-root
				      " -mindepth 1 -type d  -printf \"%f\n\""
				      ))) "\n")))
	)
    (arz/do-emms-change-type music-type)
    )
  )

(defun arz/emms-delete ()
  (interactive)
  (let (
	(target-file (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
	;; (target-file "/home/arius/Music/Spotify/emo/AYER - My Hands (Truth x Lies Remix).webm")
	)
    (if (y-or-n-p (format "Sure delete %s" target-file))
	(let ( (mv-command (format "rm %s" (shell-quote-argument target-file))))
	  ;; (message "%s" mv-command)
	  (shell-command mv-command)
	  (emms-playlist-mode-kill-track)
	  (arz/emms-delete)
	  ;; (arz/reload-emms)
	  )
      nil
      )))

(defun arz/do-emms-load-type (music-type)
  (interactive)
  (let ( (target-dir (format "%s%s" arz/music-root music-type)))
    (emms-playlist-clear)
    (emms-add-directory target-dir)
    (emms-playlist-mode-play-smart)
    (emms-shuffle) )
  )

(defun arz/emms-load-type ()
  (interactive)
  (let (	
	(music-type 
	 (ivy-read
	  (format "Load: ")
	  (split-string
	   (s-trim
	    (shell-command-to-string (concat
				      "find "
				      arz/music-root
				      " -mindepth 1 -type d  -printf \"%f\n\""
				      ))) "\n")))
	)
    (arz/do-emms-load-type music-type)
    ))


(defvar emms-player-mpv-volume 100)

(defun emms-player-mpv-get-volume ()
  "Sets `emms-player-mpv-volume' to the current volume value
and sends a message of the current volume status."
  (emms-player-mpv-cmd '(get_property volume)
                       #'(lambda (vol err)
                           (unless err
                             (let ((vol (truncate vol)))
                               (setq emms-player-mpv-volume vol)
                               (message "Music volume: %s%%"
                                        vol))))))

(defun emms-player-mpv-raise-volume (&optional amount)
  (interactive)
  (let* ((amount (or amount 10))
         (new-volume (+ emms-player-mpv-volume amount)))
    (if (> new-volume 100)
        (emms-player-mpv-cmd '(set_property volume 100))
      (emms-player-mpv-cmd `(add volume ,amount))))
  (emms-player-mpv-get-volume))

(defun emms-player-mpv-lower-volume (&optional amount)
  (interactive)
  (emms-player-mpv-cmd `(add volume ,(- (or amount '10))))
  (emms-player-mpv-get-volume))

(provide 'init-tool)
;;; init-tool.el ends here
