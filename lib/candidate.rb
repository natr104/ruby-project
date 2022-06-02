class Candidate
    attr_accessor :name, :party, :votes, :pct, :swing, :status, :electorate

    @@all = []

    def initialize attributes
        attributes.each do |key, value|
            send("#{key}=", value)
        end

        self.class.all << self
    end



    def self.find id
        self.all[id-1]
    end

    def self.all
        @@all
    end
end