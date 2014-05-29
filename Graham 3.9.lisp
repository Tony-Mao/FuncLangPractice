(in-package #:cs325-user)

(defun longest-path (start end net)
  (do ((tlst (cdr (assoc start net)) (cdr tlst))
       (path-saved (if (eql start end) (list start) nil) (longer-path path-saved (generate-path start (car tlst) end net))))
      ((null tlst) path-saved)))

(defun generate-path (start elt end net)
  (cond 
   ((eql elt end) (list start end))
   (t (cond 
       ((null (longest-path elt end (remove (assoc start net) net))) nil)
       (t (cons start (longest-path elt end (remove (assoc start net) net))))))))

(defun longer-path (path1 path2)
  (if (>= (length path1) (length path2)) path1 path2))

(defun is-legal-p (node path)
  (and (not (null path)) (null (member node path))))