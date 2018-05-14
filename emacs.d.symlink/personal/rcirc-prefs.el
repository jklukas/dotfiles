(require 'tls)

(defun get-password (network)
  (require 'secrets "~/.emacs.d/secrets.el.gpg")
  (cadr (assoc network irc-passwords)))

;; (setq rcirc-server-alist
;;       (list
;;        (list "irc.freenode.net"
;;              :channels '("#rcirc"))
;;        (list "chat.banksimple.com"
;;              :username   "jklukas"
;;              :port        9999
;;              :encryption 'tls
;;              :password    (get-password 'simple)
;;              :channels   '("#analytics"))))

(defun irc-simple ()
  "Connect to Simple IRC"
  (interactive)
  (rcirc-connect "chat.banksimple.com"
                 "9999" ; port
                 "klukas"  ; nick
                 "jklukas"  ; user-name
                 "Jeff Klukas"; full name
                 nil    ; startup-channels
                 (get-password 'simple)
                 'tls))

(defun irc-freenode ()
  "Connect to Simple IRC"
  (interactive)
  (rcirc-connect "irc.freenode.net"))

(defun irc-slack ()
  "Connect to Simple Slack"
  (interactive)
  (rcirc-connect "banksimple.irc.slack.com"
                 "6667"    ; port
                 "klukas"  ; nick
                 "klukas"  ; user-name
                 "Jeff Klukas"; full name
                 nil    ; startup-channels
                 (get-password 'simpleslack)
                 'tls))
