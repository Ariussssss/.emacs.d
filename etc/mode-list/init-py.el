;;; Package --- init-py :

;;; Commentary:
;;; 

;;; Code:

(setq py-python-command "python")
(setq py-shell-name "python")
(setq python-shell-interpreter "python")

;; (setq lsp-clients-python-command "/Users/arius/.pyenv/shims/pyls")
;; (use-package pyenv-mode
;;   :ensure t
;;   :config
;;   (progn
;;     (pyenv-mode)
;;     (pyenv-mode-set "3.8.10")))

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp-deferred)))
  :config
  (setq lsp-pyright-multi-root nil)
  (setq lsp-pyright-python-executable-cmd (concat (string-trim (shell-command-to-string "pyenv which python"))))
  )

(use-package lpy
  :load-path"../site-vendor/lpy/lpy.el")

(setq python-shell-completion-native-disabled-interpreters '("python"))
(use-package ein
  :load-path"../site-vendor/emacs-ipython-notebook.el")

(defun sort-python-imports ()
  "Sort Python imports using isort."
  (interactive)
  (when (executable-find "isort")
    (shell-command (format "isort %s" (shell-quote-argument (buffer-file-name))))
    (revert-buffer t t t)))

(use-package blacken
  :ensure t
  :custom
  (blacken-line-length 120)
  (blacken-skip-string-normalization t)
  )

(defun arz/python-auto-format ()
  (interactive)
  (when (eq major-mode 'python-mode)
    (py-isort-before-save)
    (blacken-buffer)))

(add-hook 'before-save-hook 'arz/python-auto-format)
(provide 'init-py)
;;; init-py.el ends here

