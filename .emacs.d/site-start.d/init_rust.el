(require 'rust-mode)
(require 'racer)
(add-to-list 'exec-path (expand-file-name "~/.cargo/bin/"))

;;; rust-modeでrust-format-on-saveをtにすると自動でrustfmtが走る
(eval-after-load "rust-mode"
  '(progn
     (define-key rust-mode-map (kbd "C-:") 'company-complete-common)
     (setq-default rust-format-on-save t))
  )
;;; rustのファイルを編集するときにracerとflycheckを起動する
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'flycheck-rust-setup)
(add-hook 'racer-mode-hook #'flycheck-mode)

(custom-set-variables
 '(racer-rust-src-path "~/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src")
)

;;; racerのeldocサポートを使う
(add-hook 'racer-mode-hook #'eldoc-mode)
;;; racerの補完サポートを使う
(add-hook 'racer-mode-hook
          (lambda ()
            (company-mode)
            ))
(provide 'init_rust)

