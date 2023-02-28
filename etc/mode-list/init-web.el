;;; Package --- init-web :

;;; Commentary:
;;; 

;;; Code:
(setq common-indent-count 2)

(use-package rjsx-mode
  :ensure t
  )

(use-package
  web-mode
  :ensure t
  :custom
  (web-mode-comment-formats
  '(("java"       . "//")
    ("javascript" . "//")
    ("jsx" . "//")
    ("typescript" . "//")
    ("php"        . "/*")
    ("css"        . "/*")))
  :config
  (set-face-attribute
   'web-mode-current-element-highlight-face nil
   :foreground "plum"
   :background "black"
   ))

(use-package
  vue-mode
  :ensure t)

(add-hook 'web-mode-hook
          (lambda ()
            (setq web-mode-enable-current-element-highlight t)
            (setq web-mode-markup-indent-offset common-indent-count)
            (setq web-mode-css-indent-offset common-indent-count)
            (setq web-mode-code-indent-offset common-indent-count)
            ))


(defun set-common-indent (indent-count)
  (interactive "nSet indent: ")
  (progn
    (setq common-indent-count indent-count)
    (setq web-mode-markup-indent-offset indent-count)
    (setq web-mode-css-indent-offset indent-count)
    (setq web-mode-code-indent-offset indent-count)
    )
  )


;; frontend prettier
(use-package prettier-js
  :ensure t
  :config
  (progn
    (defalias 'Apt 'prettier-js-mode)
    ;; prettier-js-mode
    (add-hook 'prettier-js-mode-hook
	      (lambda ()
		(progn
		  (defalias 'Apt 'prettier-js))))
    ))

(defun filename ()   
    "Copy the full path of the current buffer."  
    (interactive)  
    (kill-new (buffer-file-name (window-buffer (minibuffer-selected-window)))))

(defun stylelint-prettier ()
  (interactive)
  (shell-command (format "stylelint --fix %s" (buffer-file-name))))

(use-package
  less-css-mode
  :ensure t
  :config
  (defalias 'Lpt 'stylelint-prettier))

;; (use-package
;;   stylus-mode
;;   :ensure t)

(use-package
  tide
  :ensure t
  :config
  ;; tide
  (defun setup-tide-mode ()
    "Set up for tide mode."
    (interactive)
    (tide-setup)
    (flycheck-mode +1)
    (setq flycheck-check-syntax-automatically '(save mode-enabled))
    (eldoc-mode +1)
    (tide-hl-identifier-mode +1)
    (setq comment-start "//")
    (setq comment-padding " ")
    (setq comment-end "")
    (setq comment-style 'indent)
    ;; company is an optional dependency. You have to
    ;; install it separately via package-install
    ;; `M-x package-install [ret] company`
    (company-mode +1))

  (add-hook 'web-mode-hook
            (lambda ()
              (when
                  (or (string-equal "tsx" (file-name-extension buffer-file-name))
                      (string-equal "ts" (file-name-extension buffer-file-name)))
                (progn
		  (setup-tide-mode)
                  )
		)))

  (add-hook 'typescript-mode-hook
            (lambda ()
              (setup-tide-mode)
              ))

  (setq indent-tabs-mode nil
	js-indent-level common-indent-count)
  (setq indent-tabs-mode nil
	typescript-indent-level common-indent-count)
  (setq css-indent-offset common-indent-count)
  )

(setq web-mode-comment-formats
              '(("jsx" . "//")
                ("tsx" . "//")
                ("javascript" . "//")))

(setq web-mode-comment-style 1)
;; Arius prettier
(defalias 'Apt 'prettier-js-mode)
;; prettier-js-mode
(add-hook 'prettier-js-mode-hook
	  (lambda ()
	    (progn
	      (defalias 'Apt 'prettier-js))))
(use-package typescript-mode
  :ensure t)

(provide 'init-web)
;;; init-web.el ends here

