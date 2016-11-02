require "chi_problem_landlords/version"
require "unirest"

module ChiProblemLandlords
  class Landlord

    attr_accessor :community_area, :address, :respondent
    def initialize(hash)
      @community_area = hash["community_area"]
      @address = hash["address"]
      @respondent = hash["respondent"]
    end

    def self.all
      convert_array_to_objects(Unirest.get("https://data.cityofchicago.org/resource/dip3-ud6z.json").body)
    end

    def self.find(params_id)
      landlord_array = Unirest.get("https://data.cityofchicago.org/resource/dip3-ud6z.json").body
      Landlord.new(landlord_array[params_id])
    end

    def self.where(search_hash)
      search_array = []
      search_hash.each do |key, value|
        search_array << "#{key}=#{value}"
      end
      search_string = search_array.join("&")
      convert_array_to_objects(Unirest.get("https://data.cityofchicago.org/resource/dip3-ud6z.json?#{search_string}").body)
    end

    private

    def self.convert_array_to_objects(landlord_array)
      collection = []
      landlord_array.each do |landlord_hash|
        collection << Landlord.new(landlord_hash)
      end
      collection
    end
  end
end