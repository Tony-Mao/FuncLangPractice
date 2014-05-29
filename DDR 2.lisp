(in-package #:ddr-tests)

(defparameter *member-kb*
  '(
    (member ?x (cons ?x ?y))
    (<- (member ?x (cons ?y (cons ?w ?z))) (member ?x (cons ?w ?z)))
    ))

(defparameter *all-different-kb*
  '(
    (-> (different ?w ?x) (different ?x ?w))
    (-> (all-different (cons ?w (cons ?x ?y))) 
        (all-different (cons ?x ?y)) 
        (all-different (cons ?w ?y))
        (different ?w ?x))
    ))