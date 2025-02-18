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
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(mode-line ((t (:height 125))))
;;  '(mode-line-inactive ((t (:height 125)))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ignored-local-variable-values '((encoding . utf-8)))
 '(package-selected-packages
   '(gdscript-mode pyenv-mode nov zoom-window zig-mode youdao-dictionary yaml-mode xclip which-key web-mode vue-mode vimrc-mode undo-tree typescript-mode tide thrift sudo-edit smartparens simple-httpd rustic rotate ron-mode rjsx-mode request rainbow-delimiters quickrun quelpa-use-package prettier-js pangu-spacing page-break-lines ox-gfm origami org-download org-bullets omnisharp nyan-mode nim-mode multiple-cursors move-text major-mode-hydra magit lua-mode lsp-ui lsp-pyright lispy kotlin-mode keyfreq ivy-posframe indent-guide groovy-mode go-translate go-mode gnuplot glsl-mode git-gutter format-all find-file-in-project fanyi exec-path-from-shell emms ellama doom-themes doom-modeline deadgrep counsel-projectile company-auctex clang-format+ cdlatex ccls blacken bazel anzu all-the-icons-ivy-rich all-the-icons-ivy all-the-icons-dired))
 '(select-enable-clipboard t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:height 125))))
 '(mode-line-inactive ((t (:height 125)))))
