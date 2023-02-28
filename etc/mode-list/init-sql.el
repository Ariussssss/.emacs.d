;;; Package --- init-sql :

;;; Commentary:

;;; Code:

(defun sqlparse-region (beg end)
  (interactive "r")
  (shell-command-on-region
   beg end
   "/Users/arius/.pyenv/shims/python -c 'import sys, sqlparse; print(sqlparse.format(sys.stdin.read(), reindent=True))'"
   t t))

(provide 'init-sql)
;;; init-sql.el ends here

