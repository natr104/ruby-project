class Electorate
    attr_accessor :division, :state, :incumbent, :leading, :tcp, :margin, :swing

    @@all = []

    def initialize attributes
        attributes.each do |key, value|
            send("#{key}=", value)
        end

        self.class.all << self
    end

    def print_electorate
        system("clear")
        puts "========================"
        puts "Division of #{division} in #{state}."
        puts "========================"
        puts "Held by: #{incumbent}. Leading party: #{leading} by a margin of #{margin} for a two-candidate-preferred percentage of #{tcp}% with a swing of #{swing}%."
        puts ""
    end
end