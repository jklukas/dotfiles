(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer `%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named `%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

(defun redshift-doc (command)
  "Open the docs for a Redshift command"
  (interactive "s command: ")
  (browse-url (format "http://docs.aws.amazon.com/redshift/latest/dg/r_%s.html" (upcase command))))

(defun camel-to-snake ()
  "Turn uppercase characters to lower with a preceding underscore"
  (interactive)
  (progn (replace-regexp "\\([a-z]\\)\\([A-Z]\\)" "\\1_\\2" nil (region-beginning)(region-end))
         (downcase-region (region-beginning)(region-end))))
