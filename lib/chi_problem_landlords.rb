require "chi_problem_landlords/version"
require "unirest"

module ChiProblemLandlords
  class Finder
    def all
      collection = []
      Unirest.get("https://data.cityofchicago.org/resource/dip3-ud6z.json").body.each do |landlord_hash|
        p landlord_hash
        collection << Landlord.new(landlord_hash)
      end
      collection
    end

    def find(params_id)
      landlord_array = Unirest.get("https://data.cityofchicago.org/resource/dip3-ud6z.json").body
      Landlord.new(landlord_array[params_id])
    end
  end

  class Landlord
    attr_accessor :community_area, :address, :respondent
    def initialize(hash)
      @community_area = hash["community_area"]
      @address = hash["address"]
      @respondent = hash["respondent"]
    end
  end
end