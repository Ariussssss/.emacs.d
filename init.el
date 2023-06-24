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
 '(connection-local-criteria-alist
   '(((:application eshell)
      eshell-connection-default-profile)
     ((:application tramp)
      tramp-connection-local-default-system-profile tramp-connection-local-default-shell-profile)))
 '(connection-local-profile-alist
   '((eshell-connection-default-profile
      (eshell-path-env-list))
     (tramp-connection-local-darwin-ps-profile
      (tramp-process-attributes-ps-args "-acxww" "-o" "pid,uid,user,gid,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" "-o" "state=abcde" "-o" "ppid,pgid,sess,tty,tpgid,minflt,majflt,time,pri,nice,vsz,rss,etime,pcpu,pmem,args")
      (tramp-process-attributes-ps-format
       (pid . number)
       (euid . number)
       (user . string)
       (egid . number)
       (comm . 52)
       (state . 5)
       (ppid . number)
       (pgrp . number)
       (sess . number)
       (ttname . string)
       (tpgid . number)
       (minflt . number)
       (majflt . number)
       (time . tramp-ps-time)
       (pri . number)
       (nice . number)
       (vsize . number)
       (rss . number)
       (etime . tramp-ps-time)
       (pcpu . number)
       (pmem . number)
       (args)))
     (tramp-connection-local-busybox-ps-profile
      (tramp-process-attributes-ps-args "-o" "pid,user,group,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" "-o" "stat=abcde" "-o" "ppid,pgid,tty,time,nice,etime,args")
      (tramp-process-attributes-ps-format
       (pid . number)
       (user . string)
       (group . string)
       (comm . 52)
       (state . 5)
       (ppid . number)
       (pgrp . number)
       (ttname . string)
       (time . tramp-ps-time)
       (nice . number)
       (etime . tramp-ps-time)
       (args)))
     (tramp-connection-local-bsd-ps-profile
      (tramp-process-attributes-ps-args "-acxww" "-o" "pid,euid,user,egid,egroup,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" "-o" "state,ppid,pgid,sid,tty,tpgid,minflt,majflt,time,pri,nice,vsz,rss,etimes,pcpu,pmem,args")
      (tramp-process-attributes-ps-format
       (pid . number)
       (euid . number)
       (user . string)
       (egid . number)
       (group . string)
       (comm . 52)
       (state . string)
       (ppid . number)
       (pgrp . number)
       (sess . number)
       (ttname . string)
       (tpgid . number)
       (minflt . number)
       (majflt . number)
       (time . tramp-ps-time)
       (pri . number)
       (nice . number)
       (vsize . number)
       (rss . number)
       (etime . number)
       (pcpu . number)
       (pmem . number)
       (args)))
     (tramp-connection-local-default-shell-profile
      (shell-file-name . "/bin/sh")
      (shell-command-switch . "-c"))
     (tramp-connection-local-default-system-profile
      (path-separator . ":")
      (null-device . "/dev/null"))))
 '(org-agenda-files nil)
 '(package-selected-packages
   '(clang-format+ quelpa-use-package quelpa slime-repl-ansi-color omnisharp nim-mode zig-mode move-text groovy-mode keyfreq emacs-rainbow-fart highlight ggtags bazel emacs-bazel-mode lsp-pyright company-graphviz-dot graphviz-dot-mode expand-region sql-indent protobuf-mode quickrun esqlite common-header-mode-line jupyter ein lpy lpy-mode org-download elisp-mode rjsx-mode solaire-mode lua-mode racer lsp-python-ms lsp-ui ivy-lsp company-lsp lsp-javascript-typescript pyenv-mode gnuplot ox-gfm winner-mode ron-mode counsel-projectile helm-posframe applescript-mode Apples-mode apples-mode rust-mode vimrc-mode cdlatex company-auctex preview-latex auctex pangu-spacing zoom-window zoom auto-save major-mode-hydra cnfonts org-bullets thrift sudo-edit rotate all-the-icons-ivy all-the-icons-ivy-rich ivy-posframe posframe mplayer youdao-dictionary osx-dictionary vterm company company-box company-tabnine all-the-icons all-the-icons-dired anzu ace-window avy beacon dashboard dired-sidebar elpy elisp-format emojify flycheck find-file-in-project add-node-modules-path git-gutter helm helm-projectile helm-ag helm-swoop ivy indent-guide recentf magit multiple-cursors nyan-mode rainbow-delimiters smartparens session string-inflection origami powerline paradox page-break-lines prettier-js undo-tree wgrep which-key windmove yasnippet blacken yapfify go-mode json-mode markdown-mode nginx-mode php-mode request tide lsp-mode lispy scss-mode stylus-mode typescript-mode vue-mode web-mode yaml-mode nodejs-repl exec-path-from-shell doom-modeline doom-themes))
 '(warning-suppress-log-types '((comp) (yasnippet backquote-change)))
 '(warning-suppress-types '((lsp-mode) (lsp-mode) (yasnippet backquote-change))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:height 125))))
 '(mode-line-inactive ((t (:height 125)))))
