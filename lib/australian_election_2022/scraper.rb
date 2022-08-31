class AustralianElection2022::Scraper
    BASE_URL = "https://results.aec.gov.au/27966/Website/"
    SEAT_SUMMARY_URL = "HouseSeatSummary-27966.htm"

    def get_page url = BASE_URL+SEAT_SUMMARY_URL
        Nokogiri::HTML(open(url))
    end
        
    def scrape_electorates
        doc = get_page

        doc.css("tbody.list tr").collect do |electorate|

            division = electorate.css("td")[0].text.strip
            state = electorate.css("td")[1].text.strip
            incumbent = electorate.css("td")[2].text.strip
            leading = electorate.css("td")[3].text.strip
            tcp = electorate.css("td")[4].text.strip
            margin = electorate.css("td")[5].text.strip
            swing = electorate.css("td")[6].text.strip
            url = electorate.css("a").attr("href").value

            AustralianElection2022::Electorate.new(division: division, state: state, incumbent: incumbent, leading: leading, tcp: tcp, margin: margin, swing: swing, url: url)
        end
    end

    def scrape_candidates electorate
        page_url = BASE_URL + electorate.url
        
        doc = get_page(page_url)
 
        doc.css("tbody tr").collect do |candidate| 

            name = candidate.css('td[headers="fpCan"]').text.strip
            party = candidate.css('td[headers="fpPty"]').text.strip
            votes = candidate.css('td[headers="fpVot"]').text.strip
            pct = candidate.css('td[headers="fpPct"]').text.strip  
            swing = candidate.css('td[headers="fpSwg"]').text.strip
            status = candidate.css('td[headers="fpSts"]').text.strip
            
            electorate.candidates << AustralianElection2022::Candidate.new(name: name, party: party, votes: votes, pct: pct, swing: swing, status: status, electorate: electorate) unless (name == "") #AEC first preference div does not have an id or class so there was no way to restrict nokogiri to just the first preference table, thus empty entries must be skipped when creating candidate instances
        end
    end

end