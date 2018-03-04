;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; MACROS
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmacro with-library (symbol &rest body)
  `(condition-case nil
       (progn
         (require ',symbol)
         ,@body)
     
     (error (message (format "I guess we don't have %s available." ',symbol))
            nil)))

;; (defmacro with-library (symbol &rest body)
;;   `(when (require ,symbol nil t)
;;      ,@body))

;; (defmacro with-library (symbol)
;;   (require ,symbol nil t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; GENERAL SETTINGS
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                        
;; Turn on font-lock mode 
(with-library font-lock
              (global-font-lock-mode t))

;; remove toolbar
;; (with-library tool-bar-mode
;;               (tool-bar-mode -1))

(if (> emacs-major-version 20)
    (tool-bar-mode -1))

;; Scroll line by line
(setq scroll-step 1)

;; Always end a file with a newline
(setq require-final-newline t)

;; Stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)

;; use y or n instead of yes or not
(fset 'yes-or-no-p 'y-or-n-p)

;; show column number
(column-number-mode t)

;; Highlight marked region
(transient-mark-mode t)

;; Parenthesis matching
(show-paren-mode 1)

;; Format the title-bar to always include the buffer name
(setq frame-title-format "emacs - %b")

;; Display time
(display-time)

;; flash instead of that annoying bell
;; (setq visible-bell t)
(setq ring-bell-function 'ignore)

;; no tabs for indentation
(setq-default indent-tabs-mode nil)

;; put scrollbar on the right side and disable menu bar
(set-scroll-bar-mode 'right) 
;; (scroll-bar-mode -1)
(menu-bar-mode -1)

;; cua-mode for using standard copy, paste and cut key bindings
(cua-mode 1)

;; identify the machine
(defvar gauss   (equal system-name "gauss"))

;; disable welcome message
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
(setq initial-scratch-message nil) 

;; put backup and auto-save files in /tmp
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/backups" t)))

(add-to-list 'load-path "~/emacs-packages")
(add-to-list 'load-path "~/emacs-packages/cuda-mode")
(add-to-list 'load-path "~/emacs-packages/jdf-mode")
(add-to-list 'load-path "~/emacs-packages/graphviz-dot-mode")
(add-to-list 'custom-theme-load-path "~/emacs-packages/emacs-color-theme-solarized")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; CUSTOM VARIABLES
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; delete region 
(delete-selection-mode t)

;; comment region
(add-hook 'f90-mode-hook
          (lambda () (setq f90-comment-region "!!") ))

(defun comment-line ()
  "Comments the current line."
  (interactive)
  (let (beg end)
    (setq beg (line-beginning-position) end (line-end-position))
    (comment-region beg end)))

(defun uncomment-line ()
  "Uncomments the current line."
  (interactive)
  (let (beg end)
    (setq beg (line-beginning-position) end (line-end-position))
    (uncomment-region beg end)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; KEY BINDINGS
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; fix delete behavior
(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)

;; wheel mouse scroll
(global-set-key (kbd "<mouse-5>") 'sd-mousewheel-scroll-up)
(global-set-key (kbd "<mouse-4>") 'sd-mousewheel-scroll-down)

;; use F1 and F2 to skip between buffers
(global-set-key [f1] 'next-buffer)
(global-set-key [f2] 'previous-buffer)

;;use F3 key to kill buffer
(global-set-key [f3] 'kill-this-buffer)
(global-set-key [(control x) (k)] 'kill-this-buffer)


(global-set-key [f4] 'comment-line)
(global-set-key [f5] 'uncomment-line)
(global-set-key [f6] 'scroll-bar-mode)
(global-set-key [f7] 'xterm-mouse-mode)
(global-set-key [f8] 'menu-bar-mode)

(global-set-key [f9] 'hs-hide-block)
(global-set-key [f10] 'hs-show-block)

(global-set-key [f11] 'upcase-line)
(global-set-key [f12] 'downcase-line)

;; set "home" and "end" keys
(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)

(global-set-key [(control tab)] 'other-window)
(global-set-key [(meta +)] 'enlarge-window)

(global-set-key [(control +)] 'text-scale-increase)
(global-set-key [(control -)] 'text-scale-decrease)

;; comment regionDejaVu
(global-set-key "\C-c;" 'comment-region)
(global-set-key "\C-c:" 'uncomment-region)


;; undo, done in cua-mode!
;; (global-set-key "\C-z" 'undo) ; [Ctrl+z]
;; redo
;; (global-set-key (kbd "C-S-z") 'redo) ; [Ctrl+Shift+z]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; FACES
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun faces_x ()
  ;; these are used when in X
  ;; 
  (custom-set-faces
   '(default ((t (:foreground "white" :background "black" :family "DejaVu Sans Mono"))))
   '(flyspell-duplicate ((t (:foreground "Gold3" :underline t :weight normal))))
   '(flyspell-incorrect ((t (:foreground "OrangeRed" :underline t :weight normal))))
   '(font-lock-comment-face ((t (:italic t :foreground "#5F5A60"))))
   '(font-lock-string-face ((t (:foreground "LightSteelBlue"))))
   '(font-lock-function-name-face ((t (:foreground "gold"))))
   '(font-lock-keyword-face ((t (:foreground "springgreen"))))
   '(font-lock-type-face ((t (:foreground "PaleGreen"))))
   '(font-lock-warning-face ((t (:foreground "Red"))))
   '(font-lock-variable-name-face ((t (:foreground "Coral"))))
   '(region ((t (:background "white" :foreground "black"))))
   '(menu ((((type x-toolkit)) (:background "light slate gray" :foreground "white" :box (:line-width 2 :color "grey75" :style released-button)))))
   '(mode-line ((t (:foreground "black" :background "light slate gray"))))
   '(tool-bar ((((type x w32 mac) (class color)) (:background "midnight blue" :foreground "white" :box (:line-width 1 :style released-button))))))
  (set-cursor-color "deep sky blue")
  (set-foreground-color "white")
  (set-background-color "black")
  (set-face-foreground 'default "white")
  (set-face-background 'default "black")
 )

;; :family "DejaVu Sans Mono"
;; :family "Courier 10 Pitch"

(defun faces_nox ()
  ;; these are used when in terminal
  (custom-set-faces
   ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
   ;; Your init file should contain only one such instance.
   '(default ((t (:foreground "white" :background "black"))))
   '(font-lock-comment-face ((t (:foreground "magenta"))))
   '(font-lock-function-name-face ((t (:foreground "red"))))
   '(font-lock-keyword-face ((t (:foreground "green"))))
   '(font-lock-type-face ((t (:foreground "blue"))))
   '(font-lock-string-face ((t (:foreground "cyan"))))
   '(font-lock-variable-name-face ((t (:foreground "blue"))))
   '(menu ((((type x-toolkit)) (:background "white" :foreground "black" :box (:line-width 2 :color "grey75" :style released-button)))))
   '(modeline ((t (:foreground "blue" :background "white")))))
  (set-cursor-color "blue")
  (set-foreground-color "white")
  (set-background-color "black")
  (set-face-foreground 'default "white")
  (set-face-background 'default "black")
  )


(faces_x)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; MODE HOOKS
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; .inc file are managed in makefile-mode
(setq auto-mode-alist (cons '("\\.inc$" . makefile-mode) auto-mode-alist)) 

;; .F90 file are managed in f90-mode
(setq auto-mode-alist (cons '("\\.F90$" . f90-mode) auto-mode-alist)) 

;; .f03 file are managed in f90-mode
(setq auto-mode-alist (cons '("\\.f03$" . f90-mode) auto-mode-alist)) 

;; .svg file are managed in sgml-mode
(setq auto-mode-alist (cons '("\\.svg$" . sgml-mode) auto-mode-alist)) 

;; .cu file are managed in c++-mode
(setq auto-mode-alist (append '(("\\.cu$" . c++-mode)
                                ("\\.cuh$" . c++-mode)
                                ) auto-mode-alist)) 

;; ;; create a face for function calls in C-mode
(add-hook 'c-mode-hook
          (lambda ()
            (font-lock-add-keywords
             nil
             '(("\\<\\(\\sw+\\) ?(" 1 font-lock-function-name-face)) t))) 

(add-hook 'c-mode-hook
               (lambda ()
                (font-lock-add-keywords nil
                 '(("\\<\\(TODO\\)" 1 font-lock-warning-face t)))))

(add-hook 'c-mode-hook
               (lambda ()
                (font-lock-add-keywords nil
                 '(("\\<\\(FIXME\\)" 1 font-lock-warning-face t)))))

(add-hook 'c-mode-hook
               (lambda ()
                (font-lock-add-keywords nil
                 '(("\\<\\(DEBUG\\)" 1 font-lock-warning-face t)))))

(add-hook 'c-mode-hook
               (lambda ()
                (font-lock-add-keywords nil
                 '(("\\<\\(END DEBUG\\)" 1 font-lock-warning-face t)))))

(add-hook 'c++-mode-hook
          (lambda ()
            (font-lock-add-keywords
             nil
             '(("\\<\\(\\sw+\\) ?(" 1 font-lock-function-name-face)) t))) 

(add-hook 'f90-mode-hook
               (lambda ()
                (font-lock-add-keywords nil
                 '(("\\<\\(TODO\\)" 1 font-lock-warning-face t)))))

(add-hook 'f90-mode-hook
               (lambda ()
                (font-lock-add-keywords nil
                 '(("\\<\\(FIXME\\)" 1 font-lock-warning-face t)))))

(add-hook 'f90-mode-hook
               (lambda ()
                (font-lock-add-keywords nil
                 '(("\\<\\(DEBUG\\)" 1 font-lock-warning-face t)))))

(add-hook 'f90-mode-hook
               (lambda ()
                (font-lock-add-keywords nil
                 '(("\\<\\(END DEBUG\\)" 1 font-lock-warning-face t)))))

(add-hook 'f90-mode-hook
               (lambda ()
                (font-lock-add-keywords nil
                 '(("^\\(#\[a-zA-Z0-9()_ \]*\\)" 1 font-lock-preprocessor-face t)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; CC MODE
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq-default c-basic-offset 3)

;; (defun my-indent-setup ()
;;   (c-set-offset 'arglist-intro '+))

;; (add-hook 'c-mode-common-hook 'my-indent-setup)
(add-hook 'c-mode-common-hook 
          (lambda ()
            (c-set-offset 'arglist-intro '++)))

(add-hook 'c-mode-common-hook 
          (lambda ()
            (c-set-offset 'arglist-close '++)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CUDA MODE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; if cuda-mode is available then use it for cu and cuh extensions
(with-library cuda-mode
              (setq auto-mode-alist (append '(("\\.cu$" . cuda-mode)
                                              ("\\.cuh$" . cuda-mode)
                                              ) auto-mode-alist)))
;; (load-library "cuda-mode")
;; (load-library "derived-mode-ex")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; JDF mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(with-library jdf-mode
              (setq auto-mode-alist (append '(("\\.jdf$" . jdf-mode)
                                              ) auto-mode-alist)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Dot mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(with-library graphviz-dot-mode
              (setq auto-mode-alist (append '(("\\.dot$" . graphviz-dot-mode)
                                              ) auto-mode-alist)))
(custom-set-variables
 '(load-home-init-file t t))
(custom-set-faces)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; solarized theme
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (load-theme 'solarized t)
;; (set-frame-parameter nil 'background-mode 'dark)
;; (enable-theme 'solarized)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(org-babel-do-load-languages
 'org-babel-load-languages '((gnuplot . t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Spell checking
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'latex-mode-hook 'turn-on-flyspell)
(setq ispell-dictionary "en_GB-ize") ;set the default dictionary
