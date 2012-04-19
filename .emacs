(setq-default ispell-program-name "aspell")
(setq inhibit-startup-message t)
(setq make-backup-files nil)
(setq auto-save-default nil)

(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "<f11>") 'gtags-find-rtag)
(global-set-key (kbd "<f12>") 'semantic-ia-fast-jump)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")

(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/emacs/site-lisp")

(require 'color-theme)
(color-theme-initialize)
(color-theme-classic)


(tool-bar-mode 0)

;; gtags c-mode-hook
(setq c-mode-hook
          '(lambda ()
              (gtags-mode 1)
      ))

(load-file "~/tools/cedet-1.0.1/common/cedet.el")
;(global-ede-mode 1)                      ; Enable the Project management system
(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion 
(global-srecode-minor-mode 1)            ; Enable template insertion menu

;(add-to-list 'load-path "~/tools/ecb-2.40")

;(require 'ecb-autoloads)
;(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
; '(ecb-options-version "2.40"))
;(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
; )


(add-hook 'LaTeX-mode-hook (lambda()
  (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %s" TeX-run-TeX nil t))
  (setq TeX-command-default "XeLaTeX")
  (setq TeX-save-query  nil )
  (setq TeX-show-compilation t)
))


;; split horizontally
(setq split-height-threshold nil)
(setq split-width-threshold 0)

;(require 'ibus)
;(add-hook 'after-init-hook 'ibus-mode-on)



;; Weblogger
(require 'weblogger)
;(setq weblogger-config-alist
;      '(("introveryang"
;         ("user" . "yangjiacheng")
;         ("pass" . "fireman")
;         ("server-url" . "http://127.0.1.1/xmlrpc.php")
;         ("weblog" . "1"))))

(add-hook 'weblogger-start-edit-entry-hook
          (lambda()
            (flyspell-mode 1)
            (flyspell-buffer)   ; spell check the fetched post
            (auto-fill-mode -1)
            (visual-line-mode 1)))
(add-hook 'weblogger-publish-entry-hook
          (lambda()
            (when visual-line-mode
              (visual-line-mode -1))
            ;; tabs might spoil code indentation
            (untabify (point-min) (point-max))))
(add-hook 'weblogger-publish-entry-end-hook
          (lambda()
            (visual-line-mode 1)))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(weblogger-config-alist (quote (("introvertyang" "http://127.0.1.1/xmlrpc.php" "yangjiacheng" "fireman" "1")))))




