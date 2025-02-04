(defmacro after-load (feature &rest body)
  "After FEATURE is loaded, evaluate BODY."
  (declare (indent defun))
  `(eval-after-load ,feature
     '(progn ,@body)))

;;----------------------------------------------------------------------------
;; Default warp line in org-mode
;;----------------------------------------------------------------------------
(add-hook 'org-mode-hook 'turn-on-visual-line-mode)


;;----------------------------------------------------------------------------
;; Default hide initial comment block
;;----------------------------------------------------------------------------
(add-hook 'c-mode-hook 'hs-hide-initial-comment-block)

;;----------------------------------------------------------------------------
;; Set command key as control
;;----------------------------------------------------------------------------
(setq mac-command-modifier 'control)

;;----------------------------------------------------------------------------
;; Set C-return to toggle fullscreen
;;----------------------------------------------------------------------------
;; (global-set-key (kbd "C-<return>") 'toggle-frame-fullscreen)

;;----------------------------------------------------------------------------
;; Copy current buffer file name as kill
;;----------------------------------------------------------------------------
(global-set-key (kbd "C-c p") 'copy-current-buffer-path-as-kill)
(global-set-key (kbd "C-c f") 'copy-current-buffer-filename-as-kill)
(global-set-key (kbd "C-c b") 'copy-current-buffer-filename-path-as-kill)

(defun copy-current-buffer-filename-path-as-kill ()
  (interactive)
  (when (buffer-file-name)
    (kill-new (buffer-file-name)))
  (message "%s" (buffer-file-name)))

(defun copy-current-buffer-filename-as-kill ()
  (interactive)
  (when (buffer-file-name)
    (kill-new (file-name-base buffer-file-name)))
  (message "%s" (file-name-base buffer-file-name)))

(defun copy-current-buffer-path-as-kill ()
  (interactive)
  (when (buffer-file-name)
    (kill-new (file-name-directory buffer-file-name)))
  (message "%s" (file-name-directory buffer-file-name)))

;;----------------------------------------------------------------------------
;; Key Bind C-s and C-r to regex search, C-M-s and C-M-r to normal search
;;----------------------------------------------------------------------------
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;;----------------------------------------------------------------------------
;; C-x C-k to kill-this-buffer
;;----------------------------------------------------------------------------
(global-set-key [(control x) (control k)] 'kill-this-buffer)

(defun kill-all-buffers ()
  "Kill all buffers."
  (interactive)
  (setq list (buffer-list))
  (while list
    (let* ((buffer (car list))
           (name (buffer-name buffer)))
      (and name                         ; Can be nil for an indirect buffer
                                        ; if we killed the base buffer.
           (not (string-equal name ""))
           (/= (aref name 0) ?\s)
           (kill-buffer buffer)))
    (setq list (cdr list))))

;;----------------------------------------------------------------------------
;; Key to switch between tabs,
;;----------------------------------------------------------------------------
;; (setq skippable-buffers '("*Messages*" "*scratch*" "*Help*"))
(setq skippable-buffers '("*scratch*" "*Messages*" "*Help*" " *code-conversion-work*" " *Minibuf-0*" " *Minibuf-1*" " *Echo Area 0*" " *Echo Area 1*" "*Backtrace*" " *server*" "TAGS"))

(defun my-next-buffer ()
  "next-buffer that skips certain buffers"
  (interactive)
  (next-buffer)
  (while (member (buffer-name) skippable-buffers)
    (next-buffer)))

(defun my-previous-buffer ()
  "previous-buffer that skips certain buffers"
  (interactive)
  (previous-buffer)
  (while (member (buffer-name) skippable-buffers)
    (previous-buffer)))

;; (defun my-backward-buffer ()
;;   (interactive)
;;   (switch-to-buffer (cadr (buffer-list))))

(defun remove-skippable-buffer (buffer-list)
  (if buffer-list
      (progn
        (if (or (string-match-p "\\*.+\\*" (buffer-name (car buffer-list)))
                (member (buffer-name (car buffer-list)) skippable-buffers))
            (remove-skippable-buffer (cdr buffer-list))
          (cons (car buffer-list) (remove-skippable-buffer (cdr buffer-list)))))))

(defvar how-many-buffers 0)

(defun my-backward-buffer ()
  (interactive)
  (unless (eq this-command last-command)
    (setq how-many-buffers 0))
  (let ((buffer-list (remove-skippable-buffer (buffer-list))))
    (if (> 2 (length buffer-list))
        (progn
          (message "Only one buffer."))
      (progn
        (setq how-many-buffers
              (+ 1 (% how-many-buffers (- (list-length buffer-list) 1))))
        (message "%s, %s" (nth how-many-buffers buffer-list)
                 (append (cdr (nthcdr how-many-buffers buffer-list))
                         (subseq buffer-list 0 how-many-buffers)))
        (switch-to-buffer (nth how-many-buffers buffer-list))))))

(global-set-key (kbd "C-<tab>") 'my-previous-buffer)
(global-set-key (kbd "C-S-<tab>") 'my-next-buffer)
;; (global-set-key (kbd "C-<tab>") 'my-next-buffer)
;; (global-set-key [M-tab] 'my-backward-buffer)

;;----------------------------------------------------------------------------
;; scratch buffer related
;;----------------------------------------------------------------------------
(defun switch-to-scratch-buffer nil
  "create a scratch buffer"
  (interactive)
  (switch-to-buffer (get-buffer-create "*scratch*"))
  (lisp-interaction-mode))

(defun generate-scratch-buffer nil
  (interactive)
  (switch-to-buffer
   (make-temp-name
    (concat
     (format-time-string "%Y-%m-%d_%H:%M:%S")
     "_scratch_")))
  (write-file (concat "/tmp/" (buffer-name))))

;;----------------------------------------------------------------------------
;; Yank whole buffer
;;----------------------------------------------------------------------------
(defun yank-whole-buffer ()
  (interactive)
  (kill-ring-save (point-min) (point-max))
  (message "yank whole buffer"))

;;----------------------------------------------------------------------------
;; Switch between tab indent
;;----------------------------------------------------------------------------
(defun toggle-tab-indent ()
  (interactive)
  (if indent-tabs-mode
      (setq indent-tabs-mode nil)
    (setq indent-tabs-mode t))
  (message "%s" indent-tabs-mode))

;;----------------------------------------------------------------------------
;; Enable uniquify buffer name
;;----------------------------------------------------------------------------
(require 'uniquify)
(setq
 uniquify-buffer-name-style 'post-forward
 uniquify-separator ":")


;;----------------------------------------------------------------------------
;; Make all yes or no to y or n
;;----------------------------------------------------------------------------
(fset 'yes-or-no-p 'y-or-n-p)


;;----------------------------------------------------------------------------
;; Save place
;;----------------------------------------------------------------------------
;;(require 'saveplace)
;;(save-place-mode t)
;;(setq save-place-file "~/.saved-places-emacs")


;;----------------------------------------------------------------------------
;; Delete the current file
;;----------------------------------------------------------------------------
(defun delete-this-file ()
  "Delete the current file, and kill the buffer."
  (interactive)
  (or (buffer-file-name) (error "No file is currently being edited"))
  (when (yes-or-no-p (format "Really delete '%s'?"
                             (file-name-nondirectory buffer-file-name)))
    (delete-file (buffer-file-name))
    (kill-this-buffer)))


;;----------------------------------------------------------------------------
;; Rename the current file
;;----------------------------------------------------------------------------
(defun rename-this-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (unless filename
      (error "Buffer '%s' is not visiting a file!" name))
    (if (get-buffer new-name)
        (message "A buffer named '%s' already exists!" new-name)
      (progn
        (when (file-exists-p filename)
          (rename-file filename new-name 1))
        (rename-buffer new-name)
        (set-visited-file-name new-name)
        (set-buffer-modified-p nil)))))

;;----------------------------------------------------------------------------
;; Browse current HTML file
;;----------------------------------------------------------------------------
(defun browse-current-file ()
  "Open the current file as a URL using `browse-url'."
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if (tramp-tramp-file-p file-name)
        (error "Cannot open tramp file")
      (browse-url (concat "file://" file-name)))))


(provide 'init-utils)
