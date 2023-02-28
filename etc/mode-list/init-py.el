;;; Package --- init-py :

;;; Commentary:
;;; 

;;; Code:

(setq py-python-command "python3")
(setq py-shell-name "python3")
(setq python-shell-interpreter "python3")
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i")

(setq lsp-clients-python-command "/Users/arius/.pyenv/shims/pyls")
(use-package blacken
  :ensure t
  :custom
  (blacken-line-length 120)
  (blacken-skip-string-normalization t)
  :hook
  (python-mode .
	       (lambda ()
		 (progn
		   (defalias 'Apt 'blacken-buffer))))
  )

(use-package pyenv-mode
  :ensure t
  :config
  (progn
    (pyenv-mode)
    (pyenv-mode-set "3.8.10")))

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp-deferred)))
  :init
  (setq lsp-pyright-multi-root nil))

(use-package lpy
  :load-path"../site-vendor/lpy/lpy.el")

(setq python-shell-completion-native-disabled-interpreters '("python"))
(use-package ein
  :load-path"../site-vendor/emacs-ipython-notebook.el")

(provide 'init-py)
;;; init-py.el ends here

