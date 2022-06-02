class CLI
    def initialize
        Scraper.new.scrape_electorates
    end

    def start
        puts ""
        puts "Welcome to the Australian Federal Election 2022 Results Tracker"
        puts ""

    end

    def print_electorate electorate
        system("clear")
        puts "=================================="
        puts "Division of #{electorate.division} in #{electorate.state}."
        puts "=================================="
        puts "Previously held by: #{electorate.incumbent}. Leading party: #{electorate.leading} by a margin of #{electorate.margin} votes. Two-party-preferred: #{electorate.tcp}% with a swing of #{electorate.swing}%."
        puts ""
    end

    def list_electorates

    end

    def list_electorates_by_state

    end

    
end
