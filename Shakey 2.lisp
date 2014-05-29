(in-package #:shakey-tests)

(defparameter *shakey-2-kb*
  '(
    (<- (plan-for (v2-state ?x ?y ?z) (v2-state ?1 ?y ?u) nil))

    (<- (plan-for ?state1 ?goal (cons ?action ?actions))
        (action-for ?state1 ?goal ?action)
        (results ?state1 ?state2 ?action)
        (plan-for ?state2 ?goal ?actions))

    
    (<- (action-for (v2-state hall hall ?unlocked)
                    (v2-state ?1 ?y ?u)
                    (push-box hall ?y))
        (member ?y ?unlocked))
    
    (<- (action-for (v2-state hall hall ?unlocked)
                    (v2-state ?1 ?y ?u)
                    (unlock ?y))
        (not (member ?y ?unlocked)))

    (<- (action-for (v2-state ?x ?x ?unlocked)
                    (v2-state ?1 ?y ?u)
                    (push-box ?x hall))
        (different ?x hall)
        (different ?x ?y))

    (<- (action-for (v2-state hall ?x ?unlocked)
                    (v2-state ?1 ?y ?u)
                    (move-to ?x))
        (different hall ?x)
        (member ?x ?unlocked))

    (<- (action-for (v2-state hall ?x ?unlocked)
                    (v2-state ?1 ?y ?u)
                    (unlock ?x))
        (different hall ?x)
        (not (member ?x ?unlocked)))

    (<- (action-for (v2-state ?x ?y ?unlocked)
                    (v2-state ?1 ?z ?u)
                    (move-to hall))
        (different ?x ?y)
        (different ?y ?z)
        (member ?x ?unlocked))


    (results (v2-state hall hall ?unlocked)
             (v2-state ?y ?y ?unlocked)
             (push-box hall ?y))

    (results (v2-state hall hall ?unlocked)
             (v2-state hall hall (cons ?y ?unlocked))
             (unlock ?y))

    (results (v2-state ?x ?x ?unlocked)
             (v2-state hall hall ?unlocked)
             (push-box ?x hall))

    (results (v2-state hall ?x ?unlocked)
             (v2-state ?x ?x ?unlocked)
             (move-to ?x))

    (results (v2-state hall ?x ?unlocked)
             (v2-state hall ?x (cons ?x ?unlocked))
             (unlock ?x))

    (results (v2-state ?x ?y ?unlocked)
             (v2-state hall ?y ?unlocked)
             (move-to hall))

    (member ?x (cons ?x ?y))
    (<- (member ?x (cons ?y (cons ?w ?z))) (member ?x (cons ?w ?z)))
    
    (-> (all-different (cons ?w (cons ?x ?y))) (different ?w ?x) (different ?x ?w))
    (-> (all-different (cons ?w (cons ?x ?y))) (all-different (cons ?x ?y)) (all-different (cons ?w ?y)))
    
    (all-different (cons room1 (cons room2 (cons room3 (cons hall nil)))))
    ))