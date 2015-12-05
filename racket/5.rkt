#lang curly-fn racket

(define strings (port->lines))

(define (count-strings-where pred?)
  (length (filter pred? strings)))

; Part I
(define (nice-string-1? str)
  (and (regexp-match? #px"[aeiou].*[aeiou].*[aeiou]" str)
       (regexp-match? #px"(.)\\1" str)
       (not (regexp-match? #px"ab|cd|pq|xy" str))))

(length (filter nice-string-1? strings))

; Part II
(define (nice-string-2? str)
  (and (regexp-match? #px"(..).*\\1" str)
       (regexp-match? #px"(.).\\1" str)))

(length (filter nice-string-2? strings))
