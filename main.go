package main

import (
	"fmt"
	"github.com/gorilla/mux"
	"net/http"
)

func helloHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, World!")
}

func main() {
	r := mux.NewRouter()
	r.HandleFunc("/", helloHandler)
	http.ListenAndServe(":3000", r)
}
