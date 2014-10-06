;; Org mode preferences
(setq org-directory "~/Notes")
(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-agenda-files '("~/Notes"))
(setq org-refile-targets '((nil :maxlevel . 2)
                                        ; all top-level headlines in the
                                        ; current buffer are used (first) as a
                                        ; refile target
                           (org-agenda-files :maxlevel . 2)))
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/Notes/tasks.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/Notes/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")))

;; Global key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
