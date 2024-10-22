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

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (progn
	      (defalias 'Apt 'clang-format))))

(use-package glsl-mode
  :ensure t)

(setq auto-mode-alist 
      (append
       '(
	 ("\\.\\(vs\\|fs\\|\\)\\'" . glsl-mode))
       auto-mode-alist))

(use-package clang-format+
  :ensure t
  :hook
  (c-mode-common-hook . clang-format+-mode)
  :quelpa (clang-format+
           :fetcher github
           :repo "SavchenkoValeriy/emacs-clang-format-plus"))

(provide 'init-cpp)
;;; init-cpp.el ends here

