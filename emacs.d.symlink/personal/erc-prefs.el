(require 'erc)
(require 'erc-truncate)
(require 'erc-hl-nicks)
(require 'erc-match)
(require 'tls)
(require 'znc)

(setq erc-modules '(autojoin
                    button
                    completion
                    irccontrols
                    keep-place
                    list
                    log
                    match
                    menu
                    move-to-prompt
                    netsplit
                    networks
                    noncommands
                    readonly
                    ring
                    scrolltobottom
                    stamp
                    track
                    truncate))
(erc-update-modules)

(setq erc-keywords '("\\bjklukas\\b"
                     "\\bjklukas's\\b"
                     "analytics"
                     "/b/ackend"
                     "backend"
                     "clojure"
                     "clojerks"
                     "storm"
                     "kafka"
                     "redshift"
                     "redshit"
                     "datapipeline"
                     "cascalog"
                     "machine learning"
                     "izhmash"
                     "doppler"
                     "hypha"
                     "cerebro"
                     "coinscope"
                     "beast"))

(autoload 'terminal-notifier-notify "terminal-notify" "terminal-notifier." t)

(if (file-exists-p
     "/Applications/terminal-notifier.app/Contents/MacOS/terminal-notifier")
    (add-hook 'erc-text-matched-hook 'erc-notify-me))

(defun is-robot? (nick)
  (or (string-match "\\`\\([sS]erver\\|localhost\\)" nick)
      (string-match "\\(bot\\|serv\\)!" nick)))

(defun erc-notify-me (match-type nick message) nil)

(defadvice erc-track-find-face
  (around erc-track-find-face-promote-query activate)
  (if (erc-query-buffer-p)
      (setq ad-return-value (intern "erc-current-nick-face"))
    ad-do-it))

(defun erc-next-link (arg)
  "Move point to the ARGth URL, or the end of the buffer if none."
  (interactive "p")
  (or (re-search-forward erc-button-url-regexp (point-max) t arg)
      (goto-char (point-max))))

(defun erc-previous-link (arg)
  "Move point to the ARGth most recent URL."
  (interactive "p")
  (when (looking-at erc-button-url-regexp)
    (re-search-backward "\\\s"))
  (re-search-backward erc-button-url-regexp 0 t))

(define-key erc-mode-map "\C-cp" 'erc-previous-link)
(define-key erc-mode-map "\C-cn" 'erc-next-link)
(add-hook 'erc-mode-hook (lambda () (auto-fill-mode 0)))
(add-hook 'erc-mode-hook (lambda () (erc-fill-disable)))

(defun erc-generate-log-file-name-with-date (buffer target nick server port)
  "Compute a short log file name.
   The name of the log file is composed of BUFFER and the current date.
   This function is a possible value for `erc-generate-log-file-name-function'.
   Modified for UTC."
  (concat (format-time-string "%Y-%m-%d" nil t) "-" nick "-" target  ".txt"))

(defun get-password (network)
  (require 'secrets "~/.emacs.d/secrets.el.gpg")
  (cadr (assoc network irc-passwords)))

(setq znc-servers
      `(("chat.banksimple.com" 9999 t
         ((simple "jklukas" ,(get-password 'simple))))
        ))

(set-face-foreground 'erc-keyword-face "slateblue")

(erc-match-mode t)
(erc-track-mode t)
(erc-autojoin-mode t)
(setq erc-prompt ">"
      erc-email-userid "jklukas_freenode_default"
      erc-join-query 'bury
      erc-join-buffer 'bury

      erc-log-channels-directory "~/.erc/logs/"
      erc-log-insert-log-on-open nil
      erc-log-matches-alist '((keyword . "&activity")
                              (current-nick . "&activity"))
      erc-generate-log-file-name-function 'erc-generate-log-file-name-with-date

      erc-track-exclude-types '("JOIN"
                                "NICK"
                                "PART"
                                "QUIT"
                                "MODE"
                                "NOTICE"
                                "324" ;; Channel Modes
                                "329" ;; Creation Time
                                "332" ;; topic change
                                "333" ;; shit znc spews
                                "353" ;; shit znc spews RPL_NAMEREPLY
                                "305" ;; shit znc spews (RPL_UNAWAY msg)
                                "477" ;; NoChanModes
                                )
      erc-track-switch-direction 'importance
      erc-track-use-faces t
      erc-track-exclude '("#clojure" "#storm")

      erc-timestamp-mode t
      erc-server-303-functions nil
      erc-server-coding-system '(utf-8 . utf-8)
      erc-server-auto-reconnect nil
      erc-autojoin-timing :ident
      erc-flood-protect nil
      erc-max-buffer-size 50000

      erc-current-nick-highlight-type 'all
      erc-hide-timestamps nil
      erc-timestamp-only-if-changed-flag nil
      erc-timestamp-format "%Y-%m-%d %H:%M:%S "
      erc-insert-timestamp-function 'erc-insert-timestamp-left
      erc-track-faces-priority-list '(erc-current-nick-face
                                      erc-keyword-face
                                      erc-prompt-face
                                      erc-nick-msg-face
                                      erc-direct-msg-face
                                      erc-notice-face)
      )

(defun erc-simple ()
  "Connect to Simple."
  (interactive)
  (erc-tls :server    "chat.banksimple.com"
           :port      9999
           :nick      "jklukas"
           :full-name "Jeff Klukas"
           :password  (get-password 'simple)))

(defun erc-freenode ()
  "Connect to Freenode."
  (interactive)
  (erc-tls :server    "irc.ircrelay.com"
           :port      6697
           :nick      "jklukas_freenode_default"
           :full-name "Jeff Klukas"
           :password  (get-password 'ircrelay)))
