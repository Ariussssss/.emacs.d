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

(use-package exec-path-from-shell
    :ensure t)
    
;; Find Executable Path on OS X
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))


(provide 'init-package)

;;; init-package.el ends here
