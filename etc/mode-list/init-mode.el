;;; Package ---  :

;;; Commentary:
;;; 

;;; Code:

(require 'init-elisp)
(require 'init-py)
(require 'init-web)
(require 'init-org)
(require 'init-go)
(require 'init-tex)
(require 'init-vim)
(require 'init-rust)
(require 'init-lua)
(require 'init-cpp)
(require 'init-java)
(require 'init-settings)
(require 'init-mac)
(require 'init-lisp)
(require 'init-latex)
(require 'init-zig)
(require 'init-csharp)

(use-package
  groovy-mode
  :ensure t)

(require 'init-jenkins)

(use-package
  thrift
  :ensure t
  :config
  (setq thrift-indent-level 8))

;; LSP
(use-package lsp-mode
  :ensure t
  :commands lsp
  :custom
  (lsp-idle-delay 1200)
  (lsp-auto-guess-root nil)
  (lsp-file-watch-threshold 2000)
  (read-process-output-max (* 1024 1024))
  (lsp-eldoc-hook nil)
  (lsp-prefer-flymake nil)
  :bind
  (:map lsp-mode-map	
	("C-c C-f" . lsp-format-buffer)
	("M-RET" . lsp-ui-sideline-apply-code-actions))
  :hook ((go-mode python-mode csharp-mode) . lsp))

(use-package lsp-ui
  :ensure t
  :custom
  (lsp-ui-sideline-enable t)
  (lsp-ui-sideline-show-symbl t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-sideline-show-diagnostics nil)
  (lsp-ui-sideline-show-code-actions t)
  (lsp-ui-doc-show-with-cursor t)
  (lsp-ui-sideline-code-actions-prefix "♔")
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-delay 0.5)
  :init
  (add-hook 'lsp-mode-hook 'lsp-ui-sideline-mode)
  (face-spec-set 'lsp-ui-sideline-current-symbol
		 '((t
		    :background "black"
		    :foreground "magenta"
		    :weight ultra-bold
		    :box (:line-width -1 :color "black")
		    :height 0.99)))
  (face-spec-set 'lsp-ui-sideline-symbol
		 '((t :foreground "deep pink")))
  (face-spec-set 'lsp-ui-sideline-symbol-info
		 '((t :foreground "yellow")))
  )

(use-package format-all
  :ensure t)

(use-package dockerfile-mode
  :load-path "../site-vendor/dockerfile-mode/dockerfile-mode.el")

(setq auto-mode-alist 
      (append
       '(
	 ("\\.\\(js\\|es6\\|snap\\)\\'" . js-mode)
	 ;; ("\\.styl\\'" . stylus-mode)
	 ("\\.less\\'" . less-css-mode)
	 ("\\(rc\\)\\'" . sh-mode)
	 ("\\.\\(html\\|tpl\\|tsx?\\|handlebars\\)\\'" . web-mode)
         ("\\.json\\|rc\\'" . js-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.yml\\'" . yaml-mode)
         ("\\.ts\\'" . typescript-mode)
         ("\\.thrift\\'" . thrift-mode)
         ("\\.vue\\'" . vue-mode))
       auto-mode-alist))

(setq ispell-program-name "/usr/local/bin/aspell")

(defun arz/flyspell-toggle-english ()
  (interactive)
  (if (bound-and-true-p flyspell-mode)
      (flyspell-mode 0)
    (progn 
      (ispell-change-dictionary "default")
      (flyspell-mode)
      (flyspell-buffer)))
  )

(use-package nim-mode
  :ensure t)

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))

(provide 'init-mode)
;;; init-mode.el ends here

