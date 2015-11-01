; -*- mode: clojure -*-

(require 'boot.repl)

(swap! boot.repl/*default-dependencies* conj
       '[org.clojure/tools.nrepl "0.2.12"]
       '[cider/cider-nrepl "0.10.0-SNAPSHOT"]
       '[refactor-nrepl "1.1.0"])

(swap! boot.repl/*default-middleware* conj
       'cider.nrepl/cider-middleware
       'refactor-nrepl.middleware/wrap-refactor)
