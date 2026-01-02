(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)

(require `ox-publish)

(setq org-html-validation-link nil            ;; Don't show validation link
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head-include-default-style nil ;; Use our own styles
      org-html-head "<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/spcss@0.9.0'>\n<link rel='stylesheet' href='/site.css'>")

;; Keep publish cache local to avoid permission issues in shared dirs.
(setq org-publish-timestamp-directory "./.org-timestamps/")

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "org-site:main"
             :recursive t
             :base-directory "./content"
             :publishing-function 'org-html-publish-to-html
             :publishing-directory "./public"
             :with-author nil           ;; Don't include author name
             :with-creator t            ;; Include Emacs and Org versions in footer
             :with-toc nil                ;; Include a table of contents
             :section-numbers nil       ;; Don't include section numbers
             :time-stamp-file t)
       (list "org-site:assets"
             :recursive t
             :base-directory "./assets"
             :base-extension "png\\|jpg\\|jpeg\\|gif\\|svg\\|webp"
             :publishing-directory "./public/assets"
             :publishing-function 'org-publish-attachment)))

;; Generate the site output (don't use cache files, regenerate all)
(org-publish-all t)

(message "Build Complete!")
