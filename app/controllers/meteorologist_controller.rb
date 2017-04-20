require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    street_address=@street_address.gsub(" ","+")
    url = "http://maps.googleapis.com/maps/api/geocode/json?address="+street_address
    parsed_data=JSON.parse(open(url).read)

    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    lati=@latitude

    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]
    long=@longitude


    url2 = "https://api.darksky.net/forecast/21210052f600dc2cdb79102500a309ed/"+@latitude.to_s + "," + @longitude.to_s
    parsed_data2=JSON.parse(open(url2).read)



    @current_temperature = parsed_data2["currently"]["temperature"]

    @current_summary = parsed_data2["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data2["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data2["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data2["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
