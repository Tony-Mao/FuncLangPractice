(in-package #:cs325-user)

(defun my-copy-list (lst)
  (reduce 'cons lst :from-end t :initial-value nil))

(defun my-reverse (lst)
  (reduce 'my-sub-reverse lst :initial-value nil))

(defun my-sub-reverse (lst elt)
  (cons elt lst))

(defun alist->hash-table (lst)
  (let ((ht (make-hash-table)))
    (dolist (sublst lst)
      (setf (gethash (car sublst) ht) 
            (cdr sublst)))
    ht))
      
(defun hash-table->alist (ht)
  (let ((lst nil))
    (maphash #'(lambda (k v)
                 (push (cons k v) lst)) 
             ht)
    lst))