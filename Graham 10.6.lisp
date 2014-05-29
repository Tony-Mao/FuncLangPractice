(in-package #:cs325-user)

(defmacro preserve (x &rest l)
  `((lambda ,x ,@l) ,@x))