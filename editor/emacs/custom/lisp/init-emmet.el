(add-to-list 'load-path "~/emacs.d/emmet-mode")
;;(require 'emmet-mode)'

(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
