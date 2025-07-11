;;; Package ---  init-package:

;;; Commentary:
;;; 

;;; Code:

(require 'package)



(setq package-archives '(("gnu" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
                         ("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
                         ("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")))
;; (setq package-archives '(("gnu"    . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
;;                          ("nongnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
;;                          ("melpa"  . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize) ;; You might already have this line
;; (setq package-archives '(("gnu"   . "https://elpa.emacs-china.org/gnu/")
;;                           ("melpa" . "https://melpa.org/packages/")))
    
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


;; (unless (package-installed-p 'quelpa)
;;   (with-temp-buffer
;;     (setq-local url-proxy-services
;;       '(("http"     . "127.0.0.1:7890")
;; 	("https"     . "127.0.0.1:7890")))
;;     (url-insert-file-contents "https://raw.githubusercontent.com/quelpa/quelpa/master/quelpa.el")
;;     (eval-buffer)
;;     (quelpa-self-upgrade)
;;     (quelpa
;;      '(quelpa-use-package
;;        :fetcher git
;;        :url "https://github.com/quelpa/quelpa-use-package.git"))
;;     ))

;; (require 'quelpa-use-package)

:::(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize)
  )

(provide 'init-package)

;;; init-package.el ends here
