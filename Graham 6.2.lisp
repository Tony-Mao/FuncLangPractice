(in-package #:cs325-user)

(defun bin-search (object vector &key (key #'identity) (start 0) (end (length vector)))
  (if (or (<= end start) (> start end))
      nil
    (let* ((mid (floor (+ end start) 2))
           (finder (funcall key (aref vector mid))))
      (cond
       ((eql object finder) (aref vector mid))
       ((< object finder) (bin-search object vector :key key :start start :end mid))
       (t (bin-search object vector :key key :start (1+ mid) :end end))))))