(in-package #:cs325-user)

(defun stable-union (l1 l2)
  (do ((tlst l2 (cdr tlst))
       (lst (reverse l1) (cond
                          ((member (car tlst) l1) lst)
                          (t (cons (car tlst) lst)))))
      ((null tlst) (reverse lst))))

(defun stable-intersection (l1 l2)
  (do ((tlst l1 (cdr tlst))
       (lst nil (cond
		 ((find (car tlst) l2) (cons (car tlst) lst))
                 (t lst))))
      ((null tlst) (reverse lst))))

(defun stable-set-difference (l1 l2)
  (do ((tlst l1 (cdr tlst))
       (lst nil (cond
		 ((find (car tlst) l2) lst)
                 (t (cons (car tlst) lst)))))
      ((null tlst) (reverse lst))))

(defun stable-union (l1 l2)
  (let ((tl1 (reverse l1)))
    (dolist (tl2 l2)
      (or (member tl2 tl1)
          (push tl2 tl1)))
    (reverse tl1)))

(defun stable-union (l1 l2)
  (nreverse (union (nreverse l1) (stable-set-difference l2 l1))))
