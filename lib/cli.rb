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
        puts "Previously held by: #{electorate.incumbent}. Winning party: #{electorate.leading} by a margin of #{electorate.margin} votes. Two-party-preferred: #{electorate.tcp}% with a swing of #{electorate.swing}%."
        puts ""
    end

    def print_candidates electorate
        electorate.get_candidates
        puts "=================================="
        puts "Candidates for #{electorate.division} in #{electorate.state}:"
        puts "=================================="
        puts "   Name   |   Party   |   Votes (%)   |   Swing   |   Status"
        electorate.candidates.each_with_index do | candidate, index |
            puts "#{index+1}. #{candidate.name} | #{candidate.party} | #{candidate.votes} (#{candidate.pct}%) | #{candidate.swing}% | #{candidate.status}"
        end
    end

    def all_electorates
        puts ""
        puts "Which electorates would you like to see? Enter a number from 1 to 151 to see a list of 10 electorates to choose from."
        puts ""
        input = gets.strip.to_i

        list_electorates(input, Electorate.all)

        puts ""
        puts "Which electorate would you like to see results from?"
        input = gets.strip.to_i
        electorate = Electorate.find(input)

        print_electorate(electorate)
        see_more_information(electorate)
    end

    def state_electorates
        states = ["NSW","VIC","QLD","WA","SA","TAS","ACT","NT"]

        puts "Which state or territory would you like to see results from?"
        puts ""
        states.each_with_index {|state, index|
            puts "#{index+1}. #{state}"
        }
        input = gets.strip.to_i
        selected_state = states[input-1]
        if selected_state
            list_state_electorates(selected_state)
        else
            system("clear")
            puts "Please select a state or territory."
            state_electorates
        end
        
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
            see_another_electorate
        end
    end


    def list_electorates(from_number, electorates)
        
        puts ""
        puts "=================================="
        puts "Electorates #{from_number} - #{from_number+9}"
        puts "=================================="
        electorates[from_number-1, 10].each.with_index(from_number) do |electorate, index|
            puts "#{index}. #{electorate.division} in #{electorate.state}"
        end

    end

    def list_state_electorates state
        state_electorates = Electorate.find_state(state)
        puts ""
        puts "Which electorates in #{state} would you like to see? Enter a number from 1 - #{state_electorates.length} to see a list of 10 electorates to choose from."
        puts ""
        input = gets.strip.to_i
        list_electorates(input, state_electorates)
        puts ""
        puts "Which electorate would you like to see results from?"
        input = gets.strip.to_i
        electorate = state_electorates[input-1]
        print_electorate(electorate)
        see_more_information(electorate)
    end

    def see_more_information electorate
        puts ""
        puts "Would you like to see more information about this electorate? Enter Y or N"

        input = gets.strip.downcase
        
        if input == "y"
            print_candidates(electorate)
            see_another_electorate
        elsif input == "n"
            see_another_electorate
        else 
            puts ""
            puts "Please enter Y or N."
            see_more_information(electorate)
        end
    end

end

CLI.new.start