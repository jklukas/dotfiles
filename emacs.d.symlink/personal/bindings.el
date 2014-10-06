;; Disable mouse wheel (and two finger swipe) scrolling

(mouse-wheel-mode -1)

(global-set-key [wheel-up] 'ignore)
(global-set-key [wheel-down] 'ignore)
(global-set-key [double-wheel-up] 'ignore)
(global-set-key [double-wheel-down] 'ignore)
(global-set-key [triple-wheel-up] 'ignore)
(global-set-key [triple-wheel-down] 'ignore)

;; Disable some Prelude-defined key chords
(key-chord-define-global "jk" nil)

;; Custom global key bindings

(global-set-key "\C-c#" 'comment-region)
