(in-package #:cs325-user)

(defclass point ()
  ((x :accessor x
      :initarg :x
      :initform 0)
   (y :accessor y
      :initarg :y
      :initform 0)
   (z :accessor z
      :initarg :z
      :initform 0)))

(defclass surface ()
  ((color  :accessor surface-color
           :initarg :color)))

(defclass sphere (surface)
  ((radius :accessor sphere-radius
           :initarg :radius
           :initform 0)
   (center :accessor sphere-center
           :initarg :center
           :initform (make-instance 'point :x 0 :y 0 :z 0))))

(defun defsphere (x y z r c)
  (let ((s (make-instance  'sphere
                           :radius r
                           :center (make-instance 'point :x x :y y :z z)
                           :color c)))
    (push s *world*)
    s))

(defmethod intersect ((s sphere) (p point) xr yr zr)
  (let* ((c (sphere-center s))
         (n (minroot (+ (sq xr) (sq yr) (sq zr))
                     (* 2 (+ (* (- (x p) (x c)) xr)
                             (* (- (y p) (y c)) yr)
                             (* (- (z p) (z c)) zr)))
                     (+ (sq (- (x p) (x c)))
                        (sq (- (y p) (y c)))
                        (sq (- (z p) (z c)))
                        (- (sq (sphere-radius s)))))))
    (if n
        (make-instance 'point
                        :x  (+ (x p) (* n xr))
                        :y  (+ (y p) (* n yr))
                        :z  (+ (z p) (* n zr))))))

(defmethod normal ((s sphere) (p point))
  (let ((c (sphere-center s)))
    (unit-vector (- (x c) (x p))
                 (- (y c) (y p))
                 (- (z c) (z p)))))