(defvar *css* "")

(defun add-class (name &rest props)
  (setf *css* (push (concatenate 'string "." name " { "
      (join (loop for (k v) in props collect (concatenate 'string k ": " v "; ")) "")
    " }" ) *css*)))

(defun join (lst delimiter)
  (let ((str ""))
    (loop for el in list do
      (setf str (concatenate 'string el delimiter)))))

(defun flatten (l)
  (cond ((null l) nil)
        ((atom (car l)) (cons (car l) (flatten (cdr l))))
        (t (append (flatten (car l)) (flatten (cdr l))))))

(defvar sizes '((0 0)
  (1 1)  (2 2)  (3 3)
  (4 5)  (5 8)  (6 12)
  (7 20) (8 32) (9 52)))

(defvar sides '((nil nil)
  ("-top" "t") ("-right" "r")
  ("-bottom" "b") ("-left" "l")))

(defvar properties '(("margin" "m")
  ("padding" "p") ("border" "b")))

(setf *css* (flatten (loop for (prop p) in properties collect
  (loop for (side s) in sides collect
    (loop for (i n) in sizes collect
      (let ((s2 (write-to-string i)) (size (write-to-string n)))
        (concatenate 'string
          "." p s " { " prop side ": " size "; }")))))))

(add-class "flex" ("display" "flex"))

(print *css*)

