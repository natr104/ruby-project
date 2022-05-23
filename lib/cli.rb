class CLI
    def initialize
        Scraper.new.scrape_electorates
    end

    def start
        puts "Welcome to the Australian Federal Election 2022 Results Tracker"
        puts ""
    end

end
