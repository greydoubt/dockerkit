;; route for rendering a post
(weblorg-route
 :name "posts"
 :input-pattern "posts/*.org"
 :template "post.html"
 :output "output/posts/{{ slug }}.html"
 :url "/posts/{{ slug }}.html")

;; route for rendering the index page
(weblorg-route
 :name "blog"
 :input-pattern "posts/*.org"
 :input-aggregate #'weblorg-input-aggregate-all-desc
 :template "blog.html"
 :output "output/index.html"
 :url "/")

;; route for static assets that also copies files to output directory
(weblorg-copy-static
 :output "static/{{ file }}"
 :url "/static/{{ file }}")

;; init the engine and export all the files declared
;; and de facto exposed in routes above
(weblorg-export)
