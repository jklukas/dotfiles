;; (eval-after-load "sql" '(progn (sql-set-product 'postgres)))

(setq sql-connection-alist
      '((redshift-dev
         (sql-product 'postgres)
         (sql-port 5439)
         (sql-server "dev-data-pipeline.cuxrn97vbxid.us-east-1.redshift.amazonaws.com")
         (sql-user "jeffklukas")
         (sql-password "g#&pyf)R#=A8R`zwAglS)Iy&O8s|hTKq)#S.}iSMD?EQCYMUJITVLQdU8J,f66#p")
         (sql-database "analytics"))
        (redshift-prod
         (sql-product 'postgres)
         (sql-port 5439)
         (sql-server "prod-data-pipeline.cuxrn97vbxid.us-east-1.redshift.amazonaws.com")
         (sql-user "jeffklukas")
         (sql-database "analytics"))))

(defun sql-connect-preset (product connection)
  ;; load the password
  (require 'secrets "~/.emacs.d/secrets.el.gpg")
  ;; update the password to the sql-connection-alist
  (let ((connection-info (assoc connection sql-connection-alist))
        (sql-password (car (last (assoc connection sql-passwords)))))
    (delete sql-password connection-info)
    (nconc connection-info `((sql-password ,sql-password)))
    (setq sql-connection-alist (assq-delete-all connection sql-connection-alist))
    (add-to-list 'sql-connection-alist connection-info))
  ;; connect to database
  (setq sql-product product)
  connection
  ;;(sql-connect connection)
  )

;(sql-connect-preset 'postgres 'redshift-dev)

(defun sql-connect-redshift-dev ()
  (interactive)
  (sql-connect-preset 'postgres 'redshift-dev))


;; (defun sql-make-smart-buffer-name ()
;;   "Return a string that can be used to rename a SQLi buffer.
;;   This is used to set `sql-alternate-buffer-name' within
;;   `sql-interactive-mode'."
;;   (or (and (boundp 'sql-name) sql-name)
;;       (concat (if (not(string= "" sql-server))
;;                   (concat
;;                    (or (and (string-match "[0-9.]+" sql-server) sql-server)
;;                        (car (split-string sql-server "\\.")))
;;                    "/"))
;;               sql-database)))

;; (add-hook 'sql-interactive-mode-hook
;;           (lambda ()
;;             (setq sql-alternate-buffer-name (sql-make-smart-buffer-name))
;;             (sql-rename-buffer)
;;             (linum-mode 0)))

;; (defun get-sql-password (database)
;;   (require 'secrets "~/.emacs.d/secrets.el.gpg")
;;   (cadr (assoc database sql-passwords)))

;; (defun sql-prime-password (conn)
;;   (setq-default sql-password
;;                 (get-sql-password (car conn))))

;; (defun sql-get-login-presets (&rest what)
;;   "Return preset values for the current connection.
;;    This replaces SQL-GET-LOGIN in SQL-CONNECT-PRESET."
;;   (mapcar
;;    (lambda (sym)
;;      (let ((sym (if (listp sym) (car sym) sym)))
;;        (symbol-value (intern (format "sql-%s" (symbol-name sym))))))
;;    what))

;; (defun sql-get-presets ()
;;   "Return an alist of (SYMBOL . NAME) pairs for all defined SQL presets."
;;   (mapcar (lambda (conn) (cons (car conn) (symbol-name (car conn))))
;;           sql-connection-alist))

;; (defun sql-connect-preset (name &optional new)
;;   "Connect to a predefined SQL connection listed in `sql-connection-alist'"
;;   (interactive (list (intern (completing-read "Connection: "
;;                                               (sql-get-presets) nil t))
;;                      current-prefix-arg))
;;   (require 'sql)
;;   (let ((conn (assoc name sql-connection-alist))
;;         (sql-name (symbol-name name)))
;;     (sql-prime-password conn)
;;     (eval `(let ,conn
;;              (flet ((sql-get-login (&rest what)
;;                                    (apply 'sql-get-login-presets what)))
;;                (sql-product-interactive sql-product new))))))

;; (defun sql-convenience ()
;;   (interactive)
;;   (mapcar (lambda (conn)
;;             (let ((name (car conn)))
;;               (fset (intern (format "sql-%s" name))
;;                     `(lambda nil
;;                        ,(format "Connect to %s SQL preset." name)
;;                        (interactive)
;;                        (sql-connect-preset ',name)))))
;;           sql-connection-alist))

;; (sql-convenience)

;; (setq comint-output-filter-functions
;;       (cons 'sql-send-password-when-prompted
;;             (remove 'comint-watch-for-password-prompt
;;                     comint-output-filter-functions)))

;; (defun sql-send-password-when-prompted (string)
;;   "Watch for a password prompt and send the contents of SQL-PASSWORD."
;;   (if (not (and (boundp 'sql-password)
;;                 sql-password
;;                 (not (string= "" sql-password))
;;                 (string-match comint-password-prompt-regexp string)))
;;       (comint-watch-for-password-prompt string)

;;     (let ((proc (get-buffer-process (current-buffer))))
;;       (if (not proc)
;;           (error "Buffer %s has no process" (current-buffer))
;;         (comint-snapshot-last-prompt)
;;         (funcall comint-input-sender proc sql-password))))

;; )

;; (defun redshift-connect-prod ()
;;   (interactive)
;;   (redshift-connect 'postgres 'redshift-prod))

;; (defun redshift-connect (product connection)
;;   ;; load the password
;;   (require 'secrets "~/.emacs.d/secrets.el.gpg")

;;   ;; update the password to the sql-connection-alist
;;   (let ((connection-info (assoc connection sql-connection-alist))
;;         (sql-password (car (last (assoc connection sql-passwords)))))
;;     (delete sql-password connection-info)
;;     (nconc connection-info `((sql-password ,sql-password)))
;;     (setq sql-connection-alist (assq-delete-all connection sql-connection-alist))
;;     (add-to-list 'sql-connection-alist connection-info))

;;   ;; ;; connect to database
;;   ;; (setq sql-product product)
;;   ;; (sql-connect connection)
;; )
