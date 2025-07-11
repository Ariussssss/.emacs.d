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
 '(lsp-ui-sideline-enable nil)
 '(package-selected-packages
   '(all-the-icons-dired all-the-icons-ivy all-the-icons-ivy-rich anzu
			 bazel blacken ccls cdlatex clang-format+
			 company-auctex counsel-projectile deadgrep
			 doom-modeline doom-themes ellama emms
			 exec-path-from-shell fanyi
			 find-file-in-project format-all gdscript-mode
			 git-gutter glsl-mode gnuplot go-mode
			 go-translate groovy-mode helm-posframe
			 indent-guide ivy-posframe keyfreq kotlin-mode
			 lispy log4j-mode lsp-pyright lsp-ui lua-mode
			 magit major-mode-hydra move-text
			 multiple-cursors nim-mode nov nyan-mode
			 omnisharp org-bullets org-download origami
			 ox-gfm page-break-lines pangu-spacing
			 prettier-js py-isort pyenv-mode
			 quelpa-use-package quickrun
			 rainbow-delimiters request rjsx-mode ron-mode
			 rotate rustic simple-httpd smartparens
			 stylus-mode sudo-edit sws-mode thrift tide
			 typescript-mode undo-tree vimrc-mode vue-mode
			 web-mode which-key wl-clipboard-x xclip
			 yaml-mode youdao-dictionary zig-mode
			 zoom-window))
 '(select-enable-clipboard t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:height 125))))
 '(mode-line-inactive ((t (:height 125)))))
