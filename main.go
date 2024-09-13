package main

import (
	"fmt"
	"log"
	"net/http"
	"time"

	"github.com/gorilla/mux"
)

// helloHandler writes "Hello, World!" to the response
func helloHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, World!")
}

// loggingMiddleware logs the incoming requests
func loggingMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		start := time.Now()
		log.Printf("Received request: %s %s from %s", r.Method, r.RequestURI, r.RemoteAddr)
		next.ServeHTTP(w, r)
		log.Printf("Request processed in %s\n", time.Since(start))
	})
}

func main() {
	// Initialize router
	r := mux.NewRouter()

	// Add the logging middleware
	r.Use(loggingMiddleware)

	// Define the route and handler
	r.HandleFunc("/", helloHandler)

	// Log that the server is starting
	log.Println("Starting server on :3000")

	// Start the server and listen on port 3000
	if err := http.ListenAndServe(":3000", r); err != nil {
		log.Fatalf("Server failed to start: %v", err)
	}
}
