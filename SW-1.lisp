(in-package :microdata-tests)

(defun camelize (str &optional (first-cap nil))
  (let ((ostr (remove #\- (string-capitalize str))))
    (if first-cap ostr 
      (string-downcase ostr :end 1))))

(defun hyphenate (str &optional (upper-or-lower :upper))
  (do ((i 0 (1+ i))
       (ostr "" 
             (if (or (= i 0) (not (upper-case-p (aref str i))) (upper-case-p (aref str (1- i))))
                 (concatenate 'string ostr (string (aref str i)))
               (concatenate 'string ostr "-" (string (aref str i))))))
      ((= i (length str)) 
       (if (eql upper-or-lower :upper) 
           (string-upcase ostr)
         (string-downcase ostr)))))

(defun hyphenate (str &optional (upper-or-lower :upper))
  (let ((ostr 
         (with-output-to-string (out)
           (dotimes (i (length str))
             (unless (or (= i 0) (not (upper-case-p (aref str i))) (upper-case-p (aref str (1- i))))
               (format out "-"))
             (format out (string (aref str i)))))))
    (if (eql upper-or-lower :upper) 
        (string-upcase ostr)
      (string-downcase ostr))))