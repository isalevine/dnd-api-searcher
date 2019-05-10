def get_json(url)
  response = RestClient.get(url)
  json = JSON.parse(response)
end
