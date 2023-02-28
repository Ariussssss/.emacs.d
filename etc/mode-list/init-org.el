;;; Package --- init-org :

;;; Commentary:
;;; 
;;; Code:

;; 美化 org
(require 'org-capture)

(use-package 
  org-bullets
  :ensure t
  :hook ('org-mode . 'org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("☰" "☷" "♔" "☥")))

(use-package 
  org
  :ensure t
  :hook
  ('org-mode . 'org-indent-mode)
  ('org-mode . (lambda ()
		 (progn
		   (mapcar (lambda (x)
			     (let ((eng (car x)) (cn (car (cdr x))))
			       (local-set-key (kbd cn) eng)
			       ))
			   '(
			     (". " "。")
			     ("~" "～")
			     ("|" "｜")
			     (", " "，")
			     (":" "：")
			     (";" "；")
			     ("?" "？")
			     ("!" "！")
			     ("[" "【")
			     ("]" "】" )
			     ("{" "「")
			     ("}" "」")
			     ("(" "（")
			     (")" "）")
			     ("$" "¥")
			     ("-" "——")
			     ("^" "……")
			     ("`" "·") 
			     ("<" "《")  
			     (">" "》")
			     ("<" "〈")  
			     (">" "〉")
			     ("\\" "、")
			     ("\"" "“")
			     ("\"" "”")
			     ("'" "‘")
			     ("'" "’")
			     ))
		   (local-set-key (kbd "RET")
				  (lambda ()
				    (interactive)
				    (progn 
				      (org-return-indent)
				      )
				    ))
		   )
		 )
	     )
  
  :bind
  ("C-c c" . 'org-capture)
  ("M-H" . 'org-shiftmetaleft)
  ("M-L" . 'org-shiftmetaright)
  ("s-<left>" . 'org-property-previous-allowed-value)
  ("s-<right>" . 'org-property-next-allowed-value)
  :custom

  (org-todo-keywords '((sequence "TODO(s)" "WORKING(w!/@)" "|" "DONE(d!/@)" "CANCEL(c!@)")
                       (sequence "TOLEARN(t)" "LEARNING(i@)" "|" "DONE(d!/@)")
                       (sequence "BUG(b)" "|" "DONE(d!/@)")
                       (sequence "CHECK(p)")
		       ))
  :config
  (setq org-todo-keyword-faces '(("TODO" . (:foreground "white" :background "#551a8b" :weight bold))
				 ("WORKING" . (:foreground "white" :background "#ff00ff" :weight bold))
				 ("DONE" . (:foreground "SpringGreen1" :weight bold))
				 ("BUG" . (:foreground "white" :background "VioletRed1" :weight bold))
				 ("CHECK" . (:foreground "white" :background "VioletRed1" :weight bold))
				 ("CANCEL" . (:foreground "black" :weight bold))
				 ("TOLEARN" . (:foreground "white" :background "dark slate blue" :weight bold))
				 ("LEARNING" . (:foreground "white" :background "BlueViolet" :weight bold))))

  (defun arius/capture-word ()
    (interactive)
    (setq-local capture-word-item nil)
    (setq arius/capture-word-data nil)
    (let* ((word (youdao-dictionary--request (if (not (thing-at-point 'word))
						 nil
					       (thing-at-point 'word))))
	   (basic (youdao-dictionary--explains word))
	   (eng (assoc-default 'query word)))
      (dotimes (i (map-length basic))
	(let* ((explain (map-elt basic i)) ;; 所有说明
	       ;; 词性
	       (type (progn (string-match "[a-zA-Z]+" explain)
			    (concat (match-string 0 explain) ".")))
	       ;; 中文翻译
	       (chinese (progn (string-match "[\u4e00-\u9fa5；，]+" explain)
			       (match-string 0 explain))))
	  (push (concat "|" eng "|" type "|" chinese "|") capture-word-item))))
    (setq arius/capture-word-data (ivy-read "请选择要插入的词性: " capture-word-item))
    (setq arius/capture-word-data (remove "" (split-string arius/capture-word-data "|")))
    (if (null arius/capture-word-data)
	(message "光标下的单词无法捕获!")
      (org-capture 1 "aw")))

  (defun arius/capture-get-word (number)
    (cond ((eq number 1) (nth 0 arius/capture-word-data))
	  ((eq number 2) (nth 1 arius/capture-word-data))
	  ((eq number 3) (nth 2 arius/capture-word-data))))
  
  
  (setq org-capture-templates nil)
  (setq org-log-done t)
  (setq org-image-actual-width 300)
  ;; (setq-default org-display-custom-times nil)
  (setq org-time-stamp-custom-formats '("<%Y-%m-%d>" . "<%Y-%m-%d %a %H:%M>"))
  ;; (setq org-time-stamp-formats '("<%Y-%m-%d %a %H:%M>" . "<%Y-%m-%d>"))
  (add-to-list 'org-capture-templates
               '("t" "Task"))
  (add-to-list 'org-capture-templates '("tw" "Working" entry (file+olp "~/org/capture/task.org" "Work" "Future")
                                        "** TODO %^{Task Name} [%] %^G\n %a\n  %?"))
  (add-to-list 'org-capture-templates '("ts" "Learning" entry (file+headline "~/org/capture/task.org" "Study")
                                        "* TOLEARN %^{Skills} [%] %^G\n %?"))
  (add-to-list 'org-capture-templates '("f" "My Flash" entry (file+headline "~/org/capture/idea.org" "Flash")
                                        "* %U - %^{Title} %^g\n %?\n"))
  (add-to-list 'org-capture-templates '("l" "My Links" entry (file+headline "~/org/capture/link.org" "Links")
                                        "* %^{intro} %t %^g\n  %^{link}\n  %?\n"))
  
  (add-to-list 'org-capture-templates '("w" "Words" table-line (file+headline "~/org/capture/word.org" "Words")
                                        " | %U | %^{English} | %^{type} | %^{expression} |"))
  (add-to-list 'org-capture-templates '("aw" "Add words" table-line (file+headline "~/org/capture/word.org" "Words")
                                        "| %U | %(arius/capture-get-word 1) | %(arius/capture-get-word 2) | %(arius/capture-get-word 3) |"))
  (setq org-babel-python-command "python3")
  (defalias 'AddWord 'arius/capture-word)
  
  (defun quick-open-capture ()
    (interactive)
    (find-file
     (concat "~/org/capture/"
	     (ivy-read "Open capture:" '("task" "learning" "idea" "word" "daily" "link"))
	     ".org"))
    )
  (defalias 'Aoc 'quick-open-capture))

(use-package
  org-agenda
  :bind
  ("C-c a" . 'org-agenda)
  :config
  (setq org-agenda-include-diary t)
  (setq org-agenda-diary-file "~/org/diary/standard-diary") 
  (setq diary-file "~/org/diary/standard-diary")
  (setq org-agenda-window-setup 'current-window)
  (setq org-agenda-files '("~/org/capture/task.org"
			   "~/org/capture/daily.org"))
  )


(use-package org-download
  :ensure t
  :after org
  :defer nil
  :custom
  (org-download-method 'directory)
  (org-download-image-dir "images")
  (org-download-heading-lvl nil)
  (org-download-timestamp "%Y%m%d-%H%M%S_")
  (org-image-actual-width 300)
  (org-download-screenshot-method "/usr/local/bin/pngpaste %s")
  :bind
  ("C-M-y" . org-download-screenshot))

;; 自动空格
(use-package
  pangu-spacing
  :ensure t
  :hook
  ('org-mode . 'pangu-spacing-mode)
  :custom
  (pangu-spacing-real-insert-separtor t)
  )

;; 绘图
(use-package
  ox-gfm
  :ensure t)

(use-package
  gnuplot
  :ensure t)

;; emoji
(use-package emojify
  :ensure t
  :hook
  (org-mode . emojify-mode)
  )

(provide 'init-org)
;;; init-org.el ends here

