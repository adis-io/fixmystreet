class CountriesController < ApplicationController
  def show
    @country = Country.first
  end
end
