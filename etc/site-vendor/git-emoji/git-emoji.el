;;; Package --- git-emoji :

;;; Commentary:

;;; Code:


(defvar git-emoji-map
      (cons '((name . "init") (value . ":tada: "))
	    '(
	      ((name . "feat") (value . ":new: "))
	      ((name . "fix") (value . ":bug: "))
	      ((name . "pref") (value . ":art: "))
	      ((name . "docs") (value . ":pencil: "))
	      ((name . "star") (value . ":sparkles: "))
	      ((name . "refactor") (value . ":recycle: "))
	      ((name . "refresh") (value . ":dizzy: "))
	      ((name . "deps") (value . ":package: "))
	      )))

(defvar git-emoji-result-map
  (mapcar (lambda (i)
	    (cons (alist-get 'name i) (alist-get 'value i)))
	  git-emoji-map)
  "Cache for map")

(defun git-emoji-insert ()
  (interactive)
  (ivy-read "Choose commit type:"
	    (mapcar (lambda (i)
		      (alist-get 'name i)) git-emoji-map)
	    :action (lambda (x)
		      (kill-new (cdr (assoc x git-emoji-result-map)))
		      (if (equal 'vterm-mode major-mode)
			  (vterm-yank)
			(yank)))))

(provide 'git-emoji)
;;; git-emoji.el ends here

