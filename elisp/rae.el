;;; rae.el --- Rapid Org agenda via ripgrep file discovery -*- lexical-binding: t; -*-

;; Author: xbc5
;; Version: 0.1.0
;; Package-Requires: ((emacs "27.1"))
;; Keywords: outlines, calendar
;; URL: https://github.com/xbc5/rapid-agenda-extractor

;;; Commentary:

;; Org agenda is slow because it scans every agenda file.  I narrow the
;; list down to only the files marked active, using ripgrep, then let Org
;; build the agenda as it normally does.  Org still parses, expands
;; repeats, applies skips, and renders -- the result is identical, just
;; faster.

;;; Code:

(defgroup rae nil
  "Rapid Org agenda via ripgrep file discovery."
  :group 'org)

(defcustom rae-directory nil
  "Root folder to scan for active project files.
When nil, fall back to `org-directory'."
  :type '(choice (const :tag "Use `org-directory'" nil) directory)
  :group 'rae)

;; The marker is fixed: a file is active when it carries this file-level
;; keyword.  I match it with ripgrep's default (Rust) regex syntax.
(defconst rae--status-regexp "^#\\+RAE_PROJECT_STATUS:\\s*active"
  "Ripgrep pattern that marks a file as active.")

(defun rae--root ()
  "Return the directory to scan, because callers want it resolved."
  (expand-file-name (or rae-directory org-directory)))

(defun rae-active-files ()
  "Return the active Org files under the scan root.
I shell out to ripgrep, which filters thousands of files down to the
handful that hold active items -- this is the whole speed win."
  (split-string
   (shell-command-to-string
    (format "rg --files-with-matches --no-messages %s %s"
            (shell-quote-argument rae--status-regexp)
            (shell-quote-argument (rae--root))))
   "\n" t))

(defun rae--agenda-files (&rest _)
  "Override `org-agenda-files' with the ripgrep-discovered active files.
Org calls this on every build, so the list stays fresh."
  (rae-active-files))

;;;###autoload
(define-minor-mode rae-mode
  "Make Org agenda build from ripgrep-discovered active files only."
  :global t
  :group 'rae
  (if rae-mode
      (advice-add 'org-agenda-files :override #'rae--agenda-files)
    (advice-remove 'org-agenda-files #'rae--agenda-files)))

;;;###autoload
(defun rae-toggle-project-status ()
  "Flip the current file's `#+RAE_PROJECT_STATUS' between values.
Insert the marker as active when the file has none yet."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    ;; Flip an existing marker, else add one, because the file must end
    ;; up with an explicit status.
    (if (re-search-forward
         "^#\\+RAE_PROJECT_STATUS:\\s-*\\(active\\|inactive\\)" nil t)
        (replace-match
         (if (string= (match-string 1) "active") "inactive" "active")
         t t nil 1)
      (insert "#+RAE_PROJECT_STATUS: active\n"))))

(provide 'rae)
;;; rae.el ends here
