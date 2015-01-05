;;; 初期フレームの設定
(setq initial-frame-alist
      (append
       '((top                 . 22)    ; フレームの Y 位置(ピクセル数)
	 (left                . 80)   ; フレームの X 位置(ピクセル数)
	 (width               . 243)    ; フレーム幅(文字数)
	 (height              . 55))   ; フレーム高(文字数)
       initial-frame-alist))

(set-face-attribute 'default nil
:family "Menlo" ;; font 
:height 105) ;; font size

;; cscopeの設定
(require 'xcscope)

;; C, C++ で共通に使える設定の名前がわかったらaddする
(add-hook 'c-mode-common-hook
	  '(lambda()
	    (c-set-style "GNU")  ;;スタイルはGNU
	    (setq c-basic-offset 4)
        (setq indent-tabs-mode t)
        (setq tab-width 4)
	    (show-paren-mode t)
	    )
)
;; 関数名の表示
(which-function-mode 1)

;; 起動時のメッセージ表示削除
(setq inhibit-startup-message t) 

;;; -- for doxymacs
(require 'doxymacs)
(add-hook 'c-mode-common-hook 'doxymacs-mode) 
(setq doxymacs-doxygen-style "C++") ;; Qt or JavaDoc or C++
(defun my-doxymacs-font-lock-hook ()
  (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
      (doxymacs-font-lock)))
(add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(tab-width 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; C++ mode
(add-hook 'c++-mode-hook '(lambda () (setq tab-width 4))) 

;; cask
(require 'cask "~/.emacs.d/.cask/24.3.1/elpa/cask-20141109.309/cask.el")
(cask-initialize)

;; flycheck load
(add-hook 'after-init-hook #'global-flycheck-mode)

;; flycheck popup
(eval-after-load 'flycheck
  '(custom-set-variables
   '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))

;; flycheck
;;(eval-after-load 'flycheck
;;  '(progn
;;     (require 'flycheck-google-cpplint)
     ;; Add Google C++ Style checker.
     ;; In default, syntax checked by Clang and Cppcheck.
;;     (flycheck-add-next-checker 'c/c++-cppcheck '(warnings-only . c/c++-googlelint))))

;; configuration of cpplint.py
(custom-set-variables
 '(flycheck-c/c++-googlelint-executable "/usr/local/bin/cpplint.py"))

;; configuration of google source check
(custom-set-variables
 '(flycheck-googlelint-verbose "3")
 '(flycheck-googlelint-filter "-whitespace,+whitespace/braces")
 '(flycheck-googlelint-root "project/src")
 '(flycheck-googlelint-linelength "120"))
