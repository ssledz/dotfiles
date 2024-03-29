(require 'package)
(add-to-list 'package-archives
             '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(package-initialize)

;; Load path
(add-to-list 'load-path "~/.emacs.d/elpa/")
(add-to-list 'load-path "~/.emacs.d/other-exts")

;; move all config done by customize interface to seperate file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Emacs settings
(setq make-backup-files         nil) ; Don't want any backup files
(setq auto-save-list-file-name  nil) ; Don't want any .saves files
(electric-indent-mode           0  ) ; No fancy indentation

;; Type "y"/"n" instead of "yes"/"no"
(fset 'yes-or-no-p 'y-or-n-p)

;; C-k kills whole line and newline if at beginning of line
(setq kill-whole-line t)

;; Use 2 spaces instead of tab
(setq-default tab-width 2)

;; Disable tabs for indentation
(setq-default indent-tabs-mode nil)

;; Highlight trailing whitespaces
(defun set-show-trailing-whitespce ()
  (setq show-trailing-whitespace t)
  (setq indicate-empty-lines t))

;; Set paragraph fill width
(setq-default fill-column 80)

;; Visual Line Mode: better word wrapping
(global-visual-line-mode)

;; Disable menu
(menu-bar-mode -1)

;; Disable scrollbar
(scroll-bar-mode -1)

(setq-default vertical-scroll-bar nil)

;; Show window divider
(window-divider-mode)

;; Disable the toolbar
(tool-bar-mode -1)

;; Insert a new line and jump to it
(global-set-key (kbd "S-<return>") (kbd "C-e C-m"))

;; Upcase or doncase region
(global-set-key (kbd "C-c C-u") 'upcase-region)
(global-set-key (kbd "C-c C-l") 'downcase-region)

;; Duplicating a line
(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  ;(open-line 1)
  (previous-line 1)
  (yank)
)
(global-set-key (kbd "C-c C-d") 'duplicate-line)

;; Disable Change Log mode
(setq auto-mode-alist (rassq-delete-all 'change-log-mode auto-mode-alist))

;; Comment or uncomment region or current line
(defun comment-or-uncomment-region-or-line ()
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)))
(global-set-key (kbd "M-;") 'comment-or-uncomment-region-or-line)

;; Highlight text beyond 80th column
(require 'whitespace)
(setq whitespace-style '(face lines-tail))
(setq whitespace-line-column 80)
(global-whitespace-mode t)

;; Highlight current line
(global-hl-line-mode 1)

;; Delete selected region with a keypress
(delete-selection-mode 1)

;; Always horizontal split
(setq split-width-threshold nil)
(setq split-height-threshold 0)

;; Toggle line number display
(global-set-key (kbd "<f11>") 'global-linum-mode)

;; Always display column number
(column-number-mode 1)

;; Highlight matching brackets
(show-paren-mode t)
(setq show-paren-delay 0)

;; Unique buffer names
(require 'uniquify)

;; Ido mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; Undo tree
(require 'undo-tree)
(global-undo-tree-mode)

;; drag-stuff
(require 'drag-stuff)
(drag-stuff-global-mode t)
(global-set-key [C-up]    'drag-stuff-up   )
(global-set-key [C-down]  'drag-stuff-down )
;(global-set-key [C-left]  'drag-stuff-left )
;(global-set-key [C-right] 'drag-stuff-right)

;; NumberedWindows: switch windows with Alt-<number>
(require 'window-number)
(window-number-mode)
(window-number-meta-mode)

;; Shrinking / enlarge windows
(global-set-key (kbd "M-s-<left>")  'shrink-window-horizontally)
(global-set-key (kbd "M-s-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-s-<down>")  'shrink-window)
(global-set-key (kbd "M-s-<up>")    'enlarge-window)

;; Company complete global binding
(global-set-key (kbd "M-RET") 'company-complete)

;; Show full path name in minibuffer
(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))

(global-set-key [C-f1] 'show-file-name)


;;
;; Multi Occur
;;
;; https://www.masteringemacs.org/article/searching-buffers-occur-mode
;;
(defun get-buffers-matching-mode (mode)
  "Returns a list of buffers where their major-mode is equal to MODE"
  (let ((buffer-mode-matches '()))
    (dolist (buf (buffer-list))
      (with-current-buffer buf
        (when (eq mode major-mode)
          (push buf buffer-mode-matches))))
    buffer-mode-matches))

(defun multi-occur-in-this-mode ()
  "Show all lines matching REGEXP in buffers with this major mode."
  (interactive)
  (multi-occur
   (get-buffers-matching-mode major-mode)
   (car (occur-read-primary-args))))

;; global key for `multi-occur-in-this-mode' - you should change this.
(global-set-key (kbd "C-o") 'multi-occur-in-this-mode)


;;
;; Haskell mode
;;
(require 'haskell-mode)
(require 'haskell-interactive-mode)
(require 'haskell-process)

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'flycheck-mode)
(add-hook 'haskell-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends)
                 (append '((company-capf company-dabbrev-code))
                         company-backends))))
(add-hook 'haskell-mode-hook 'company-mode)
(add-hook 'haskell-mode-hook 'haskell-auto-insert-module-template)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook 'set-show-trailing-whitespce)

;; key bindings
(define-key haskell-mode-map (kbd "<f8>") 'haskell-navigate-imports)
(define-key haskell-mode-map (kbd "M-.") 'haskell-mode-jump-to-def-or-tag)
(define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
(define-key haskell-mode-map (kbd "C-`") 'haskell-interactive-bring)
(define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
(define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
(define-key haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
(define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)

;; interactive repl to separate frame
(defun create-unfocused-frame ()
  (let*
    ((prv (window-frame))
     (created (make-frame)))
    (select-frame-set-input-focus prv) created))

(defun haskell-create-interactive-frame ()
  (interactive)
  (haskell-interactive-bring)
  (create-unfocused-frame)
  (delete-window))

;; add ~/.cabal/bin path to a exec path
(let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
  (setenv "PATH" (concat my-cabal-path path-separator (getenv "PATH")))
  (add-to-list 'exec-path my-cabal-path))

;; call hasktags on file save
;;(custom-set-variables '(haskell-tags-on-save t))

(custom-set-variables
  '(haskell-process-suggest-remove-import-lines t)
  '(haskell-process-auto-import-loaded-modules t)
  '(haskell-process-log t))

;;
;; Purescript mode
;;
(require 'psc-ide)
(add-hook 'purescript-mode-hook
          (lambda ()
            (psc-ide-mode)
            (psc-set-company-backends)
            (company-mode)
            (flycheck-mode)
            (set-show-trailing-whitespce)
            (turn-on-purescript-indentation)))
(setq psc-ide-use-npm-bin t)

(defun psc-set-company-backends ()
  (set (make-local-variable 'company-backends)
       (append '((company-psc-ide-backend
                  company-dabbrev-code
                  company-etags))
               company-backends)))


(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))

(global-set-key [C-f1] 'show-file-name) ; Or any other key you want

;; Cycle buffer - use F9/F10 to switch buffers
(autoload 'cycle-buffer                     "cycle-buffer" "Cycle forward." t)
(autoload 'cycle-buffer-backward            "cycle-buffer" "Cycle backward." t)
(autoload 'cycle-buffer-permissive          "cycle-buffer" "Cycle forward allowing *buffers*." t)
(autoload 'cycle-buffer-backward-permissive "cycle-buffer" "Cycle backward allowing *buffers*." t)
(autoload 'cycle-buffer-toggle-interesting  "cycle-buffer" "Toggle if this buffer will be considered." t)
(global-set-key [(f9)]        'cycle-buffer-backward)
(global-set-key [(f10)]       'cycle-buffer)
(global-set-key [(shift f9)]  'cycle-buffer-backward-permissive)
(global-set-key [(shift f10)] 'cycle-buffer-permissive)

;; Spellchecking
(global-set-key (kbd "<f6>") 'flyspell-mode)
(global-set-key (kbd "C-<f6>") 'flyspell-prog-mode)
(global-set-key (kbd "<f7>") 'flyspell-buffer)
(global-set-key (kbd "C-<f7>") 'ispell-word)

;; expand region
(require 'expand-region)
(global-set-key (kbd "C-=")    'er/expand-region)

;; multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c")  'mc/edit-lines)
(global-set-key (kbd "C-c m a")      'mc/mark-all-dwim)
(global-set-key (kbd "C-c m n")      'mc/mark-next-like-this-word)
(global-set-key (kbd "C-c m p")      'mc/mark-previous-like-this-word)
(global-set-key (kbd "C-c m s")      'mc/skip-to-next-like-this)

;; narrow to region
;; works great with multi cursors
;; c-x n n - narrow
;; c-x n w - widen

;; Git syntax highlighting
(require 'git-commit)

;; No splash screen
(setf inhibit-splash-screen t)

;; Remove header from grep output. Taken from:
;; http://stackoverflow.com/questions/16122801/remove-header-information-from-rgrep-grep-output-in-emacs
(defun delete-grep-header ()
  (save-excursion
    (with-current-buffer grep-last-buffer
      (goto-line 5)
      (narrow-to-region (point) (point-max)))))
(defadvice grep  (after delete-grep-header activate) (delete-grep-header))
(defadvice rgrep (after delete-grep-header activate) (delete-grep-header))

(if window-system
  (load-theme 'solarized-dark t)
  (progn
    (setq linum-format "%4d \u2502 ")))

;; Font config
(set-face-attribute 'default nil
                    :font "FiraCode"
                    :family "Fira Code"
                    :foundry "CTDB"
                    :height 158
                    :slant 'normal
                    :weight 'normal
                    :width 'normal)

(set-frame-font "FiraCode" nil t)
(set-face-background hl-line-face "gray13")


(put 'downcase-region 'disabled nil)
(put 'company-coq-fold 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)

;;
;;
;;
;;   | Key            | Function                              |
;;   |----------------+---------------------------------------|
;;   | C-c C-s        | psc-ide-server-start                  |
;;   | C-c C-q        | psc-ide-server-quit                   |
;;   | C-c C-t        | psc-ide-show-type                     |
;;   | C-c C-i        | psc-ide-add-import                    |
;;   | C-c C-a        | psc-ide-add-clause                    |
;;   | C-c C-c        | psc-ide-case-split                    |
;;   | C-c C-l        | psc-ide-load-all                      |
;;   | C-c C-b        | psc-ide-rebuild                       |
;;   | C-c C-S-l      | psc-ide-load-module                   |
;;   | C-c M-s        | psc-ide-flycheck-insert-suggestion    |
;;   |                |                                       |
;;   | C-up           | drag-stuff-up                         |
;;   | C-down         | drag-stuff-down                       |
;;   |                |                                       |
;;   | C-S-c C-S-c    | mc/edit-lines                         |
;;   | C-c m a        | mc/mark-all-dwim                      |
;;   | C-c m n        | mc/mark-next-like-this-word           |
;;   | C-c m p        | mc/mark-previous-like-this-word       |
;;   | C-c m s        | mc/skip-to-next-like-this             |
;;   |                |                                       |
;;   | C-=            | er/expand-region                      |
;;   |                |                                       |
;;   | c-x n n        | narrow to region                      |
;;   | c-x n w        | widen region                          |
;;   |                |                                       |
;;   | <f8>           | haskell-navigate-imports              |
;;   |                |                                       |
;;   | <f11>          | global-linum-mode                     |
;;   | C-c C-d        | duplicate-line                        |
;;   | S-<return      | jump next line                        |
;;   | C-c C-u        | upcase-region                         |
;;   | C-c C-l        | downcase-region                       |
;;   | M-;            | comment-or-uncomment-region-or-line   |
;;   | C-RET          | company-complete                      |
;;   | [C-f1]         | show-file-name                        |
;;   |                |                                       |
;;   | [(f9)]         | cycle-buffer-backward                 |
;;   | [(f10)]        | cycle-buffer                          |
;;   | [(shift f9)]   | cycle-buffer-backward-permissive      |
;;   | [(shift f10)]  | cycle-buffer-permissive               |
;;   |                |                                       |
;;   | C-x g          | magit                                 |
;;   |                |                                       |
;;   | M-g g          | goto-line                             |
;;   | M-s o          | occur                                 |
;;   | M-g M-n        | occur next                            |
;;   | M-g M-p        | occur prev                            |
;;   | C-o            | multi occur                           |

