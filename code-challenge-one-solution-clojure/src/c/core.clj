(ns c.core
    (:gen-class))

(def const 75000)

(def f "(ns c.core) (def f %c%s%c) (def -main [& args] (for [x (range l u)] (spit (str x) (format f (char 34) f (char 34)))))))))")

(defn t [l u] (for [x (range l u)] (spit (str x) (format f (char 34) f (char 34)))))

(defn -main [& args]
    (let [a (future (t (* const 0) (* const 1)))
          b (future (t (* const 1) (* const 2)))
          c (future (t (* const 2) (* const 3)))
          d (future (t (* const 3) (* const 4)))
          e (future (t (* const 4) (* const 5)))
          f (future (t (* const 5) (* const 6)))
          g (future (t (* const 6) (* const 7)))
          h (future (t (* const 7) (* const 8)))
          i (future (t (* const 8) (* const 9)))
          j (future (t (* const 9) (* const 10)))]
    (conj @a @b @c @d @e @f @g @h @i @j)))