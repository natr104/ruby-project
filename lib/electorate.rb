class Electorate
    attr_accessor :division, :state, :incumbent, :leading, :tcp, :margin, :swing, :url

    @@all = []

    def initialize attributes
        attributes.each do |key, value|
            send("#{key}=", value)
        end

        self.class.all << self
    end

    def get_candidates
        Scraper.new.scrape_candidates(self)
    end

    def self.find id
        self.all[id-1]
    end

    def self.all
        @@all
    end
end