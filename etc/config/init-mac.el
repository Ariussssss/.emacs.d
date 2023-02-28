;;; Package --- init-mac :

;;; Commentary:

;;; Code:

;; mac m1 最大化动画卡顿
(tool-bar-mode -1)
(setq frame-resize-pixelwise t)
(dotimes (n 3)
  (toggle-frame-maximized))

(provide 'init-mac)
;;; init-mac.el ends here

