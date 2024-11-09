;;; Package ---  init-shortcut:

;;; Commentary:
;;; 

;;; Code:
(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key [(meta shift up)]  'move-line-up)
(global-set-key [(meta shift down)]  'move-line-down)

(defun auto-cut () 
  "Cut whole line or cut selection while mark is active." 
  (interactive) 
  (if mark-active (kill-region (point)  
			       (progn (exchange-point-and-mark nil) 
				      (point))) 
    (kill-region (progn (move-beginning-of-line nil)
			
			(point))  
		 (progn (move-end-of-line nil) 
			(right-char) 
			(point)))))

(global-set-key (kbd "C-k") 'auto-cut)

(defun auto-copy () 
  "Copy whole line or copy selection while mark is active." 
  (interactive) 
  (if mark-active (kill-ring-save (point)  
				  (progn (exchange-point-and-mark nil) 
					 (point))) 
    (kill-ring-save (progn (move-beginning-of-line nil) 
			   (point))  
		    (progn (move-end-of-line nil) 
			   (right-char) 
			   (point)))))

(defun nuke-all-buffers ()
  (interactive)
  (mapcar 'kill-buffer (buffer-list))
  (delete-other-windows))

(global-set-key (kbd "C-x K") 'nuke-all-buffers)

(defun open-init-file() 
  "Navigate to init.el file." 
  (interactive) 
  (find-file "~/.emacs.d/init.el")
  (find-file-in-project))

(defun delete-window-or-frame (&optional window frame force)
  (interactive)
  (if (= 1 (length (window-list frame)))
      (delete-frame frame force)
    (delete-window window)))

(defun open-tmux ()
  "Pass current path to tmux."
  (interactive)
  (let ((tmux-key 
	 (ivy-read "To Tmux:"
		   (split-string
		    (s-trim
		     (shell-command-to-string "tmux ls | grep : | cut -d. -f1 | awk '{print substr($1, 0, length($1)-1)}'"
					      )
		     ) "\n"))))
    
    (shell-command
     (concat "tmux new-window -c "
	     (s-trim (shell-command-to-string "pwd"))
	     " -t "
	     tmux-key
	     " -n "
	     (car (last
		   (split-string (s-trim (shell-command-to-string "pwd"))
				 "/")
		   ))
	     " -a "
	     ))
    (message (concat "Check in " tmux-key " 🦋"))
    ;; (shell-command "open -a Alacritty")
    )
  )

;; Arius tmux
(defalias 'Art 'open-tmux)

(defun new-tmux (tmux-key)
  "Pass current path to tmux to create a new session."
  (interactive "sNew Session: ")
  (shell-command
   (concat "tmux new -s "
	   tmux-key
	   " -c "
	   (s-trim (shell-command-to-string "pwd"))
	   " -d "
	   " -n "
	   (shell-command-to-string "basename $(pwd)")
	   ))
  (message (concat "Check in " tmux-key " 🦋"))
  ;; (shell-command "open -a Alacritty")
  )

;; Arius new tmux session
(defalias 'Arnt 'new-tmux)

(defun open-file ()
  "Naviagateto file."
  (interactive)
  (shell-command "open .")
  (shell-command "open -a finder")
  )

;; Arius open file
(defalias 'Aof 'open-file)

;; (global-set-key (kbd "<s-up>") 'beginning-of-buffer)
;; (global-set-key (kbd "<s-down>") 'end-of-buffer)


(defun comment-or-uncomment-line-or-region () 
  "Comments or uncomments the current line or region." 
  (interactive) 
  (if (region-active-p) 
      (comment-or-uncomment-region (region-beginning) 
				   (region-end)) 
    (comment-or-uncomment-region (line-beginning-position) 
				 (line-end-position))))

(global-set-key (kbd "C-x C-/") 'comment-or-uncomment-line-or-region)
(global-set-key (kbd "C-x w") 'kill-current-buffer)

;; 切换透明
;;;
(setq arz-transparency-rate 70)
(defun toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha-background)))
    (set-frame-parameter
     nil 'alpha-background
     (if (eql (cond ((numberp alpha) alpha)
		    ((numberp (cdr alpha)) (cdr alpha))
		    ;; Also handle undocumented (<active> <inactive>) form.
		    ((numberp (cadr alpha)) (cadr alpha)))
	      100)
	 arz-transparency-rate 100))
    ))

;; (set-frame-parameter nil 'alpha arz-transparency-rate)
(set-frame-parameter nil 'alpha-background arz-transparency-rate)

(defalias 'Aro 'toggle-transparency)

(defun open-text-buffer ()
  (interactive)
  (find-file "~/org/text.org")
  ;; (switch-to-buffer "*scratch*")
  )

(defalias 'Atx 'open-text-buffer)

(defun open-todo-buffer ()
  (interactive)
  (find-file "~/org/todo.org")
  ;; (switch-to-buffer "*scratch*")
  )

(defalias 'Ato 'open-todo-buffer)

(defalias 'Abm 'buffer-menu)

;; Arius prettier
(defalias 'Apt 'prettier-js-mode)
;; prettier-js-mode
(add-hook 'js-mode-hook
	  (lambda ()
	    (progn
	      (defalias 'Apt 'prettier-js))))
(add-hook 'web-mode-hook
	  (lambda ()
	    (progn
	      (defalias 'Apt 'prettier-js))))

(add-hook 'prettier-js-mode-hook
	  (lambda ()
	    (progn
	      (defalias 'Apt 'prettier-js))))

;; 减少误关
(defun ask-before-closing ()
  "Close only if y was pressed."
  (interactive)
  (if (y-or-n-p (format "Are you sure you want to close this frame? "))
      (save-buffers-kill-emacs)
    (message "Canceled frame close")))

(global-set-key (kbd "C-x C-c") 'ask-before-closing)

(defun open-work-space ()
  (interactive)
  (let ((path (ivy-read "Choose work type:" '("Packages" "Music" "Spells"))))
    (if (string= path "Spells")
	(find-file "~/lib/spells")
      (find-file
       (concat "~/" path "/"
	       (ivy-read "Choose work space:"
			 (split-string
			  (shell-command-to-string
			   (concat "cd ~/" path " && ls -d1 -- */*/"))
			  "\n")
		       ))))
    ))

(defun narrow-or-widen-dwim (p)
  "Widen if buffer is narrowed, narrow-dwim otherwise.
Dwim means: region, org-src-block, org-subtree, or
defun, whichever applies first. Narrowing to
org-src-block actually calls `org-edit-src-code'.

With prefix P, don't widen, just narrow even if buffer
is already narrowed."
  (interactive "P")
  (declare (interactive-only))
  (cond ((and (buffer-narrowed-p) (not p)) (widen))
        ((region-active-p)
         (narrow-to-region (region-beginning)
                           (region-end)))
        ((derived-mode-p 'org-mode)
         ;; `org-edit-src-code' is not a real narrowing
         ;; command. Remove this first conditional if
         ;; you don't want it.
         (cond ((ignore-errors (org-edit-src-code) t)
                (delete-other-windows))
               ((ignore-errors (org-narrow-to-block) t))
               (t (org-narrow-to-subtree))))
        ((derived-mode-p 'latex-mode)
         (LaTeX-narrow-to-environment))
        (t (narrow-to-defun))))

(global-set-key (kbd "M-z") 'undo-tree-undo)
(global-set-key (kbd "M-Z") 'undo-tree-redo) 

(define-prefix-command 'leader-key)
(global-set-key (kbd "C-x a") 'leader-key)
(global-set-key (kbd "C-(") 'backward-sexp) 
(global-set-key (kbd "C-)") 'forward-sexp)
(global-set-key (kbd "M-s-,") 'beginning-of-buffer)
(global-set-key (kbd "M-s-.") 'end-of-buffer)
(global-set-key (kbd "M-≤") 'beginning-of-buffer)
(global-set-key (kbd "M-≥") 'end-of-buffer)

(defun set-selective-display-dlw (&optional level)
  "Fold text indented same of more than the cursor.
If level is set, set the indent level to LEVEL.
If 'selective-display' is already set to LEVEL, clicking
F5 again will unset 'selective-display' by setting it to 0."
  (interactive "P")
  (if (eq selective-display (1+ (current-column)))
      (set-selective-display 0)
    (set-selective-display (or level (1+ (current-column))))))


(use-package
  hydra
  :ensure t)

(push '(progn
	 (use-package
	   hydra-posframe
	   :load-path "~/.emacs.d/etc/site-vendor/hydra-posframe"
	   :hook (after-init . hydra-posframe-mode))
	 ) graphic-only-plugins-setting)

(use-package
  major-mode-hydra
  :ensure t
  :after hydra)

;; winum users can use `winum-select-window-by-number' directly.
(defun my-select-window-by-number (win-id)
  "Use `ace-window' to select the window by using window index.
WIN-ID : Window index."
  (let ((wnd (nth (- win-id 1) (aw-window-list))))
    (if wnd
        (aw-switch-to-window wnd)
      (message "No such window."))))

(defun my-select-window ()
  (interactive)
  (let* ((event last-input-event)
         (key (make-vector 1 event))
         (key-desc (key-description key)))
    (my-select-window-by-number
     (string-to-number (car (nreverse (split-string key-desc "-")))))))

(global-set-key (kbd "C-x 2")
		(lambda ()
		  (interactive)
		  (split-window-below)
		  (balance-windows)))

(global-set-key (kbd "C-x 3")
		(lambda ()
		  (interactive)
		  (split-window-right)
		  (balance-windows)))

(global-set-key (kbd "C-x 0")
		(lambda ()
		  (interactive)
		  (delete-window)
		  (balance-windows)))

(global-set-key (kbd "C-x 4") 
		(lambda ()
		  (interactive)
		  (delete-window)
		  (balance-windows)))

;; 窗格
(defhydra arz/hydra-window-menu (:color "magenta")
  "
					    ^窗口管理器^
[_w_] ^关闭窗格^			[_F_] ^全屏模式^		[_K_] ^↑+^		[_k_] ^go ↑^    
[_1_] ^关闭其他窗格^		[_r_] ^旋转交换^		[_J_] ^↓+^		[_j_] ^go ↓^ 
[_D_] ^新建窗格(垂直)^		[_s_] ^选择交换^		[_H_] ^←+^		[_h_] ^go ←^
[_d_] ^新建窗格(水平)^		[_b_] ^平均铺开^		[_L_] ^→+^		[_l_] ^go →^
^^0 ~ 9^^ ^select window^
"
  ("w" delete-window nil
   :post zoom
   :exit t)
  ("1" delete-other-windows nil
   :post zoom
   :exit t)
  ("D" split-window-vertically nil
   :post zoom
   :exit t)
  ("d" split-window-horizontally nil
   :post zoom
   :exit t)
  ("F" toggle-frame-fullscreen nil
   :post zoom
   :exit t)
  ("r" rotate-window nil
   :post zoom
   )
  ("s" ace-swap-window nil
   :post zoom
   )
  ("b" balance-windows nil)
  ("H" shrink-window-horizontally nil)
  ("J" enlarge-window nil)
  ("K" shrink-window nil)
  ("L" enlarge-window-horizontally nil)
  ("h" windmove-left nil)
  ("j" windmove-down nil)
  ("k" windmove-up nil)
  ("l" windmove-right nil)
  ("0" my-select-window nil)
  ("1" my-select-window nil)
  ("2" my-select-window nil)
  ("3" my-select-window nil)
  ("4" my-select-window nil)
  ("5" my-select-window nil)
  ("6" my-select-window nil)
  ("7" my-select-window nil)
  ("8" my-select-window nil)
  ("9" my-select-window nil)
  ("q" nil "QUIT"))

;; (add-hook 'window-setup-hook 'toggle-frame-fullscreen t)
;; (toggle-frame-fullscreen)
(defun open-grimoire ()
  (interactive)
  (find-file "~/org/grimoire")
  (find-file-in-project))

(defun open-lang-store ()
  (interactive)
  (find-file "~/org/lang")
  (find-file-in-project))

(defun open-longman (start end)
  (interactive "r")
  (shell-command (format "xdg-open https://www.ldoceonline.com/dictionary/%s" (buffer-substring start end))))

(defun open-github-repo ()
  (interactive)
  (shell-command "git-open"))

(use-package
  glance-gitstalk
  :load-path "../site-vendor/glance-gitstalk/glance-gitstalk.el"
  :custom
  (glance-git-user "Ariussssss")
  )

;; github source
(defhydra arz/hydra-source-menu (:color magenta
					  :exit t)
  "
					^Menu^
[_c_] ^clone-repo^                       [_o_] ^open-github-repo^                       [_p_] ^open-personal-page^
[_a_] ^byte-cloneg^                       
"
  ("c" elescope-checkout nil)
  ("p" glance-gitstalk nil)
  ("o" open-github-repo nil)
  ("a" byte-elescope-checkout nil)
  ("q" nil "QUIT"))

(setq bookmark-alist nil)
(defun arz/bookmark-jump-to-idx (idx)
  "Jump to pos."
  (let ((mark (nth (- idx 1) (reverse bookmark-alist))))
    (if mark
	(progn (bookmark-jump mark))
      (message "%s" mark)
      ))
  )

(defun arz/jump-bookmark ()
  (interactive)
  (let* ((event last-input-event)
	 (key (make-vector 1 event))
	 (key-desc (key-description key)))
    (arz/bookmark-jump-to-idx
     (string-to-number (car (nreverse (split-string key-desc "-")))))))

(defun arz/jump-last-bookmark ()
  (interactive)
  (arz/bookmark-jump-to-idx (- (length bookmark-alist) 1))
  )


(defun arz/bookmark-delete-by-idx (idx)
  (let ((mark (nth (- idx 1) (reverse bookmark-alist))))
    (if mark
	(progn (bookmark-delete mark))
      (message "%s" mark)
      ))
  )

(defun arz/delete-bookmark ()
  (interactive)
  (let* ((event last-input-event)
	 (key (make-vector 1 event))
	 (key-desc (key-description key)))
    (arz/bookmark-delete-by-idx
     (string-to-number (car (nreverse (split-string key-desc "-")))))))

;; theme
(defhydra arz/hydra-theme-menu (:color "magenta")
  "
					    ^Theme^
[_n_] ^next^			[_p_] ^previous^		[_r_] ^reset^
"
  ("n" arz/next-theme nil)
  ("p" arz/prev-theme nil)
  ("r" arz/reset-theme nil
   :exit t)
  ("q" nil "QUIT"))

(defhydra arz/hydra-language-menu (:color "magenta")
  "
					    ^Language^
[_l_] ^toggle spellcheck^			[_s_] ^search^		[_n_] ^next^
[_p_] ^prev^			                [_a_] ^auto correct^	[_i_] ^ispell^
[_c_] ^code lsp^                            [_m_] ^store^
"
  ("l" arz/flyspell-toggle-english nil)
  ("s" ispell-word nil
   :exit t)
  ("c" lsp nil :exit t)
  ("m" open-lang-store nil :exit t)
  ("a" flyspell-auto-correct-word nil)
  ("p" flyspell-check-previous-highlighted-word nil)
  ("n" flyspell-goto-next-error nil)
  ("i" ispell nil
   :exit t)
  ("q" nil "QUIT"))

(defun arz/delete-workspace ()
  "Remove workspaces."
  (interactive)
  (let ((ws 
	 (ivy-read "Remove workspace:"
		   (append (lsp-session-folders (lsp-session)) (list ":Exit")))))
    
    (if (string-equal ws ":Exit")
	nil
	(progn
	  (lsp-workspace-folders-remove ws)
	  (arz/delete-workspace)
	  )
      )))

(defun arz/open-workspace ()
  "Open workspaces."
  (interactive)
  (let ((ws 
	 (ivy-read "Open workspace:"
		   (append (lsp-session-folders (lsp-session)) (list ":Exit")))))
    
    (if (string-equal ws ":Exit")
	nil
	(progn
	  (lsp-workspace-folders-open ws)
	  (arz/open-workspace)
	  )
      )))

(defhydra arz/hydra-lsp-menu (:color "magenta"
				     :exit t)
  "
%s(let ((my-counter  0))
  (string-join (mapcar (lambda (x) (format \"%s. %s\" (cl-incf my-counter) x)) (reverse (lsp-session-folders (lsp-session))) )  \"\n\"))
					    ^LSP^
[_o_] ^open^                         [_d_] ^delete^
"
  ("o" arz/open-workspace nil)
  ("d" arz/delete-workspace nil)
  ("q" nil "QUIT"))

(defun arz/bookmark-set ()
  (interactive)
  (bookmark-set (format "%s:%s" (buffer-file-name) (line-number-at-pos))))

(defhydra arz/hydra-delete-bookmark-menu (
					  :color magenta
					  :exit t)
  "
%s(let ((my-counter  0))
  (string-join (mapcar (lambda (x) (format \"%s. %s\" (cl-incf my-counter) (nth 0 x))) (reverse bookmark-alist) )  \"\n\"))
					^delete^
^^1 ~ 8^^ delete mark
"
  ("1" arz/delete-bookmark nil
   :exit nil)
  ("2" arz/delete-bookmark nil
   :exit nil)
  ("3" arz/delete-bookmark nil
   :exit nil)
  ("4" arz/delete-bookmark nil
   :exit nil)
  ("5" arz/delete-bookmark nil
   :exit nil)
  ("6" arz/delete-bookmark nil
   :exit nil)
  ("7" arz/delete-bookmark nil
   :exit nil)
  ("8" arz/delete-bookmark nil
   :exit nil)
  ("q" arz/hydra-main-menu/body nil))

(defun arz/girl-say ()
  (interactive)
  (unless (executable-find "mpg123")
    (message "缺少mplayer依赖!"))
  (let ((girl-say-lst (list)))
    (mapcar (lambda (mp3)
              (push mp3 girl-say-lst))
            (split-string (shell-command-to-string "ls ~/.emacs.d/var/girl-say")))
    
    (setq girl-say-process
          (start-process-shell-command "girl-say" "girl-say"
                                       (concat "mpg123" " ~/.emacs.d/var/girl-say/" (nth
                                                                                      (random (length girl-say-lst))
                                                                                      girl-say-lst))))))


;; Main menu
(defhydra arz/hydra-main-menu (
			       :color magenta
			       :exit t)
  "
					^Bookmark^
%s(let ((my-counter  0))
  (string-join (mapcar (lambda (x) (format \"%s. %s\" (cl-incf my-counter) (nth 0 x))) (reverse bookmark-alist) )  \"\n\"))

                                    	^Menu^
[_w_] ^window-control^                   [_o_] ^open-work-space^           [_s_] ^open-init-file^
[_g_] ^open-grimoire^                    [_p_] ^find-file-in-project^      [_f_] ^counsel-rg^
[_c_] ^set-selective-display-dlw^        [_m_] ^mark^                      [_z_] ^zoom^
[_S_] ^source-control^                   [_d_] ^pop mark^                  [_x_] ^last mark^
[_l_] ^open-language-menu^               [_`_] ^jump to last mark^         [_n_] ^narrow-or-widen-dwim^
^^1 ~ 8^^ jump mark                      [_t_] ^open-theme-menu^           [_e_] ^excute quickrun^
[_P_] ^arz/bing-translate^               [_L_] ^lsp-workspace-manager^     [_E_] ^emms^
[_SPC_] ^girl^
"
  ("`" arz/jump-last-bookmark nil
   :exit t)
  ("1" arz/jump-bookmark nil
   :exit t)
  ("2" arz/jump-bookmark nil
   :exit t)
  ("3" arz/jump-bookmark nil
   :exit t)
  ("4" arz/jump-bookmark nil
   :exit t)
  ("5" arz/jump-bookmark nil
   :exit t)
  ("6" arz/jump-bookmark nil
   :exit t)
  ("7" arz/jump-bookmark nil
   :exit t)
  ("8" arz/jump-bookmark nil
   :exit t)
  ("l" arz/hydra-language-menu/body nil)
  ("L" arz/hydra-lsp-menu/body nil)
  ("t" arz/hydra-theme-menu/body nil)
  ("W" arz/hydra-window-menu/body nil)
  ("e" quickrun nil) 
  ("E" emms nil) 
  ("o" open-work-space nil) 
  ("s" open-init-file nil)
  ;; ("r" ranger nil)
  ("S" arz/hydra-source-menu/body nil)
  ("g" open-grimoire nil)
  ("p" counsel-projectile-find-file nil)
  ("w" arz/youdao :exit t)
  ("P" arz/bing-translate nil)
  ;; ("f" counsel-ag nil)
  ("f" deadgrep nil)
  ("m" arz/bookmark-set nil
   :exit t)
  ("n" narrow-or-widen-dwim nil
   :exit t)
  ("x" bookmark-jump-other-window nil
   :exit t)
  ("d" arz/hydra-delete-bookmark-menu/body nil)
  ("z" zoom-window-zoom nil)
  ("c" (lambda (arg)
	 (interactive "p")
	 (progn
	   (hs-minor-mode)
	   (if
	       (hs-already-hidden-p)
	       (hs-show-block)
	     (hs-hide-level arg)))) nil)
  ("b" hs-toggle-hi)
  ("SPC" arz/girl-say nil
   :exit nil)
  ("q" nil "QUIT"))

(global-set-key (kbd "C-x a") #'arz/hydra-main-menu/body)

(provide 'init-shortcut)
;;; init-shortcut.el ends here

