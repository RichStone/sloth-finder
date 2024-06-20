# Sloth Finder

Scrape and search Ruby weekly. And maybe more someday. Slowly but steadily. 

<div align="center">
  <kbd>
    <img width=400 src="https://slothfinder.apishop.io/assets/rich-sloth-f6511538d4d280f6ecf9f666c4034bdedc54c308fcc487d76cca81e67f251207.png" />
  </kbd>
</div>

### Built on

- Ruby on Rails
- SQLite
- render.com
- Sloth drive

## Getting started

### Prerequisites

- Ruby 3 installed.

### Install

```bash
$ git clone git@github.com:RichStone/sloth-finder.git
$ cd sloth-finder
$ bundle
$ rails db:create db:migrate
```

### Usage

Adapt the primitive scraper to your needs, adjust the scraping algorithm in finder.rb and scrape simply structured websites:

```bash
$ BASE_URL=https://rubyweekly.com/issues FROM=704 TO=708 rake scraper:run
```

Serve the site to visualize results:

```bash
$ bin/rails server
```

## Back matter

### Legal disclaimer

Please use the scraper with care and add sensible delays between requests. Only publish 3rd party content or parts of it in agreement with the parties and referencing them clearly. 

### Acknowledgements

Thanks to [Peter Cooper](https://x.com/cooperx86) for the amazing weekly Ruby content. 

### Someday maybe

- [ ] Make the search lightning fast (might be overkill, but [this](https://blog.testdouble.com/posts/2021-09-09-how-to-build-a-search-engine-with-ruby-on-rails/) could be a start.
- [ ] Move to Kamal 2 and Rails 8.
- [ ] AI search for concepts, e.g. "find all articles about design patterns in Ruby". 

### License

This project is licensed under the [MIT License](LICENSE.md).
