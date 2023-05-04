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
(setq-default show-trailing-whitespace t)
(setq-default indicate-empty-lines t)

;; Set paragraph fill width
(setq-default fill-column 80)

;; Visual Line Mode: better word wrapping
(global-visual-line-mode)

;; Disable menu
(menu-bar-mode -1)

;; Disable scrollbar
(scroll-bar-mode -1)

;; Disable the toolbar
(tool-bar-mode -1)

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


;;
;; Haskell mode
;;
(require 'haskell-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

;; key bindings
(define-key haskell-mode-map (kbd "<f8>") 'haskell-navigate-imports)

;; add ~/.cabal/bin path to a exec path
(let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
  (setenv "PATH" (concat my-cabal-path path-separator (getenv "PATH")))
  (add-to-list 'exec-path my-cabal-path))

;; call hasktags on file save
(custom-set-variables '(haskell-tags-on-save t))


;;
;; Purescript mode
;;
(require 'psc-ide)
(add-hook 'purescript-mode-hook
  (lambda ()
    (psc-ide-mode)
    (company-mode)
    (flycheck-mode)
    (turn-on-purescript-indentation)))
(setq psc-ide-use-npm-bin t)

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
(global-set-key (kbd "C-S-c C-S-c")    'mc/edit-lines)
(global-set-key (kbd "C-c m a")        'mc/mark-all-dwim)
(global-set-key (kbd "C-c m n")      'mc/mark-next-like-this-word)
(global-set-key (kbd "C-c m p")       'mc/mark-previous-like-this-word)
(global-set-key (kbd "C-c m s")  'mc/skip-to-next-like-this)

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

;; Settings created by Emacs' customize

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(completion-ignored-extensions
   '(".cm/" ".o" "~" ".bin" ".lbin" ".so" ".a" ".ln" ".blg" ".bbl" ".elc" ".lof" ".glo" ".idx" ".lot" ".svn/" ".hg/" ".git/" ".bzr/" "CVS/" "_darcs/" "_MTN/" ".fmt" ".tfm" ".class" ".fas" ".lib" ".mem" ".x86f" ".sparcf" ".dfsl" ".pfsl" ".d64fsl" ".p64fsl" ".lx64fsl" ".lx32fsl" ".dx64fsl" ".dx32fsl" ".fx64fsl" ".fx32fsl" ".sx64fsl" ".sx32fsl" ".wx64fsl" ".wx32fsl" ".fasl" ".ufsl" ".fsl" ".dxl" ".lo" ".la" ".gmo" ".mo" ".toc" ".aux" ".cp" ".fn" ".ky" ".pg" ".tp" ".vr" ".cps" ".fns" ".kys" ".pgs" ".tps" ".vrs" ".pyc" ".pyo" ".hi" ".agdai" ".o" ".dyn_o" ".dyn_hi" ".glob" ".v.d" ".vo" ".cmo" ".cmi" ".annot" "fdb_latexmk"))
 '(custom-safe-themes
   '("f5b6be56c9de9fd8bdd42e0c05fecb002dedb8f48a5f00e769370e4517dde0e8" "4c56af497ddf0e30f65a7232a8ee21b3d62a8c332c6b268c81e9ea99b11da0d3" "d89e15a34261019eec9072575d8a924185c27d3da64899905f8548cbd9491a36" "fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c" "833ddce3314a4e28411edf3c6efde468f6f2616fc31e17a62587d6a9255f4633" default))
 '(ispell-dictionary "british")
 '(mark-even-if-inactive t)
 '(package-selected-packages
   '(purescript-mode psc-ide solarized-theme gnu-elpa-keyring-update xcscope window-number undo-tree merlin haskell-mode drag-stuff company-coq auto-complete))
 '(scroll-bar-mode 'right)
 '(show-paren-mode t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((((class color) (min-colors 89)) (:foreground "#839496" :background "#002b36")))))
