require_relative "./scraper.rb"

class CLI

    def initialize
        Scraper.new.scrape_electorates
    end

    def start
        puts ""
        puts "================================================================"
        puts "Welcome to the Australian Federal Election 2022 Results Tracker"
        puts "================================================================"
        puts ""
        puts "Please choose from the options below:"
        puts ""
        puts "1. Show all electorates."
        puts "2. Show electorates from a specific state or territory."
        input = gets.strip.to_i

        if input == 1
            all_electorates
        elsif input == 2
            state_electorates
        else 
            puts ""
            puts "Please select an option."
            start
        end
    end

    def print_electorate electorate
        system("clear")
        puts "=================================="
        puts "Division of #{electorate.division} in #{electorate.state}."
        puts "=================================="
        puts "Previously held by: #{electorate.incumbent}. Leading party: #{electorate.leading} by a margin of #{electorate.margin} votes. Two-party-preferred: #{electorate.tcp}% with a swing of #{electorate.swing}%."
        puts ""
    end

    def print_candidates electorate
        electorate.get_candidates
        system("clear")
        puts "=================================="
        puts "Candidates for #{electorate.division} in #{electorate.state}:"
        
    end

    def all_electorates
        puts ""
        puts "What number electorates would you like to see? 1-10, 11-20, 21-30, 31-40, 41-50, 51-60, 61-70, 71-80, 81-90, 91-100, 101-110, 111-120, 121-130, 131-140, 141-150 or 151?"
        puts ""
        input = gets.strip.to_i

        list_electorates(input)

        puts ""
        puts "Which electorate would you like to see results from?"
        input = gets.strip.to_i

        electorate = Electorate.find(input)

        print_electorate(electorate)

        puts ""
        puts "Would you like to see more information about this electorate? Enter Y or N"

        input = gets.strip.downcase

        if input == "y"
            print_candidates(electorate)
        elsif input == "n"
            see_another_electorate
        else 
            puts ""
            puts "Please enter Y or N."
            all_electorates
        end

    end

    def state_electorates
        states = ["NSW","VIC","QLD","WA","SA","TAS","ACT","NT"]
        puts ""
        puts "Which state or territory would you like to see results from?"
        puts ""
        states.each_with_index {|state, index|
            puts "#{index+1}. #{state}"
        }
        input = gets.strip.to_i

        


    end

    def see_another_electorate
        
        puts ""
        puts "Would you like to see another electorate? Enter Y or N"
        input = gets.strip.downcase
        if input == "y"
            start
        elsif input == "n"
            puts ""
            puts "Thank you for using the Australian Federal Election 2022 Results Tracker!"
            exit
        else 
            puts ""
            puts "Please enter Y or N."
            start
        end
    end


    def list_electorates from_number
        
        puts ""
        puts "=================================="
        puts "Electorates #{from_number} - #{from_number+9}"
        puts "=================================="
        Electorate.all[from_number-1, 10].each.with_index(from_number) do |electorate, index|
            puts "#{index}. #{electorate.division} in #{electorate.state}"
        end

    end

    def list_state_electorates state
        puts "list of states goes here"
    end

end

CLI.new.start