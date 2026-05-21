;;; rae-active-files-test.el --- Tests for rae-active-files -*- lexical-binding: t; -*-

;;; Commentary:
;; Discovery: ripgrep must find exactly the files marked active.

;;; Code:

(require 'rae)

;; Point the scan root at the sample corpus next to this test file.
(defvar rae-test-corpus
  (expand-file-name "corpus" (file-name-directory (or load-file-name buffer-file-name)))
  "Directory of sample .org files for discovery tests.")

(defun rae-test--basenames ()
  "Return discovered files as basenames, because paths are absolute."
  (let ((rae-directory rae-test-corpus))
    (sort (mapcar #'file-name-nondirectory (rae-active-files)) #'string<)))

(ert-deftest rae-active-files/finds-active ()
  "Test that it returns every file marked active, including nested ones."
  (should (equal '("alpha.org" "beta.org" "epsilon.org" "zeta.org")
                 (rae-test--basenames))))

(ert-deftest rae-active-files/finds-drawer-marker ()
  "Test that it finds the marker in a property drawer, not just a keyword."
  (should (member "zeta.org" (rae-test--basenames))))

(ert-deftest rae-active-files/excludes-inactive ()
  "Test that it omits files whose status is inactive."
  (should-not (member "gamma.org" (rae-test--basenames))))

(ert-deftest rae-active-files/excludes-unmarked ()
  "Test that it omits files carrying no status marker."
  (should-not (member "delta.org" (rae-test--basenames))))

(provide 'rae-active-files-test)
;;; rae-active-files-test.el ends here
