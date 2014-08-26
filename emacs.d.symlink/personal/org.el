;; Org mode preferences
(setq org-directory "~/Notes")
(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-agenda-files '("~/Notes"))

;; Global key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
