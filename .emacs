;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; General
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq-default ispell-program-name "aspell")
(setq text-mode-hook '(lambda() (flyspell-mode t) ))
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/emacs/site-lisp")
(global-set-key (kbd "C-z") 'undo)
;; Enlarge and shrink window
(global-set-key (kbd "C-{") 'enlarge-window-horizontally)
(global-set-key (kbd "C-}") 'shrink-window-horizontally)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Appearance
;; split horizontally
(setq split-height-threshold nil)
(setq split-width-threshold 0)
;; Startup
(setq inhibit-startup-message t)
(tool-bar-mode 0)
;; Color theme
(require 'color-theme)
(color-theme-classic)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Chinese Support
;; Input Method
(require 'ibus)
; defvar ibus-mode-hook in ibus.el
; add run-hooks ibus-mode-hook in ibus-mode-on
(add-hook 'ibus-mode-hook
	  '(lambda()
	     (local-set-key (kbd "S-SPC") 'ibus-toggle)))
(ibus-define-common-key ?\C-\s nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'dired-mode-hook
  	  '(lambda ()
	     (local-set-key (kbd "<f5>") 'dired-external-open)))

(defun dired-external-open ()
  (interactive)
  (let* ((filename (dired-get-filename nil t)))
    (message "Opening %s..." filename)
    (shell-command
     (concat "gnome-open " (shell-quote-argument filename)))
    (message "Opening %s done" filename)))

(require 'dired-details)
(require 'dired-details+)
(dired-details-install)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Programming
;; gtags
;; gtags c-mode-hook
(add-hook 'c-mode-hook
          '(lambda ()  (gtags-mode 1)))
(add-hook 'gtags-mode-hook
	  '(lambda() (local-set-key (kbd "<f11>") 'gtags-find-rtag)))
; Cycling gtags result
(defun ww-next-gtag ()
  "Find next matching tag, for GTAGS."
  (interactive)
  (let ((latest-gtags-buffer
         (car (delq nil  (mapcar (lambda (x) (and (string-match "GTAGS SELECT" (buffer-name x)) (buffer-name x)) )
                                 (buffer-list)) ))))
    (cond (latest-gtags-buffer
           (switch-to-buffer latest-gtags-buffer)
           (forward-line)
           (gtags-select-it nil))
          ) ))


(load-file "~/tools/cedet-1.1/common/cedet.el")
;(global-ede-mode 1)                      ; Enable the Project management system
(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion 
(global-srecode-minor-mode 1)            ; Enable template insertion menu
(add-hook 'c-mode-hook
	  '(lambda() (local-set-key (kbd "<f12>") 'semantic-ia-fast-jump)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LaTeX
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(setq TeX-save-query  nil )
(setq TeX-show-compilation t)
(setq TeX-PDF-mode t)
(setq TeX-parse-self t) ;; Enable parse on load
(setq-default TeX-master nil) ; Query for master file.
(eval-after-load "tex"
   '(add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex --synctex=1%(mode)%' %t" TeX-run-TeX nil (latex-mode doctex-mode) :help "Run XeLaTeX")))

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

; reftex
(require 'reftex)
(setq reftex-plug-into-AUCTeX t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Blogging

;; Weblogger
(require 'weblogger)
(load-file "~/.emacs.private")

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





