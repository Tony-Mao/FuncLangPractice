(in-package #:ddr-tests)

(defparameter *member-kb*
  '(
    (member ?x (cons ?x ?y))
    (<- (member ?x (cons ?y (cons ?w ?z))) (member ?x (cons ?w ?z)))
    ))
