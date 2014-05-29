(in-package #:cs325-user)

(defun print-2d-array (arr)
  (let ((size (array-dimensions arr)))
    (dotimes (i (car size))
      (dotimes (j (cadr size))
        (format t "          ~,2f" (aref arr i j)))
      (format t "~%"))))

