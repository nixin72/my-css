(defun get-styles ())

(defun style (styles)
  (let ((f (car styles)))
    (if (typep f 'keyword) (getf styles f)
    (if (typep f 'string) (generate-comment f)))
  )
)

(defvar body-font "\"Segoe UI\", sans-serif")

(print
  (style `(
    :p (:font ,body-font)

    :.flex (:display flex)
    :.fd-r (:flex-direction row)
  ))
)
