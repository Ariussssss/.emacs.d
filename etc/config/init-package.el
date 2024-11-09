;;; Package ---  init-package:

;;; Commentary:
;;; 

;;; Code:

(require 'package)

(package-initialize) ;; You might already have this line

;; (setq package-archives '(("gnu"   . "https://elpa.emacs-china.org/gnu/")
;;                           ("melpa" . "https://elpa.emacs-china.org/melpa/")))
(setq package-archives '(("gnu"   . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                        ("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
;; (setq package-archives '(("gnu"   . "https://elpa.emacs-china.org/gnu/")
;;                           ("melpa" . "https://melpa.org/packages/")))
    
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


(unless (package-installed-p 'quelpa)
  (with-temp-buffer
    (setq-local url-proxy-services
      '(("http"     . "127.0.0.1:7890")
	("https"     . "127.0.0.1:7890")))
    (url-insert-file-contents "https://raw.githubusercontent.com/quelpa/quelpa/master/quelpa.el")
    (eval-buffer)
    (quelpa-self-upgrade)
    (quelpa
     '(quelpa-use-package
       :fetcher git
       :url "https://github.com/quelpa/quelpa-use-package.git"))
    ))

(require 'quelpa-use-package)

(use-package exec-path-from-shell
  :ensure t
  :init
  ;; Only load if on macOS or Linux
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

(provide 'init-package)

;;; init-package.el ends here
