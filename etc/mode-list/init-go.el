;;; Package --- init-go :

;;; Commentary:

;;; Code:

;; go get github.com/rogpeppe/godef

(use-package
  go-mode
  :ensure t
  :hook
  (before-save . gofmt-before-save)
  (go-mode . arz/go-initial)
  :config
  (defun arz/go-initial ()
    (setq tab-width 4)
    (local-set-key (kbd "M-.") 'godef-jump)
    )
  )

(provide 'init-go)
;;; init-go.el ends here

