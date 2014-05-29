(in-package #:cs325-user)

(defun shortest-path (start end net)
  (bfs start end (list (list start)) net))

(defun bfs (start end queue net)
  (catch 'abort
    (if (empty-queue-p queue)
        nil
      (let ((path (car queue)))
        (let ((node (car path))) 
          (if (eql node end) (reverse path)
            (bfs start end
                 (append (cdr queue)
                         (new-paths path node start end net))
                 net)))))))

(defun new-paths (path node start end net)
  (let ((next (cdr (assoc node net))))
    (if (eql (car next) start) 
        nil
      (mapcar #'(lambda (n)
                  (cond ((eql n end) (throw 'abort (reverse (cons n path))))
                        (t (cons n path))))
              next))))


;;========================================================================================================

(defun bfs (start end queue net) 
  (if (empty-queue-p queue)
      nil
    (let ((path (car queue)))
      (let ((node (car path))) 
        (if (eql node end) (reverse path)
          (let ((generated-path (new-paths path node start end net)))
            (if (eql end (car generated-path))
                (reverse generated-path)
              (bfs start end
                   (append (cdr queue)
                           generated-path)
                   net))))))))

(defun new-paths (path node start end net)
  (let ((next (cdr (assoc node net))))
    (if (eql (car next) start) 
        nil
      (mapcar #'(lambda (n)
                  (cond ((eql n end) (return-from new-paths (cons n path)))
                        (t (cons n path))))
              next))))