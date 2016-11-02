require "chi_problem_landlords/version"

module ChiProblemLandlords
  class Landlord
    attr_accessor :community_area, :address, :respondent
    def intialize(hash)
      @community_area = hash["community_error"]
      @address = hash["address"]
      @respondent = hash["respondent"]
    end

    def all
      collection = []
      Unirest.get("https://data.cityofchicago.org/resource/dip3-ud6z.json").body.each do |landlord_hash|
        collection << Landlord.new(landlord_hash)
      end
      collection
    end

    def find(params_id)
      landlord_array = Unirest.get("https://data.cityofchicago.org/resource/dip3-ud6z.json").body
      Landlord.new(landlord_array[params_id])
    end
  end
end
