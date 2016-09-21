require 'rest-client'
require 'json'

module DateConverter
  @settings = { end_point: "http://www.hebcal.com/converter/"}

  def self.gregorian_to_hebrew(date = Date.today)
    params = {
      gy: date.year,
      gm: date.month,
      gd: date.day,
      g2h: 1,
      gs: "on",
      cfg: "json"
    }
    response = JSON.parse(RestClient.get(@settings[:end_point], params: params))
    date_in_hebrew = response["hebrew"].to_s
  end

end
