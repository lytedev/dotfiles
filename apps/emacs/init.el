;; Setup package archives.
(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(package-initialize)

;; Setup `use-package`.
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

;; Load the bulk of our configuration from a fancy org file.
(org-babel-load-file "~/.emacs.d/config.org")
