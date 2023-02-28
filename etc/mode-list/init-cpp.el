;;; Package --- init-cpp :

;;; Commentary:

;;; Code:
(use-package
  ccls
  :ensure t
  :custom
  (ccls-executable "/usr/local/bin/ccls")
  )

(use-package
  bazel
  :ensure t)

(provide 'init-cpp)
;;; init-cpp.el ends here

