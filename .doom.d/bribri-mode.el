;;; bribri-mode.el -*- lexical-binding: t; -*-

;; bribri input method
; ----------------------
;
(defconst low-line #x332) ; U+0332 _
(defconst acute-accent #x301) ; U+0301 /
(defconst grave-accent #x300) ; U+0308 \
(defconst dieresis #x308) ; U+0308 "
(defconst
  map-diacritics '(
                   ("1" `(,acute-accent)) ; tilde /
                   ("2" `(,grave-accent)) ; tilde \
                   ("3" `(,dieresis)) ; dieresis "
                   ("00" `(,low-line)) ; nasal
                   ("01" `(,low-line ,acute-accent)) ; nasal + tilde /
                   ("02" `(,low-line ,grave-accent)) ; nasal + tilde \
                   ("03" `(,low-line ,dieresis)) ; nasal + dieresis "
                   ))
(defconst vowels? '(?a ?e ?i ?o ?u))

(defun vowel-with-number (vowel-char number)
; ?a + "3" => "a3"
  (concat `(,vowel-char) number))
; tests
;(vowel-with-number ?a "3")

(defun vowel-with-diacritics (vowel-char unicode-list)
; ?a + (#x332 #x300) => "á̲"
  (vector (eval `(string ,vowel-char ,@unicode-list)))
  )
; tests
;(vowel-with-diacritics ?a '(#x300 #x332))
;(vowel-with-diacritics ?o '(#x300 #x332))

(defun vowel-tuple (vowel-char number unicode-list)
; ?a + "01" + (#x332 #x300) => ("a01" "à̲")
  `(
    ,(vowel-with-number vowel-char number)
    ,(vowel-with-diacritics vowel-char unicode-list)
    )
  )
; tests
;(vowel-tuple ?a "01" '(#x300 #x332))
;(vowel-tuple ?u "01" '(#x300 #x332))
;(vowel-tuple ?o "01" '(#x300 #x332))
;(vowel-tuple ?i "01" '(#x300 #x332))

(defun vowel-with-diacritics-list (vowel-char)
; ?a + map-diacritics => (("a1" "á") ... ("a01" "á̲") ...)
  (mapcar
   (lambda (tuple) (eval `(vowel-tuple ,vowel-char ,@tuple)))
   map-diacritics)
  )
; tests
;(vowel-with-diacritics-list ?a)
;(vowel-with-diacritics-list ?u)

(defun create-key-translation ()
; vowels + map-diacritics => (("a1" "á") ... ("e1" "é") ...)
    (mapcan 'vowel-with-diacritics-list vowels?)
    )

; test
;(create-key-translation) ; look at messages to see font

(quail-define-package "Bribri diacritics" "Bribri" "BB")
(eval `(quail-define-rules ,@(create-key-translation)))

; whole set:
; "á" "à" "ä" "a̲" "á̲" "à̲" "ä̲"
; "é" "è" "ë" "e̲" "é̲" "è̲" "ë̲"
; "í" "ì" "ï" "i̲" "í̲" "ì̲" "ï̲"
; "ó" "ò" "ö" "o̲" "ó̲" "ò̲" "ö̲"
; "ú" "ù" "ü" "u̲" "ú̲" "ù̲" "ü̲"
