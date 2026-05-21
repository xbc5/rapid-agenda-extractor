;;; rae-mode-test.el --- Tests for the org-agenda-files override -*- lexical-binding: t; -*-

;;; Commentary:
;; With the mode on, `org-agenda-files' must resolve to the discovered files.

;;; Code:

(require 'org)
(require 'rae)

(defvar rae-test-corpus
  (expand-file-name "corpus" (file-name-directory (or load-file-name buffer-file-name)))
  "Directory of sample .org files for the agenda-files test.")

(ert-deftest rae-mode/overrides-agenda-files ()
  "Test that `org-agenda-files' returns only the active files when on."
  (let ((rae-directory rae-test-corpus))
    (unwind-protect
        (progn
          (rae-mode 1)
          (should (equal '("alpha.org" "beta.org" "epsilon.org")
                         (sort (mapcar #'file-name-nondirectory (org-agenda-files))
                               #'string<))))
      (rae-mode -1))))

(ert-deftest rae-mode/restores-on-disable ()
  "Test that disabling the mode removes our override."
  (let ((rae-directory rae-test-corpus)
        (org-agenda-files nil))
    (rae-mode 1)
    (rae-mode -1)
    ;; With the advice gone and no files set, Org reports nothing of ours.
    (should-not (member "alpha.org"
                        (mapcar #'file-name-nondirectory (org-agenda-files))))))

(provide 'rae-mode-test)
;;; rae-mode-test.el ends here
