class MunicipalityFinder

  @key = ENV['OST_API_KEY']

  def self.find_municipality(coordinates)
    longitude = coordinates[0]
    latitude = coordinates[1]
    #An empty or 0 range will return all the municipalitys in the district that the location belongs to
    full_url = "https://api.ost.pt/municipalities/?key=#@key&center=#{longitude},#{latitude}&range=0.0001"

    results= nil
    while results==nil
      begin
        puts "Getting municipality from OST"
        results = HTTParty.get(full_url)
      rescue Exception => e
        puts e.message
        puts e.backtrace.inspect
      end
    end

    unless results['Objects'].empty?
      id = results['Objects'][0]['id']
      name = results['Objects'][0]['name']

      Municipality.find_or_create_by(:ost_id => id, :name => name)
    end
  end

end