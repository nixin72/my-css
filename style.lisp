(defun sym->str (symbol)
  (if (or (typep symbol 'symbol) (typep symbol 'keyword))
      (string-downcase (symbol-name symbol)) symbol))

(defun str+ (&rest str)
  (format nil "~{~a~}" str))

(defun set-rules (styles &optional (css '()))
  (if styles
      (let ((prop (car styles)) (val (cadr styles)))
        (set-rules (cddr styles) (push (str+ (sym->str prop) ": " (sym->str val) ";") css)))
      (car css)
      ))

(defun set-styles (selector styles)
  (let ((selector (sym->str selector)))
    (str+ selector " { " (set-rules styles) " }"))
  )

(defun set-comment (comment)
  (concatenate 'string "/*" comment "*/"))

(defun style (styles &optional (css '()))
  (let ((f (car styles)))
    (if (typep f 'keyword)
        (style (cddr styles) (push (set-styles f (getf styles f)) css))
        (if (typep f 'string)
            (style (cdr styles) (push (set-comment f) css))
            (reverse css)
            ))))

(defvar body-font "\"Segoe UI\", sans-serif")

(print
 (style `(
          :p (:font-family ,body-font)

          "This is a comment string"
          :.flex (:display flex)
          :.fd-r (:flex-direction row)
          ))
 )
