#lang curly-fn racket

(require data/collection
         lens
         point-free)

(struct/lens state (x y visited))

(define (step state direction)
  (~> state
      (case direction
        [(#\>) #{lens-transform state-x-lens % add1}]
        [(#\<) #{lens-transform state-x-lens % sub1}]
        [(#\^) #{lens-transform state-y-lens % add1}]
        [(#\v) #{lens-transform state-y-lens % sub1}])
      visit-current-location))

(define (visit-current-location state)
  (lens-transform state-visited-lens state
                  #{set-add % (cons (state-x state)
                                    (state-y state))}))

(define (run-simulation directions)
  (state-visited (foldl step initial-state directions)))

(define initial-state (visit-current-location (state 0 0 (set))))

(define directions (string->immutable-string (read-line)))

; Part I
(length (run-simulation directions))

; Part II
(let* ([direction-pairs (chunk* 2 directions)]
       [first-results (run-simulation (map first direction-pairs))]
       [second-results (run-simulation (map second direction-pairs))])
  (length (set-union first-results second-results)))
