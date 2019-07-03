package main

import (
   "fmt"
   "log"
   "net/http"
)

func homeHandler(w http.ResponseWriter, r *http.Request) {
   fmt.Fprintf(w, "Hello World!")
}

func main() {
   http.HandleFunc("/", homeHandler)

   log.Fatal(http.ListenAndServe(":8080", nil))
}
