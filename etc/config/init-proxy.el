;;; Package --- init-proxy :

;;; Commentary:

;;; Code:

;; Configure network proxy

(defun set-proxy ()
  "Set http/https proxy."
  (interactive)
  (setq url-gateway-method 'socks)
  ;; clash
  (setq command-proxy-prefix "export ALL_PROXY=socks5://127.0.0.1:7890; ")
  (setq socks-server '("Default server" "127.0.0.1" 7890 5))
  ;; ss
  ;; (setq command-proxy-prefix "export ALL_PROXY=socks5://127.0.0.1:1086; ")
  ;; (setq socks-server '("Default server" "127.0.0.1" 1086 5))
  )

(defun unset-proxy ()
  "Unset http/https proxy."
  (interactive)
  (setq command-proxy-prefix "")
  (setq url-gateway-method 'native)
  )

(defun toggle-proxy ()
  "Toggle http/https proxy."
  (interactive)
  (if url-proxy-services
      (unset-proxy)
    (set-proxy)))

(unset-proxy)

(provide 'init-proxy)
;;; init-proxy.el ends here

