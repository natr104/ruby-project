class Electorate
    attr_accessor :division, :state, :incumbent, :leading, :tcp, :margin, :swing, :url

    @@all = []

    def initialize attributes
        attributes.each do |key, value|
            send("#{key}=", value)
        end
        @candidates = []
        self.class.all << self
    end

    def get_candidates
        Scraper.new.scrape_candidates(self)
    end

    def candidates
        @candidates
    end

    def self.find id
        self.all[id-1]
    end

    def self.find_state state
        self.all.select{|electorate| electorate.state == state}
    end

    def self.all
        @@all
    end
end