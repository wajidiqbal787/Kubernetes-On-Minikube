package main

import (
    "fmt"
    "net/http"
    "os"
)

func handler(w http.ResponseWriter, r *http.Request) {
    name := os.Getenv("APP_NAME")
    if name == "" {
        name = "Wajid"
    }
    fmt.Fprintf(w, "Hello %s! Your Golang app is running on Kubernetes.", name)
}

func main() {
    http.HandleFunc("/", handler)
    port := os.Getenv("PORT")
    if port == "" {
        port = "8080"
    }
    fmt.Println("Server running on port", port)
    http.ListenAndServe(":"+port, nil)
}
