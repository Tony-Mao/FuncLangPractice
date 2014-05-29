(in-package #:cs325-user)

(defun filter (fn lst) 
  (let ((ace nil)) 
    (dolist (x lst)
      (let ((val (funcall fn x))) 
        (if val (push val ace))))
    (nreverse ace))) 

;; I am not sure what does 'in terms of filter' mean, if it means I need to use function 'filter', then my-remove-if is as follows.

(defun my-remove-if (fn lst)
  (filter #'(lambda (x) (and (not (funcall fn x)) x)) lst))

;; If I need to rewrite a function like 'filter', then my-remove-if is as follows. 
;; I was trying to emulate exact same format as 'filter' example

(defun my-remove-if (fn lst)
  (do ((x lst (cdr x))
       (acc nil (if (funcall fn (car x)) 
                    acc 
                  (push (car x) acc))))
      ((null x) (nreverse acc))))

(let ((max nil))
  (defun greatest-arg (&optional (x nil))
    (when (or (null max) (null x) (< max x)) (setf max x)) 
    max))

(let ((buffer nil))
  (defun bigger-arg (&optional (x nil))
    (let ((output (not (or (null x) (null buffer) (>= buffer x)))))
    (setf buffer x)
    output)))

(defun memoize (function)
  (let ((memory nil))
    (lambda (&optional (x nil x-supplied-p))
      (let ((found (assoc x memory :test #'equal)))
        (cond
         ((null x-supplied-p) (setf memory nil))
         (found (cdr found))
         (t (cdar (push (cons x (funcall function x)) memory))))))))