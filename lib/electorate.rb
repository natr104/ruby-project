class Electorate
    attr_accessor :division, :state, :incumbent, :leading, :tcp, :margin, :swing, :url

    @@all = []

    def initialize attributes
        attributes.each do |key, value|
            send("#{key}=", value)
        end

        self.class.all << self
    end

    def print_electorate
        system("clear")
        puts "=================================="
        puts "Division of #{division} in #{state}."
        puts "=================================="
        puts "Previously held by: #{incumbent}. Leading party: #{leading} by a margin of #{margin} votes. Two-party-preferred: #{tcp}% with a swing of #{swing}%."
        puts ""
    end

    def self.all
        @@all
    end
end