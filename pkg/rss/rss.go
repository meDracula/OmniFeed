package rss

import (
	"context"
	"fmt"
	"net/url"

	"github.com/mmcdole/gofeed"
)

type FetchInput struct {
	URL *url.URL
}

func Fetch(ctx context.Context, input *FetchInput) error {
	fp := gofeed.NewParser()

	feed, err := fp.ParseURLWithContext(input.URL.String(), ctx)
	if err != nil {
		return err
	}
	fmt.Println("FEED:", feed)
	return nil
}
