#lang racket

(require (rename-in racket/match [match-let* let*])
         data/collection
         point-free)

(define (package-description->dimensions description)
  (map string->number (string-split description "x")))

(define (calculate-package-metric metric-calculator packages)
  (foldl + 0 (map (λ~> package-description->dimensions
                       metric-calculator)
                  packages)))

(define packages (port->lines))

; Part I
(define (paper-for-package package-dimensions)
  (let* ([(sequence w h l) package-dimensions]
         [surfaces (list (* w h) (* w l) (* h l))]
         [primary (* 2 (apply + surfaces))]
         [slack (apply min surfaces)])
    (+ primary slack)))

(calculate-package-metric paper-for-package packages)

; Part II
(define (ribbon-for-package package-dimensions)
  (let* ([(list x y z) (sort (sequence->list package-dimensions) <)]
         [perimeter (+ x x y y)]
         [volume (* x y z)])
    (+ perimeter volume)))

(calculate-package-metric ribbon-for-package packages)
