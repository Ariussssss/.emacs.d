;;; Package ---  Pre-Load:

;;; Commentary:
;;; 

;;; Code:

;; 设置缓存文件/杂七杂八的文件存放的地址
(setq user-emacs-directory "~/.emacs.d/var")
(setq package-user-dir "~/.emacs.d/var/vendor")
(setq desktop-dirname "~/.emacs.d/var/desktop-save")
;; 设置自动保存路径前缀
(setq auto-save-list-file-prefix "~/.emacs/var/auto-save-list/.saves-")
;; 设置eshell历史记录
(setq eshell-history-file-name "~/.emacs/var/eshell/history")

;;; init.el ends here
(provide 'pre-load)

;;; pre-load.el ends here
