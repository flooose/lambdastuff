;;(setq lexical-binding t)

(defun fact (n)
  (if (equal n 0)
      1
    (* n (fact (- n 1)))))
(fact 4)
(defun factgen (f)
  (lambda (n)
    (if (equal n 0)
        1
      (* n (funcall f (- n 1))))))
(funcall (factgen 'fact) 4)

;; factorial_gen = f => (n => ((n === 0) ? 1 : n * f(n -1)))

;; factorial_wei = f => (n => ((n === 0) ? 1 : n * f(f)(n-1)))

(defun factgen2 (f)
  (lambda (n)
    (if (equal n 0)
        1
      (* n (funcall (funcall f f) (- n 1))))))
(funcall (factgen2 'factgen2) 4)

;; (closure ((f . factgen2) t) (n) (if (equal n 0) 1 (* n (funcall (funcall f f) (- n 1)))))
;; factorial_wei = f => (n => ((n === 0) ? 1 : n * f(f)(n - 1)))
;; factorial_nos = (f => (n => ((n === 0) ? 1 : n * f(f)(n - 1))))
                ;;((f => (n => ((n === 0) ? 1 : n * f(f)(n - 1)))))

(funcall (funcall (lambda (f)
           (lambda (n)
             (if (equal n 0)
                 1
               (* n (funcall (funcall f f) (- n 1))))))
         (lambda (f) (lambda (n)
           (if (equal n 0)
               1
             (* n (funcall (funcall f f) (- n 1))))))) 4)

;; Y = f => (x => x(x))(x => f(y => x(x)(y)))

(defun Y (f)
  (funcall (lambda (x)
             (funcall x x))
           (lambda (x)
             (funcall f (lambda (y)
                          (funcall (funcall x x) y))))))

(funcall (lambda (x)
           (funcall f (lambda (y)
                        (funcall (funcall x x) y))))
         (lambda (x)
           (funcall f (lambda (y)
                        (funcall (funcall x x) y)))))

;; factorial_gen = f => (n => ((n === 0) ? 1 : n * f(n - 1)))
(defun factgen (f)
  (lambda (n)
    (if (equal 0 n)
        1
      (* n (funcall f (- n 1))))))

(funcall (Y 'factgen) 4)

(funcall (factgen 'fact) 4)
(factgen2 'factgen2)
(funcall (factgen2 'factgen2) 6)

(funcall (factgen 'fact) 10)

(let ((a 2)
  (b 3))
  (+ a b))


factorial_gen = f => (n => ((n === 0) ? 1 : n * f(n - 1)))

factorial_wei = f => (n => ((n === 0) ? 1 : n * f(f)(n - 1)))

;;;;;;;;

(defun almost-factorial (f)
  (lambda (n)
    (if (= n 0)
        1
      (* n (funcall f (- n 1))))))

(defun identity (x) x)
(setq factorial0 (almost-factorial 'identity))
(funcall factorial0 2)
(setq factorial1 (almost-factorial (almost-factorial 'identity)))
(funcall factorial1 0)

(setq blub (lambda (n)
  (if (= n 0)
      1
    2)))
(setq x #'blub )
(x 2)
