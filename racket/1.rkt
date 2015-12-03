#lang curly-fn racket

(require data/collection)

(define str (string->immutable-string (read-line)))

(define/match (char->int n)
  [(#\()  1]
  [(#\)) -1])

(define str->ints #{map char->int})

; Part I
(foldl + 0 (str->ints str))

; Part II
(index-where (foldl/steps + 0 (str->ints str)) negative?)
