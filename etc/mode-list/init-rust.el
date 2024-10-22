;;; Package --- init-rust :

;;; Commentary:

;;; Code:
(use-package
  rust-mode
  :ensure t)

(use-package
  ron-mode
  :ensure t)

(use-package
  racer
  :disabled t 
  :ensure t
  :custom
  (racer-rust-src-path
   (concat (string-trim
            (shell-command-to-string "rustc --print sysroot"))
           "/lib/rustlib/src/rust/library"))
  :hook
  (rust-mode . racer-mode))

;; $ git clone https://github.com/rust-analyzer/rust-analyzer.git
;; $ cd rust-analyzer
;; $ cargo xtask install --server # will install rust-analyzer into $HOME/.cargo/bin
(use-package rustic
  :ensure t
  :custom
  (rustic-analyzer-command '("rustup" "run" "stable" "rust-analyzer"))
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  :config
  (setq lsp-rust-analyzer-display-chaining-hints t)
  (setq lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (setq lsp-rust-analyzer-display-parameter-hints t)
  (setq lsp-rust-analyzer-server-display-inlay-hints t)
  )

(provide 'init-rust)
;;; init-rust.el ends here
