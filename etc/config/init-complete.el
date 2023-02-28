;;; Package --- init-completex :

;;; Commentary:
;;; 

;;; Code:

;; 著名的 Emacs 补全框架
(use-package company
  :ensure t
  :defer 2 
  :hook
  (after-init . global-company-mode)
  (emacs-lisp-mode . company-mode)
  :init (setq company-tooltip-align-annotations t company-idle-delay 0 company-echo-delay 0
	      company-minimum-prefix-length 2 company-require-match nil company-dabbrev-ignore-case
	      nil company-dabbrev-downcase nil company-show-numbers t) 
  )

;; 代码片段
(use-package yasnippet 
  :ensure t 
  :commands (yas-reload-all)
  :hook
  (prog-mode-hook . yas-minor-mode)
  (warning-suppress-types . yas-minor-mode)  :init (autoload 'yas-minor-mode-on "yasnippet") 
  (setq yas-snippet-dirs '("~/.emacs.d/etc/snippets")) 
  ;; (dolist (x '(org-mode-hook prog-mode-hook snippet-mode-hook)) 
  ;; (add-hook x #'yas-minor-mode-on))
  )
(add-to-list 'warning-suppress-types '(yasnippet backquote-change))


(yas-global-mode t)
(yas-reload-all)

(provide 'init-complete)
;;; init-complete.el ends here

