;;; Package --- init-latex :

;;; Commentary:

;;; Code:

(use-package cdlatex)

(setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin"))
(setq org-latex-create-formula-image-program 'dvipng)

(provide 'init-latex)
;;; init-latex.el ends here

