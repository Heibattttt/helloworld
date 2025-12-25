# Book Price Tracker Web Scraper

This Python project scrapes book details from [Books to Scrape](https://books.toscrape.com/) and tracks prices. When a book’s price drops below a set threshold, it can send an email notification.

## Features

- Scrape book title and price.
- Save data daily to a CSV file (`booksWebScraperDataset.csv`).
- Automatic email notification if the price is below a defined value.
- Runs daily using a scheduled loop.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/book-price-tracker.git

