;;; Package --- init-custom :

;;; Commentary:

;;; Code:
(defun close-all-buffers ()
  (interactive)
  (delete-other-windows)
  (mapc 'kill-buffer (buffer-list)))


(defvar arz-mark/list (list)
  "Total list of mark")

;; (defun with-face (str &rest face-plist)
;;   (propertize str 'face face-plist))

(defun mapcar-with-index (function list &rest more-lists)
  (let ((index -1))
    (apply #'mapcar (lambda (&rest args)
		      (cl-incf index)
		      (apply function (append args (list index))))
	   (append (list list) more-lists))))

;; ;; (common-header-line-mode nil)
;; (defun arz-mark/show-mark-line ()
;;   "Display arz-mark"
;;   (interactive)
;;   (setq-default header-line-format (list (with-face "    ฅ•ω•ฅ  "
;;  						    :foreground "hot pink"
;; 						    ) (mapcar-with-index #'arz-mark/format-label (reverse arz-mark/list))))
;;   )

;; (defun arz-mark/format-label (mark &rest xs)
;;   "Customize mark label"
;;   (message "%s" xs)
;;   (let* ((is-active-mark (eq (buffer-file-name) (alist-get 'full-path mark)))
;; 	 (foreground "plum3")
;;          (background (face-background 'default))
;;          )
;;     (concat
;;      (with-face (format " %s %s [%s] " (alist-get 'title mark) (alist-get 'line mark) (+ (car xs) 1))
;; 		:height 100
;; 		:distant-foreground foreground
;; 		:background background
;;                 :weight 'bold)
     
;;      (with-face " "
;; 		:background background)
;;      )))

(defun my-remove (element list)
  (if (endp list)
      list
    (if (equal element (first list))
        (my-remove element (rest list))
      (list* (first list)
             (my-remove element (rest list))))))

(defun arz-mark/set-mark (&optional pos)
  "Set jump point at POS.
POS defaults to point."
  (interactive)
  (let* (
	 (new-item (list
		    (cons 'title (buffer-name))
		    (cons 'line 
			  (line-number-at-pos))
		    (cons 'full-path (buffer-file-name)))))
    (if (member new-item arz-mark/list)
	(setq arz-mark/list (my-remove new-item arz-mark/list))
      (add-to-list 'arz-mark/list new-item)
      ))
  (if (> (length arz-mark/list) 8)
      (setq arz-mark/list (reverse (cdr (reverse arz-mark/list))))
    ()
    )
  (message "%s" arz-mark/list)
  ;; (arz-mark/show-mark-line)
  )


(defun arz-mark/jump-mark (idx)
  "Jump to pos."
  (let ((mark (nth (- idx 1) (reverse arz-mark/list))))
    (if mark
	(progn
  	  (find-file (alist-get 'full-path mark))
	  (goto-line (alist-get 'line mark)))
      (message "%s" mark)
      ))
  (message "%s" arz-mark/list)
  )

(defun arz-mark/last-mark ()
  "Jump to last mark"
  (interactive)
  (arz-mark/jump-mark (length arz-mark/list)))


(defun arz-mark/pop-mark ()
  "Pop last mark."
  (interactive)
  (arz-mark/last-mark)
  (setq arz-mark/list (cdr arz-mark/list))
  ;; (arz-mark/show-mark-line)
  )

(defun arz/async-shell-command-no-window
    (command)
  (interactive)
  (let
      ((display-buffer-alist
        (list
         (cons
          "\\*Async Shell Command\\*.*"
          (cons #'display-buffer-no-window nil)))))
    (async-shell-command
     command)))


(defun arz/prev-theme ()
  "Load the last theme next to current in theme list"
  (interactive)
  (let* (
	 (all-themes (mapcar 'symbol-name (custom-available-themes)))
	 (len (length (mapcar 'symbol-name (custom-available-themes))))
	 (next-idx (- (cl-position (format "%s" (nth 0 custom-enabled-themes)) all-themes :test 'equal) 1))
	 (local-theme "")
	 )
    (if (> next-idx 0)
	(setq local-theme (nth next-idx all-themes))
      (setq local-theme (nth (- len 1) all-themes)))
    (while custom-enabled-themes
      (disable-theme (car custom-enabled-themes)))
    (load-theme (intern local-theme) t)
    (arz/custom-ui)
    (message "%s Loaded" local-theme)
    ))

(defun arz/next-theme ()
  "Load the next theme next to current in theme list"
  (interactive)
  (let* (
	 (all-themes (mapcar 'symbol-name (custom-available-themes)))
	 (len (length (mapcar 'symbol-name (custom-available-themes))))
	 (next-idx (+ (cl-position (format "%s" (nth 0 custom-enabled-themes)) all-themes :test 'equal) 1))
	 (local-theme "")
	 )
    (if (< next-idx len)
	(setq local-theme (nth next-idx all-themes))
      (setq local-theme (nth 0 all-themes)))
    (while custom-enabled-themes
      (disable-theme (car custom-enabled-themes)))
    (load-theme (intern local-theme) t)
    (arz/custom-ui)
    (message "%s Loaded" local-theme)
    ))

(setq arz/callback nil)
(defun arz/async-shell-callback (shell-string callback)
  "Run callback after async shell"
  (let* ((output-buffer (generate-new-buffer "*Async shell command*"))
	 (proc (progn
		 (async-shell-command shell-string output-buffer)
		 (get-buffer-process output-buffer)))
	 )
    (setq arz/callback callback)
    (if (process-live-p proc)
	(set-process-sentinel proc (lambda (process signal)
				     (when (memq (process-status process) '(exit signal))
				       (funcall arz/callback)
				       (shell-command-sentinel process signal))))
      (message "No process running.")))
  )

;; (arz/async-shell-callback "sleep 2; echo Finished " (lambda () (message "done111")))

(defun color-mode ()
  "Syntax color text of the form 「#ff1100」 and 「#abc」 in current buffer.
URL `http://xahlee.info/emacs/emacs/emacs_CSS_colors.html'
Version 2017-03-12"
  (interactive)
  (font-lock-add-keywords
   nil
   '(("#[[:xdigit:]]\\{3\\}"
      (0 (put-text-property
          (match-beginning 0)
          (match-end 0)
          'face (list :background
                      (let* (
                             (ms (match-string-no-properties 0))
                             (r (substring ms 1 2))
                             (g (substring ms 2 3))
                             (b (substring ms 3 4)))
                        (concat "#" r r g g b b))))))
     ("#[[:xdigit:]]\\{6\\}"
      (0 (put-text-property
          (match-beginning 0)
          (match-end 0)
          'face (list :background (match-string-no-properties 0)))))))
  (font-lock-flush))

(quickrun-add-command "python/module"
  '((:command . "python")
    (:exec    . ("%c ~/lib/python-test/excute-python-module.py -- %n"))
    (:tempfile nil))
  :default "python")

(provide 'init-custom)
;;; init-custom.el ends here

