(in-package #:cs325-user)

(defstruct 3tree data left middle right)

(defun 3tree-clone (3tr)
  (if (null 3tr) nil
    (make-3tree :data (3tree-data 3tr)
                :left (3tree-clone (3tree-left 3tr))
                :middle (3tree-clone (3tree-middle 3tr))
                :right (3tree-clone (3tree-right 3tr)))))

(defun 3tree-member (elt 3tr)
  (if (null 3tr) nil
    (or (eql elt (3tree-data 3tr))
        (3tree-member elt (3tree-left 3tr))
        (3tree-member elt (3tree-middle 3tr))
        (3tree-member elt (3tree-right 3tr)))))