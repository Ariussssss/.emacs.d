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
 '(custom-safe-themes
   '("7a7b1d475b42c1a0b61f3b1d1225dd249ffa1abb1b7f726aec59ac7ca3bf4dae" "7eea50883f10e5c6ad6f81e153c640b3a288cd8dc1d26e4696f7d40f754cc703" "234dbb732ef054b109a9e5ee5b499632c63cc24f7c2383a849815dacc1727cb6" "1704976a1797342a1b4ea7a75bdbb3be1569f4619134341bd5a4c1cfb16abad4" "01cf34eca93938925143f402c2e6141f03abb341f27d1c2dba3d50af9357ce70" "5379937b99998e0510bd37ae072c7f57e26da7a11e9fb7bced8b94ccc766c804" "a3bdcbd7c991abd07e48ad32f71e6219d55694056c0c15b4144f370175273d16" "4bca89c1004e24981c840d3a32755bf859a6910c65b829d9441814000cf6c3d0" "990e24b406787568c592db2b853aa65ecc2dcd08146c0d22293259d400174e37" "e3c64e88fec56f86b49dcdc5a831e96782baf14b09397d4057156b17062a8848" default))
 '(org-agenda-files nil)
 '(package-selected-packages
   '(omnisharp nim-mode zig-mode move-text groovy-mode keyfreq emacs-rainbow-fart highlight ggtags bazel emacs-bazel-mode lsp-pyright company-graphviz-dot graphviz-dot-mode expand-region sql-indent protobuf-mode quickrun esqlite common-header-mode-line jupyter ein lpy lpy-mode org-download elisp-mode rjsx-mode solaire-mode lua-mode racer lsp-python-ms lsp-ui ivy-lsp company-lsp lsp-javascript-typescript pyenv-mode gnuplot ox-gfm winner-mode ron-mode counsel-projectile helm-posframe applescript-mode Apples-mode apples-mode rust-mode vimrc-mode cdlatex company-auctex preview-latex auctex pangu-spacing zoom-window zoom auto-save major-mode-hydra cnfonts org-bullets thrift sudo-edit rotate all-the-icons-ivy all-the-icons-ivy-rich ivy-posframe posframe mplayer youdao-dictionary osx-dictionary vterm company company-box company-tabnine all-the-icons all-the-icons-dired anzu ace-window avy beacon dashboard dired-sidebar elpy elisp-format emojify flycheck find-file-in-project add-node-modules-path git-gutter helm helm-projectile helm-ag helm-swoop ivy indent-guide recentf magit multiple-cursors nyan-mode rainbow-delimiters smartparens session string-inflection origami powerline paradox page-break-lines prettier-js undo-tree wgrep which-key windmove yasnippet blacken yapfify go-mode json-mode markdown-mode nginx-mode php-mode request tide lsp-mode lispy scss-mode stylus-mode typescript-mode vue-mode web-mode yaml-mode nodejs-repl exec-path-from-shell doom-modeline doom-themes))
 '(warning-suppress-log-types '((comp) (yasnippet backquote-change)))
 '(warning-suppress-types '((lsp-mode) (lsp-mode) (yasnippet backquote-change))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:height 125))))
 '(mode-line-inactive ((t (:height 125)))))
