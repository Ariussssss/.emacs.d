;;; Package --- glance-gitstalk :

;;; Commentary:

;; An Emacs plugin to help you watch someone with gitslalk.

;;; Code:
(require 'request)
(require 'ivy)

(defcustom glance-git-user ""
  "Code base access-token for authorization.

Defaults to \"\""
  :group 'glance-gitstalk
  :type 'string)

(defvar glance-git-cache nil)

(defun glance-get-git-followers ()
  (request (format "https://api.github.com/users/%s/followers?per_page=1000" glance-git-user)
    :encoding 'utf-8
    :headers (and (elescope--authenticated-p)
                  (list (cons "Authorization"
                              (format "token %s" elescope-github-token))))
    :parser 'json-read
    :success
    (cl-function
     (lambda (&key data &allow-other-keys)
       (setq glance-git-cache (mapcar
			       (lambda (i)
				 (alist-get 'login i))
			       data))
       (glance-gitstalk-excute)
       ))
    :error
    (cl-function (lambda (&rest args &key error-thrown &allow-other-keys)
		   (message "Got error: %S %S" error-thrown args))))
  )


(defun glance-gitstalk-excute ()
  (interactive) 
  (ivy-read "Glance one guy: " glance-git-cache
	    :action (lambda (friend-name)
		      (shell-command (concat "open http://localhost:8081/" friend-name))
		      ;; (shell-command (concat "open https://gitstalk.netlify.app/" friend-name))
		      ))
  )

(defun glance-gitstalk ()
  (interactive)
  (if glance-git-cache
      (glance-gitstalk-excute)
    (glance-get-git-followers)
    )
  )


(provide 'glance-gitstalk)
;;; glance-gitstalk.el ends here
