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
  :hook ((go-mode python-mode csharp-mode gdscript-mode) . lsp))

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

(setq ispell-program-name "/usr/bin/aspell")

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

(use-package eglot
  :ensure t)

(use-package gdscript-mode
  :ensure t
  :hook (gdscript-mode . eglot-ensure)
  :custom (gdscript-eglot-version 3))

(setq gdscript-godot-executable "~/.local/bin/Redot")

(defun lsp--gdscript-ignore-errors (original-function &rest args)
  "Ignore the error message resulting from Godot not replying to the `JSONRPC' request."
  (if (string-equal major-mode "gdscript-mode")
      (let ((json-data (nth 0 args)))
        (if (and (string= (gethash "jsonrpc" json-data "") "2.0")
                 (not (gethash "id" json-data nil))
                 (not (gethash "method" json-data nil)))
            nil				; (message "Method not found")
          (apply original-function args)))
    (apply original-function args)))
;; Runs the function `lsp--gdscript-ignore-errors` around `lsp--get-message-type` to suppress unknown notification errors.
(advice-add #'lsp--get-message-type :around #'lsp--gdscript-ignore-errors)

(quickrun-add-command "gdscript/module"
  '((:command . "Redot")
    (:exec    . ("%c -- %n"))
    (:timeout . 99999)
    (:tempfile nil))
  :mode 'gdscript-mode)
(setq gdscript-docs-local-path "/home/arius/Packages/godotengine/godot-docs/_build/html")

(provide 'init-mode)
;;; init-mode.el ends here

