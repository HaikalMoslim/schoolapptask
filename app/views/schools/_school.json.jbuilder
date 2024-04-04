json.extract! school, :latitude, :longitude
json.label school.name
json.tooltip html_link_to(school)
json.url school_url(school, format: :json)
