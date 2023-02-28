;;; Package --- init-dot :

;;; Commentary:

;;; Code:
;; 编辑 graph dot 文件
(use-package graphviz-dot-mode
  :ensure t
  :config
  (setq graphviz-dot-indent-width 4))

(use-package company-graphviz-dot
  :ensure t)

(use-package plantuml-mode
  :ensure t
  :config
  (setq org-plantuml-jar-path (expand-file-name "~/.emacs.d/etc/site-vendor/plantuml.1.2021.9.jar"))
  (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
  (org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))
  )

(provide 'init-dot)
;;; init-dot.el ends here

