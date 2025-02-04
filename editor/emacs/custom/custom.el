(global-linum-mode t)    ;;显示行号
;;(add-hook 'prog-mode-hook 'linum-mode)
(setq linum-format "%2d ")

;; Themes PATH
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas" :foundry "microsoft" :slant italic :weight normal :height 120 :width normal)))))

;; Windows size setting
(setq default-frame-alist
'(
 (top . 0)
 (left . 0)
 (width . 1370)
 (height . 800)
 (cursor-type . box)
 (cursor-intangible-mode)
 (cursor-color . "yellow")))

;; virual-regex configure
;;(add-to-list 'load-path "folder-in-which-visual-regexp-files-are-in/") ;; if the files are not already in the load path
(require 'visual-regexp)
(define-key global-map (kbd "C-c r") 'vr/replace)
(define-key global-map (kbd "C-c q") 'vr/query-replace)

;;(define-key global-map (kbd "C-c m") 'vr/mc-mark)

;; (require 'powerline)
(powerline-default-theme)

;; Themes setting
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#0a0814" "#f2241f" "#67b11d" "#b1951d" "#4f97d7" "#a31db1" "#28def0" "#b2b2b2"])
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("ff7625ad8aa2615eae96d6b4469fcc7d3d20b2e1ebc63b761a349bebbb9d23cb" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "3d5ef3d7ed58c9ad321f05360ad8a6b24585b9c49abcee67bdcbb0fe583a6950" "1a85b8ade3d7cf76897b338ff3b20409cb5a5fbed4e45c6f38c98eee7b025ad4" "967c58175840fcea30b56f2a5a326b232d4939393bed59339d21e46cf4798ecf" "2daf79d4048f0f7280f6e6b763c8c81f8cef96ef8444b42ea0eb3023fe387eac" "b1d7c140dfbd88361f689fd1c6be4023641dde001904add1996ab7e17618373f" default)))
 '(display-time-mode t)
 '(fringe-mode 0 nil (fringe))
 '(package-selected-packages
   (quote
    (page-break-lines projectile dashboard nyan-mode dracula-theme helm ## emmet-mode org w3m yasnippet yaml-mode web-mode w3 visual-regexp vimrc-mode twilight-anti-bright-theme tabbar-ruler spacemacs-theme smex smartparens smart-mode-line slime popup-kill-ring multiple-cursors markdown-mode lua-mode json-reformat js2-mode jedi iedit idomenu ido-vertical-mode ido-ubiquitous ido-hacks highlight-parentheses guide-key-tip groovy-mode gradle-mode google-c-style git-timemachine fuzzy flx-ido fill-column-indicator f expand-region evil-leader ethan-wspace etags-select dired+ circe cdlatex browse-kill-ring bind-key auctex anzu ansible-doc ag)))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))

;; Configure Pair
(when (fboundp 'electric-pair-mode)
  (electric-pair-mode))
(when (eval-when-compile (version< "24.4" emacs-version))
  (electric-indent-mode 1))

;; Close Auto-Save
(setq auto-save-default nil)

;; 光标靠近Mouse时让Mouse自动走开
(mouse-avoidance-mode 'jump)

;;url-proxy-service
(setq url-gateway-method 'socks)
(setq socks-server '("Default server" "127.0.0.1" 1080 5))

;; helm-configuration
(require 'helm-config)

;; all backups Goto ~/.auto-save-list instead in the current directory
;; (setq make-backup-file nil)
(setq backup-directory-alist (quote (("." . "~/.emacs.d/auto-save-list"))))

;; Dashboard
;; (require 'dashboard)
;; (dashboard-setup-startup-hook)
;; 
;; (setq dashboard-items '((recents  . 5)
;;                         ;;(bookmarks . 5)
;;                         ;;(projects . 5)
;;                         ))
;; ;; Set the title
;; (setq dashboard-banner-logo-title "[I r 4 s R]")
;; Set the banner
;; (setq dashboard-startup-banner [VALUE])
;; Value can be
;; 'official which displays the official emacs logo
;; 'logo which displays an alternative emacs logo
;; 1, 2 or 3 which displays one of the text banners
;; "path/to/your/image.png which displays whatever image you would prefer
;;(defun dashboard-insert-custom ()
;;  (insert "Custom text"))
;;(add-to-list 'dashboard-item-generators  '(custom . dashboard-insert-custom))
;;(add-to-list 'dashboard-items '(custom) t)
