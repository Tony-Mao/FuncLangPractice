(in-package #:shakey-tests)

(defparameter *shakey-1-kb*
  '(
    (<- (plan-for (v1-state ?x ?y) (v1-state ?1 ?y) nil))

    (<- (plan-for ?state1 ?goal (cons ?action ?actions))
        (action-for ?state1 ?goal ?action)
        (results ?state1 ?state2 ?action)
        (plan-for ?state2 ?goal ?actions))
))

(defparameter *shakey-1-plan-kb*
  '(
    (results (v1-state ?x ?x) 
             (v1-state hall hall)
             (push-box ?x hall))

    (results (v1-state hall hall) 
             (v1-state ?y ?y)
             (push-box hall ?y))
    
    (results (v1-state ?x ?y)
             (v1-state hall ?y)
             (move-to hall))

    (results (v1-state hall ?y)
             (v1-state ?y ?y)
             (move-to ?y))
    
    (<- (action-for (v1-state hall hall)
                    (v1-state ?1 ?y)
                    (push-box hall ?y)))
   
    (<- (action-for (v1-state ?x ?x)
                    (v1-state ?1 ?y)
                    (push-box ?x hall))
        (different ?x ?y))
    
    (<- (action-for (v1-state hall ?y)
                    (v1-state ?1 ?z)
                    (move-to ?y))
        (different ?y ?z))
    
    (<- (action-for (v1-state ?x ?y)
                    (v1-state ?1 ?z)
                    (move-to hall))
        (different ?x ?y)
        (different ?y ?z))
    ))

(defparameter *all-different-kb*
  '(
    (-> (all-different (cons ?w (cons ?x ?y))) (different ?w ?x) (different ?x ?w))
    (-> (all-different (cons ?w (cons ?x ?y))) (all-different (cons ?x ?y)) (all-different (cons ?w ?y)))
    ))

(defparameter *shakey-1-room-kb*
  '(
    (all-different (cons room1 (cons room2 (cons room3 nil))))
   ))


;;============================== For test ==============================

(defparameter *shakey-1-kb*
  '(
    (<- (plan-for (v1-state ?x ?y) (v1-state ?1 ?y) nil))

    (<- (plan-for ?state1 ?goal (cons ?action ?actions))
        (action-for ?state1 ?goal ?action)
        (results ?state1 ?state2 ?action)
        (plan-for ?state2 ?goal ?actions))

    (results (v1-state ?x ?x) 
             (v1-state hall hall)
             (push-box ?x hall))

    (results (v1-state hall hall) 
             (v1-state ?y ?y)
             (push-box hall ?y))
    
    (results (v1-state ?x ?y)
             (v1-state hall ?y)
             (move-to hall))
    
    (results (v1-state hall ?y)
             (v1-state ?y ?y)
             (move-to ?y))
    
    (<- (action-for (v1-state hall hall)
                    (v1-state ?1 ?y)
                    (push-box hall ?y)))
    
    (<- (action-for (v1-state ?x ?x)
                    (v1-state ?1 ?y)
                    (push-box ?x hall))
        (different ?x ?y))
    
    (<- (action-for (v1-state hall ?y)
                    (v1-state ?1 ?z)
                    (move-to ?y))
        (different ?y ?z))
    
    (<- (action-for (v1-state ?x ?y)
                    (v1-state ?1 ?z)
                    (move-to hall))
        (different ?x ?y)
        (different ?y ?z))
    
    (-> (all-different (cons ?w (cons ?x ?y))) (different ?w ?x) (different ?x ?w))
    (-> (all-different (cons ?w (cons ?x ?y))) (all-different (cons ?x ?y)) (all-different (cons ?w ?y)))
    
    (all-different (cons room1 (cons room2 (cons room3 nil))))
    ))
