(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package auto-compile :config (auto-compile-on-load-mode))
(setq load-prefer-newer t)

(setq evil-want-abbrev-expand-on-insert-exit nil)

(use-package evil
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil)

(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

(use-package evil-org
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda () (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package key-chord :after evil)
(key-chord-mode 1)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)

(defun lytedev/reload-config ()
    (interactive)
    (load-file "~/.emacs"))
(global-set-key (kbd "C-x M-r") 'lytedev/reload-config)

(tool-bar-mode 0)
(menu-bar-mode 1) ;; Keep the menu while I'm a newb.
(scroll-bar-mode -1)

(set-window-scroll-bars (minibuffer-window) nil nil)

(use-package monokai-theme)
(let ((line (face-attribute 'mode-line :underline)))
    (set-face-attribute 'mode-line          nil :overline   line)
    (set-face-attribute 'mode-line-inactive nil :overline   line)
    (set-face-attribute 'mode-line-inactive nil :underline  nil)
    (set-face-attribute 'mode-line          nil :box        nil)
    (set-face-attribute 'mode-line-inactive nil :box        nil)
    (set-face-attribute 'mode-line-inactive nil :background "#f9f2d9"))

(defun lytedev/apply-theme ()
    (interactive)
    (load-theme 'monokai t))

;; (if (daemonp)
;;   (add-hook 'after-make-frame-functions (lambda (frame) (with-selected-frame frame

(use-package moody
    :config
    (setq x-underline-at-descent-line t)
    (moody-replace-mode-line-buffer-identification)
    (moody-replace-vc-mode))

(setq lytedev/default-font "Iosevka Type")
(setq lytedev/default-font-size 10)
(setq lytedev/min-font-size 4)
(setq lytedev/current-font-size lytedev/default-font-size)

(setq lytedev/font-change-increment 1.1)

(defun lytedev/font-code ()
  (concat lytedev/default-font "-" (number-to-string lytedev/current-font-size)))

(defun lytedev/set-font-size ()
  (let ((font-code (lytedev/font-code)))
  (if (assoc 'font default-frame-alist)
    (setcdr (assoc 'font default-frame-alist) font-code)
    (add-to-list 'default-frame-alist (cons 'font font-code)))
  (set-frame-font font-code)))
  
(defun lytedev/reset-font-size ()
  (interactive)
  (setq lytedev/current-font-size lytedev/default-font-size)
  (lytedev/set-font-size))
 
(defun lytedev/increase-font-size ()
  (interactive)
  (setq lytedev/current-font-size (ceiling (* lytedev/current-font-size lytedev/font-change-increment)))
  (lytedev/set-font-size))
 
(defun lytedev/decrease-font-size ()
  (interactive)
  (setq lytedev/current-font-size (max lytedev/min-font-size (floor (/ lytedev/current-font-size lytedev/font-change-increment))))
  (lytedev/set-font-size))
  
(define-key global-map (kbd "C-+") 'lytedev/increase-font-size)
(define-key global-map (kbd "C--") 'lytedev/decrease-font-size)
(define-key global-map (kbd "C-0") 'lytedev/reset-font-size)

;; NOTE: I have no clue what this does... yet.
(global-prettify-symbols-mode t)
