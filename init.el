;;; Commentary:
;;; Package ---  Init:

;;; 

;;; Code:

;; 递归遍历加载路径
(defun add-subdirs-to-load-path(dir)
  "Recursive add directories `DIR` to `load-path`."
  (let ((default-directory (file-name-as-directory dir)))
    (add-to-list 'load-path dir)
    (normal-top-level-add-subdirs-to-load-path)))

(let ((gc-cons-threshold most-positive-fixnum)
      (file-name-ot-handler-alist nil))
  (add-subdirs-to-load-path "~/.emacs.d/etc/")
  (if (file-directory-p "~/.emacs.d-sub/")
      (add-subdirs-to-load-path "~/.emacs.d-sub/")
    )
  )

(require 'init-config)

(provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files nil)
 '(package-selected-packages
   '(slime-repl-ansi-color omnisharp nim-mode zig-mode move-text groovy-mode keyfreq emacs-rainbow-fart highlight ggtags bazel emacs-bazel-mode lsp-pyright company-graphviz-dot graphviz-dot-mode expand-region sql-indent protobuf-mode quickrun esqlite common-header-mode-line jupyter ein lpy lpy-mode org-download elisp-mode rjsx-mode solaire-mode lua-mode racer lsp-python-ms lsp-ui ivy-lsp company-lsp lsp-javascript-typescript pyenv-mode gnuplot ox-gfm winner-mode ron-mode counsel-projectile helm-posframe applescript-mode Apples-mode apples-mode rust-mode vimrc-mode cdlatex company-auctex preview-latex auctex pangu-spacing zoom-window zoom auto-save major-mode-hydra cnfonts org-bullets thrift sudo-edit rotate all-the-icons-ivy all-the-icons-ivy-rich ivy-posframe posframe mplayer youdao-dictionary osx-dictionary vterm company company-box company-tabnine all-the-icons all-the-icons-dired anzu ace-window avy beacon dashboard dired-sidebar elpy elisp-format emojify flycheck find-file-in-project add-node-modules-path git-gutter helm helm-projectile helm-ag helm-swoop ivy indent-guide recentf magit multiple-cursors nyan-mode rainbow-delimiters smartparens session string-inflection origami powerline paradox page-break-lines prettier-js undo-tree wgrep which-key windmove yasnippet blacken yapfify go-mode json-mode markdown-mode nginx-mode php-mode request tide lsp-mode lispy scss-mode stylus-mode typescript-mode vue-mode web-mode yaml-mode nodejs-repl exec-path-from-shell doom-modeline doom-themes))
 '(warning-suppress-log-types '((comp) (yasnippet backquote-change)))
 '(warning-suppress-types '((lsp-mode) (lsp-mode) (yasnippet backquote-change))))

