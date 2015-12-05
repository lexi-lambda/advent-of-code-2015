#lang curly-fn racket

(require data/collection
         openssl/md5)

(define ((valid-suffix? min-length) prefix suffix)
  (let ([hash (md5 (open-input-string (string-append prefix suffix)))])
    (equal? (substring hash 0 min-length)
            (sequence->string (take min-length (repeat #\0))))))

(define (lowest-where proc prefix)
  (first (filter #{proc prefix} (map number->string (naturals)))))

(define input (read-line))

; Part I
(lowest-where (valid-suffix? 5) input)

; Part II
(lowest-where (valid-suffix? 6) input)
