(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(global-set-key (kbd "C-n")
    (lambda () (interactive) (forward-line  8)))
(global-set-key (kbd "C-p")
    (lambda () (interactive) (forward-line -8)))

;; stop annoying indentation behaviour
(when (fboundp 'electric-indent-mode) (electric-indent-mode -1))

;; paste at cursor not mouse position
(setq mouse-yank-at-point t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

;; default to unified diffs
(setq diff-switches "-u")

;; always end a file with a newline
;(setq require-final-newline 'query)

;; default splitting
(setq split-height-threshold nil)
(setq split-width-threshold 0)

;;; uncomment for CJK utf-8 support for non-Asian users
;; (require 'un-define)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
	          (next-win-buffer (window-buffer (next-window)))
		       (this-win-edges (window-edges (selected-window)))
		            (next-win-edges (window-edges (next-window)))
			         (this-win-2nd (not (and (<= (car this-win-edges)
							      (car next-win-edges))
							      (<= (cadr this-win-edges)
								   (cadr next-win-edges)))))
				      (splitter
				             (if (= (car this-win-edges)
						         (car (window-edges (next-window))))
						   'split-window-horizontally
					       'split-window-vertically)))
	(delete-other-windows)
	(let ((first-win (selected-window)))
	    (funcall splitter)
	      (if this-win-2nd (other-window 1))
	        (set-window-buffer (selected-window) this-win-buffer)
		  (set-window-buffer (next-window) next-win-buffer)
		    (select-window first-win)
		      (if this-win-2nd (other-window 1))))))

(define-key ctl-x-4-map "t" 'toggle-window-split)

(add-hook 'emacs-startup-hook 'toggle-window-split)

(define-skeleton fort-sub
  "Inserts a fortran subroutine header."
  ""
  '(setq str (skeleton-read "Subroutine: "))
  '(setq v1  (skeleton-read "Date (DDMMMYY): "))
  '(setq v2  (skeleton-read "Short Description: "))
  '(when (string= str "") (setq str " - "))
  "c" (make-string (- fill-column 2) ?*) "c\n"
  "c" (make-string (- fill-column 2) ?*) "c\n"
  "c" (make-string (- fill-column 2) ?\ ) "c\n" 
  "c" (make-string 5 ?\ ) str " -- " v2 (make-string (- fill-column 11 (length str) (length v2)) ?\ ) "c\n"
  "c" (make-string (- fill-column 2) ?\ ) "c\n"
  "c" (make-string (- fill-column 2) ?*) "c\n"
  "c" (make-string (- fill-column 2) ?\ ) "c\n"
  "c" (make-string 5 ?\ ) "Version history:" (make-string (- fill-column 23) ?\ ) "c\n"
  "c" (make-string 24 ?\ ) "Program created: " v1 (make-string (- fill-column 58) ?\ ) "- raw54 c\n"
  "c" (make-string (- fill-column 2) ?\ ) "c\n"
  "c" (make-string (- fill-column 2) ?*) "c\n"
  "c" (make-string (- fill-column 2) ?\ ) "c\n"
  "c" (make-string 5 ?\ ) "Known issues:" (make-string (- fill-column 20) ?\ ) "c\n"
  "c" (make-string 24 ?\ ) "No known issues." (make-string (- fill-column 50) ?\ ) "- raw54 c\n"
  "c" (make-string (- fill-column 2) ?\ ) "c\n"
  "c" (make-string (- fill-column 2) ?*) "c\n"
  "c" (make-string (- fill-column 2) ?*) "c\n"
  "\n"
      (make-string 6 ?\ ) "subroutine " str "\n"
  "\n"
      (make-string 6 ?\ ) "implicit none\n"
  "\n"
  "c---- Declare variables\n"
  "\n"
      (make-string 6 ?\ ) "integer*4 ::\n"
  "\n"
      (make-string 6 ?\ ) "real*8    ::\n"
  "\n"
  "c---- Return to calling program\n"
  "\n"
      (make-string 6 ?\ ) "return\n"
  "\n"
      (make-string 6 ?\ ) "end subroutine\n" )

(define-skeleton fort-prg
  "Inserts a fortran program header."
  ""
  '(setq str (skeleton-read "Program: "))
  '(setq v1  (skeleton-read "Date (DDMMMYY): "))
  '(setq v2  (skeleton-read "Short Description: "))
  '(when (string= str "") (setq str " - "))
  "c" (make-string (- fill-column 2) ?*) "c\n"
  "c" (make-string (- fill-column 2) ?*) "c\n"
  "c" (make-string (- fill-column 2) ?\ ) "c\n" 
  "c" (make-string 5 ?\ ) str " -- " v2 (make-string (- fill-column 11 (length str) (length v2)) ?\ ) "c\n"
  "c" (make-string (- fill-column 2) ?\ ) "c\n"
  "c" (make-string (- fill-column 2) ?*) "c\n"
  "c" (make-string (- fill-column 2) ?\ ) "c\n"
  "c" (make-string 5 ?\ ) "Version history:" (make-string (- fill-column 23) ?\ ) "c\n"
  "c" (make-string 24 ?\ ) "Program created: " v1 (make-string (- fill-column 58) ?\ ) "- raw54 c\n"
  "c" (make-string (- fill-column 2) ?\ ) "c\n"
  "c" (make-string (- fill-column 2) ?*) "c\n"
  "c" (make-string (- fill-column 2) ?\ ) "c\n"
  "c" (make-string 5 ?\ ) "Known issues:" (make-string (- fill-column 20) ?\ ) "c\n"
  "c" (make-string 24 ?\ ) "No known issues." (make-string (- fill-column 50) ?\ ) "- raw54 c\n"
  "c" (make-string (- fill-column 2) ?\ ) "c\n"
  "c" (make-string (- fill-column 2) ?*) "c\n"
  "c" (make-string (- fill-column 2) ?*) "c\n"
  "\n"
      (make-string 6 ?\ ) "program " str "\n"
  "\n"
      (make-string 6 ?\ ) "implicit none\n"
  "\n"
  "c---- Declare variables\n"
  "\n"
      (make-string 6 ?\ ) "integer*4 ::\n"
  "\n"
      (make-string 6 ?\ ) "real*8    ::\n"
  "\n"
  "c---- Stop and exit cleanly\n"
  "\n"
      (make-string 6 ?\ ) "stop\n"
  "\n"
      (make-string 6 ?\ ) "end program\n" )

(define-skeleton fort-fnc
  "Inserts a fortran function header."
  ""
  '(setq str (skeleton-read "Function: "))
  '(setq v1  (skeleton-read "Date (DDMMMYY): "))
  '(setq v2  (skeleton-read "Short Description: "))
  '(when (string= str "") (setq str " - "))
  "c" (make-string (- fill-column 2) ?*) "c\n"
  "c" (make-string (- fill-column 2) ?*) "c\n"
  "c" (make-string (- fill-column 2) ?\ ) "c\n" 
  "c" (make-string 5 ?\ ) str " -- " v2 (make-string (- fill-column 11 (length str) (length v2)) ?\ ) "c\n"
  "c" (make-string (- fill-column 2) ?\ ) "c\n"
  "c" (make-string (- fill-column 2) ?*) "c\n"
  "c" (make-string (- fill-column 2) ?\ ) "c\n"
  "c" (make-string 5 ?\ ) "Version history:" (make-string (- fill-column 23) ?\ ) "c\n"
  "c" (make-string 24 ?\ ) "Program created: " v1 (make-string (- fill-column 58) ?\ ) "- raw54 c\n"
  "c" (make-string (- fill-column 2) ?\ ) "c\n"
  "c" (make-string (- fill-column 2) ?*) "c\n"
  "c" (make-string (- fill-column 2) ?\ ) "c\n"
  "c" (make-string 5 ?\ ) "Known issues:" (make-string (- fill-column 20) ?\ ) "c\n"
  "c" (make-string 24 ?\ ) "No known issues." (make-string (- fill-column 50) ?\ ) "- raw54 c\n"
  "c" (make-string (- fill-column 2) ?\ ) "c\n"
  "c" (make-string (- fill-column 2) ?*) "c\n"
  "c" (make-string (- fill-column 2) ?*) "c\n"
  "\n"
      (make-string 6 ?\ ) "function " str "\n"
  "\n"
      (make-string 6 ?\ ) "implicit none\n"
  "\n"
  "c---- Declare variables\n"
  "\n"
      (make-string 6 ?\ ) "integer*4 ::\n"
  "\n"
      (make-string 6 ?\ ) "real*8    ::\n"
  "\n"
  "c---- Return to calling program\n"
  "\n"
      (make-string 6 ?\ ) "return\n"
  "\n"
      (make-string 6 ?\ ) "end function\n" )

;; Set up some values for F90 indents
(setq f90-do-indent 3)
(setq f90-if-indent 3)
(setq f90-type-indent 3)
(setq f90-program-indent 3)
(setq f90-continuation-indent 3)
(setq f90-critial-indent 3)
(setq f90-associate-indent 3)
;; (setq f90-smart-indent 'blink)


(define-skeleton f90-sub
  "Inserts a fortran90 subroutine header."
  ""
  '(setq str (skeleton-read "Subroutine: "))
  '(when (string= str "") (setq str " - "))
  >"!" (make-string (- fill-column 3) ?*) "\n"
  >"!" (make-string (- fill-column 3) ?*) "\n"
  >"!\n"
  >"!>  Subroutine " str "()\n"
  >"!\n"
  >"!>  @author\n"
  >"!>  Rob Watson\n"
  >"!>\n"
  >"!>  @brief \n"
  >"!>  \n"
  >"!>  \n"
  >"!>  \n"
  >"!>  @param[in]  \n"
  >"!>  @param[in]  \n"
  >"!>  @param[out] \n"
  >"!>\n"
  >"!" (make-string (- fill-column 3) ?*) "\n"
  >"!" (make-string (- fill-column 3) ?*) "\n"
  "\n"
  >"subroutine " str "()\n"
  "\n"
  >"implicit none\n"
  "\n"
  >"! Declare external variables\n"
  "\n"
  >"integer(kind=WI) ::\n"
  "\n"
  >"real   (kind=WP) ::\n"
  "\n"
  >"! Declare internal variables\n"
  "\n"
  >"integer(kind=WI) ::\n"
  "\n"
  >"real   (kind=WP) ::\n"
  "\n"
  >"! Return to calling program\n"
  "\n"
  >"return\n"
  "\n"
  > (- f90-program-indent) "end subroutine " str "\n"
  "\n"
  >"!" (make-string (- fill-column 3) ?*) "\n"
  >"!" (make-string (- fill-column 3) ?*) "\n" )

(define-skeleton f90-fun
  "Inserts a fortran90 function header."
  ""
  '(setq str (skeleton-read "Function: "))
  '(when (string= str "") (setq str " - "))
  >"!" (make-string (- fill-column 3) ?*) "\n"
  >"!" (make-string (- fill-column 3) ?*) "\n"
  >"!\n"
  >"!>  Function " str "()\n"
  >"!\n"
  >"!>  @author\n"
  >"!>  Rob Watson\n"
  >"!>\n"
  >"!>  @brief \n"
  >"!>  \n"
  >"!>  \n"
  >"!>  \n"
  >"!>  @param[in]  \n"
  >"!>  @param[in]  \n"
  >"!>  @param[out] \n"
  >"!>\n"
  >"!" (make-string (- fill-column 3) ?*) "\n"
  >"!" (make-string (- fill-column 3) ?*) "\n"
  "\n"
  >"function " str "() result()\n"
  "\n"
  >"implicit none\n"
  "\n"
  >"! Declare external variables\n"
  "\n"
  >"integer(kind=WI) ::\n"
  "\n"
  >"real   (kind=WP) ::\n"
  "\n"
  >"! Declare internal variables\n"
  "\n"
  >"integer(kind=WI) ::\n"
  "\n"
  >"real   (kind=WP) ::\n"
  "\n"
  >"! Return to calling program\n"
  "\n"
  >"return\n"
  "\n"
  >(- f90-program-indent) "end function " str "\n"
  "\n"
  >"!" (make-string (- fill-column 3) ?*) "\n"
  >"!" (make-string (- fill-column 3) ?*) "\n")

(define-skeleton f90-prec
  "Inserts a fortran90 precision module."
  ""
  "!" (make-string (- fill-column 2) ?*) "!\n"
  "!" (make-string (- fill-column 2) ?*) "!\n"
  "!" (make-string (- fill-column 2) ?\ ) "!\n" 
  "!" (make-string 3 ?\ ) "precision -- A module to set the precision of variables" (make-string (- fill-column 60) ?\ ) "!\n"
  "!" (make-string (- fill-column 2) ?\ ) "!\n"
  "!" (make-string (- fill-column 2) ?*) "!\n"
  "!" (make-string (- fill-column 2) ?\ ) "!\n"
  "!" (make-string 3 ?\ ) "Version history:" (make-string (- fill-column 21) ?\ ) "!\n"
  "!" (make-string 20 ?\ ) "Program created: 30Oct17                - raw54" (make-string (- fill-column 69) ?\ ) "!\n"
  "!" (make-string 20 ?\ ) "Renamed parameters: 21Nov20             - raw54" (make-string (- fill-column 69) ?\ ) "!\n"
  "!" (make-string 20 ?\ ) "Variables added: 21Nov20                - raw54" (make-string (- fill-column 69) ?\ ) "!\n"
  "!" (make-string (- fill-column 2) ?\ ) "!\n"
  "!" (make-string (- fill-column 2) ?*) "!\n"
  "!" (make-string (- fill-column 2) ?\ ) "!\n"
  "!" (make-string 3 ?\ ) "Known issues:" (make-string (- fill-column 18) ?\ ) "!\n"
  "!" (make-string 20 ?\ ) "No known issues." (make-string (- fill-column 46) ?\ ) "- raw54 !\n"
  "!" (make-string (- fill-column 2) ?\ ) "!\n"
  "!" (make-string (- fill-column 2) ?*) "!\n"
  "!" (make-string (- fill-column 2) ?*) "!\n"
  "!\n"
  "!>  Doxygen Section:\n"
  "!\n"
  "!>  @author\n"
  "!>  Rob Watson\n"
  "!>\n"
  "!>  @brief \n"
  "!>  This module sets up the precision of the calculation and some\n"
  "!>  useful parameters to avoid having to define them regularly.\n"
  "!>\n"
  "!" (make-string (- fill-column 3) ?*) "\n"
  "!" (make-string (- fill-column 3) ?*) "\n"
  "\n"
  "module precision\n"
  "\n"
  >"implicit none\n"
  "\n"
  >"! Declare variables\n"
  "\n"
  >"integer, parameter :: WI = kind(0)\n"
  >"integer, parameter :: WP = kind(0d0)\n"
  >"integer, parameter :: CP = 80\n"
  "\n"
  >"real(kind=WP), parameter :: zero = 0.0_wp\n"
  >"real(kind=WP), parameter :: half = 0.5_wp\n"
  >"real(kind=WP), parameter :: one  = 1.0_wp\n"
  "\n"
  >"real(kind=WP), parameter :: pi  = 4.0_wp * atan(one)\n"
  "\n"
  > (- f90-program-indent) "end module precision\n" 
  "\n"
  >"!" (make-string (- fill-column 2) ?* ) "!\n"
  >"!" (make-string (- fill-column 2) ?* ) "!\n"
  >"!" (make-string (- fill-column 2) ?\ ) "!\n" 
  >"!" (make-string 3 ?\ ) "End of module precision" (make-string (- fill-column 28) ?\ ) "!\n"
  >"!" (make-string (- fill-column 2) ?\ ) "!\n"
  >"!" (make-string (- fill-column 2) ?* ) "!\n"
  >"!" (make-string (- fill-column 2) ?* ) "!\n"
  "\n" )

(define-skeleton f90-mod
  "Inserts a fortran90 module header."
  ""
  '(setq str (skeleton-read "Module: "))
  '(setq v1  (skeleton-read "Date (DDMMMYY): "))
  '(setq v2  (skeleton-read "Short Description: "))
  '(when (string= str "") (setq str " - "))
  "!" (make-string (- fill-column 2) ?*) "!\n"
  "!" (make-string (- fill-column 2) ?*) "!\n"
  "!" (make-string (- fill-column 2) ?\ ) "!\n" 
  "!" (make-string 3 ?\ ) str " -- " v2 (make-string (- fill-column 9 (length str) (length v2)) ?\ ) "!\n"
  "!" (make-string (- fill-column 2) ?\ ) "!\n"
  "!" (make-string (- fill-column 2) ?*) "!\n"
  "!" (make-string (- fill-column 2) ?\ ) "!\n"
  "!" (make-string 3 ?\ ) "Version history:" (make-string (- fill-column 21) ?\ ) "!\n"
  "!" (make-string 20 ?\ ) "Module created: " v1 (make-string (- fill-column 53) ?\ ) "- raw54 !\n"
  "!" (make-string (- fill-column 2) ?\ ) "!\n"
  "!" (make-string (- fill-column 2) ?*) "!\n"
  "!" (make-string (- fill-column 2) ?\ ) "!\n"
  "!" (make-string 3 ?\ ) "Known issues:" (make-string (- fill-column 18) ?\ ) "!\n"
  "!" (make-string 20 ?\ ) "No known issues." (make-string (- fill-column 46) ?\ ) "- raw54 !\n"
  "!" (make-string (- fill-column 2) ?\ ) "!\n"
  "!" (make-string (- fill-column 2) ?*) "!\n"
  "!" (make-string (- fill-column 2) ?*) "!\n"
  "!\n"
  "!>  Doxygen Section:\n"
  "!\n"
  "!>  @author\n"
  "!>  Rob Watson\n"
  "!>\n"
  "!>  @brief \n"
  "!>  \n"
  "!>  \n"
  "!>  \n"
  "!>\n"
  "!" (make-string (- fill-column 3) ?*) "\n"
  "!" (make-string (- fill-column 3) ?*) "\n"
  "\n"
  "module " str "\n"
  "\n"
  >"! Declare modules\n"
  "\n"
  >"use precision\n"
  "\n"
  >"! Turn off implicit typing\n"
  "\n"
  >"implicit none\n"
  "\n"
  >"! Declare module variables\n"
  "\n"
  >"integer(kind=WI) ::\n"
  "\n"
  >"real   (kind=WP) ::\n"
  "\n"
  >"! Set everything private\n"
  "\n"
  >"private"
  >"! Turn on what should be publicly visible\n"
  "\n"
  >"public ::"
  "\n"
  > (- f90-program-indent) "contains\n"
  "\n"
  > (- f90-program-indent) "end module " str "\n" 
  "\n"
  >"!" (make-string (- fill-column 2) ?* ) "!\n"
  >"!" (make-string (- fill-column 2) ?* ) "!\n"
  >"!" (make-string (- fill-column 2) ?\ ) "!\n" 
  >"!" (make-string 3 ?\ ) "End of module " str (make-string (- fill-column 19 (length str) ) ?\ ) "!\n"
  >"!" (make-string (- fill-column 2) ?\ ) "!\n"
  >"!" (make-string (- fill-column 2) ?* ) "!\n"
  >"!" (make-string (- fill-column 2) ?* ) "!\n"
  "\n" )

(define-skeleton f90-prog
  "Inserts a fortran90 program header."
  ""
  '(setq str (skeleton-read "Program: "))
  '(setq v1  (skeleton-read "Date (DDMMMYY): "))
  '(setq v2  (skeleton-read "Short Description: "))
  '(when (string= str "") (setq str " - "))
  "!" (make-string (- fill-column 2) ?*) "!\n"
  "!" (make-string (- fill-column 2) ?*) "!\n"
  "!" (make-string (- fill-column 2) ?\ ) "!\n" 
  "!" (make-string 3 ?\ ) str " -- " v2 (make-string (- fill-column 9 (length str) (length v2)) ?\ ) "!\n"
  "!" (make-string (- fill-column 2) ?\ ) "!\n"
  "!" (make-string (- fill-column 2) ?*) "!\n"
  "!" (make-string (- fill-column 2) ?\ ) "!\n"
  "!" (make-string 3 ?\ ) "Version history:" (make-string (- fill-column 21) ?\ ) "!\n"
  "!" (make-string 20 ?\ ) "Program created: " v1 (make-string (- fill-column 54) ?\ ) "- raw54 !\n"
  "!" (make-string (- fill-column 2) ?\ ) "!\n"
  "!" (make-string (- fill-column 2) ?*) "!\n"
  "!" (make-string (- fill-column 2) ?\ ) "!\n"
  "!" (make-string 3 ?\ ) "Known issues:" (make-string (- fill-column 18) ?\ ) "!\n"
  "!" (make-string 20 ?\ ) "No known issues." (make-string (- fill-column 46) ?\ ) "- raw54 !\n"
  "!" (make-string (- fill-column 2) ?\ ) "!\n"
  "!" (make-string (- fill-column 2) ?*) "!\n"
  "!" (make-string (- fill-column 2) ?*) "!\n"
  "!\n"
  "!>  Doxygen Section:\n"
  "!\n"
  "!>  @author\n"
  "!>  Rob Watson\n"
  "!>\n"
  "!>  @brief \n"
  "!>  \n"
  "!>  \n"
  "!>  \n"
  "!>\n"
  "!" (make-string (- fill-column 3) ?*) "\n"
  "!" (make-string (- fill-column 3) ?*) "\n"
  "\n"
  "program " str "\n"
  "\n"
  >"! Declare modules\n"
  "\n"
  >"use precision\n"
  "\n"
  >"! Turn off implicit typing\n"
  "\n"
  >"implicit none\n"
  "\n"
  >"! Declare program variables\n"
  "\n"
  >"integer(kind=WI) ::\n"
  "\n"
  >"real   (kind=WP) ::\n"
  "\n"
  >"! Stop and exit cleanly\n"
  "\n"
  >"stop\n"
  "\n"
  > (- f90-program-indent) "contains\n"
  "\n"
  > (- f90-program-indent) "end program " str "\n" 
  "\n"
  >"!" (make-string (- fill-column 2) ?* ) "!\n"
  >"!" (make-string (- fill-column 2) ?* ) "!\n"
  >"!" (make-string (- fill-column 2) ?\ ) "!\n" 
  >"!" (make-string 3 ?\ ) "End of program " str (make-string (- fill-column 20 (length str) ) ?\ ) "!\n"
  >"!" (make-string (- fill-column 2) ?\ ) "!\n"
  >"!" (make-string (- fill-column 2) ?* ) "!\n"
  >"!" (make-string (- fill-column 2) ?* ) "!\n"
  "\n" )

(define-skeleton f90-r
  "Inserts a fortran90 real variable declaration."
  >"real   (kind=WP) :: "
)

(define-skeleton f90-ra
  "Inserts a fortran90 real allocatable variable declaration."
  >"real   (kind=WP), allocatable :: "
)

(define-skeleton f90-i
  "Inserts a fortran90 integer variable declaration."
  >"integer(kind=WI) :: "
)

(define-skeleton f90-ia
  "Inserts a fortran90 integer allocatable variable declaration."
  >"integer(kind=WI), allocatable :: "
)

;; add an f08 hook
 (add-to-list 'auto-mode-alist '("\\.f08\\'" . f90-mode))
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; Matlab mode hook
;; Replace path below to be where your matlab.el file is.
;; (add-to-list 'load-path "/home/raw54/bin/MATLAB/Emacs/matlab-emacs-src")
;; (load-library "matlab-load")

;; Enable CEDET feature support for MATLAB code. (Optional)
;; (matlab-cedet-setup)
