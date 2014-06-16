(defun solve (p q)
  (solve_rec (/ p q) 1 0))

(defun solve_rec (value offset result)
  (if (> offset 40) 'impossible
    (if (= value (/ 1 (expt 2 offset)))
	(if (= result 0) offset result)
      (if (> value (/ 1 (expt 2 offset)))
	    (solve_rec (- value (/ 1 (expt 2 offset))) (+ offset 1) (if (= result 0) offset result))
	(solve_rec value (+ offset 1) result)))))
