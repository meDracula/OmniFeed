package main

import (
	"context"
	"net/url"

	"omnifeed/pkg/log"
	"omnifeed/pkg/rss"
)

func main() {
	log.Logger.Info("Start")

	uri, err := url.ParseRequestURI("https://go.dev/blog/feed.atom")
	if err != nil {
		log.Logger.Fatal("URL Parse Error", log.String("Error", err.Error()))
	}

	if err := rss.Fetch(context.Background(), &rss.FetchInput{
		URL: uri,
	}); err != nil {
		log.Logger.Fatal("RSS Fetch Error", log.String("Error", err.Error()))
	}

	log.Logger.Info("Done")
}
