;;; Package --- init-csharp :

;;; Commentary:

;;; Code:

;; (use-package omnisharp
;;   :ensure t
;;   )


(defun arz/find-or-show-doc ()
  "Find implementations of the symbol under point."
  (interactive)
  (progn (lsp-find-implementation)
    (lsp-ui-doc-show)
    )
  )


;; (use-package csharp-mode
;;   :ensure t
;;   :bind
;;   (:map csharp-mode-map
;;         ("M-." . arz/find-or-show-doc)
;; 	)
;;   )


(defun my-csharp-mode-setup ()
  ;; (omnisharp-mode)
  ;; (company-mode)
  ;; (flycheck-mode)
  
  ;; (setq indent-tabs-mode nil)
  ;; (setq c-syntactic-indentation t)
  ;; (c-set-style "ellemtel")
  ;; (setq c-basic-offset 4)
  ;; (setq truncate-lines t)
  ;; (setq tab-width 4)
  ;; (setq evil-shift-width 4)

  ;; 					;csharp-mode README.md recommends this too
  ;; 					;(electric-pair-mode 1)       ;; Emacs 24
  ;; (electric-pair-local-mode 1)		;; Emacs 25

  ;; (local-set-key (kbd "C-c r r") 'omnisharp-run-code-action-refactoring)
  ;; (local-set-key (kbd "C-c C-c") 'recompile)
  )

;; (add-hook 'csharp-mode-hook 'my-csharp-mode-setup t)

;; (add-hook 'after-init-hook #'unity-mode)

(provide 'init-csharp)
;;; init-csharp.el ends here

