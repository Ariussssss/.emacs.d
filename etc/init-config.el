;;; Package --- init-conifg :

;;; Commentary:
;;; 

;;; Code:

;; 图形界面插件的设置
(setq graphic-only-plugins-setting ())

(defun graphic-p ()
  "判断当前环境是否为图形环境"
  (if (display-graphic-p)
      t))

(require 'pre-load)
(require 'init-package)
(require 'init-base)
(require 'init-mac)
(require 'init-proxy)
(require 'init-mode)
(require 'init-ui)
(require 'init-complete)
(require 'init-tool)
(require 'init-shortcut)
(require 'init-custom)
(require 'init-marco)
(when (require 'init-private nil 'noerror) nil)

(when (graphic-p)
  (dolist (elisp-code graphic-only-plugins-setting)
    (eval elisp-code)))

(provide 'init-config)
;;; init-config.el ends here
