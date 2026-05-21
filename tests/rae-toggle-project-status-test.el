;;; rae-toggle-project-status-test.el --- Tests for the toggle command -*- lexical-binding: t; -*-

;;; Commentary:
;; The toggle flips the marker, or inserts one when it is absent.

;;; Code:

(require 'rae)

(defun rae-test--toggle (input)
  "Return INPUT after one toggle, because tests compare buffer text."
  (with-temp-buffer
    (insert input)
    (rae-toggle-project-status)
    (buffer-string)))

(ert-deftest rae-toggle-project-status/active-to-inactive ()
  "Test that it flips an active marker to inactive."
  (should (string-match-p
           "^#\\+RAE_PROJECT_STATUS: inactive$"
           (rae-test--toggle "#+RAE_PROJECT_STATUS: active\n"))))

(ert-deftest rae-toggle-project-status/inactive-to-active ()
  "Test that it flips an inactive marker to active."
  (should (string-match-p
           "^#\\+RAE_PROJECT_STATUS: active$"
           (rae-test--toggle "#+RAE_PROJECT_STATUS: inactive\n"))))

(ert-deftest rae-toggle-project-status/inserts-when-absent ()
  "Test that it adds an active marker to a file that has none."
  (should (string-match-p
           "^#\\+RAE_PROJECT_STATUS: active$"
           (rae-test--toggle "#+TITLE: No marker\n"))))

(provide 'rae-toggle-project-status-test)
;;; rae-toggle-project-status-test.el ends here
