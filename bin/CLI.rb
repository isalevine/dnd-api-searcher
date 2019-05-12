require_relative '../config/environment.rb'

API_URL = 'http://dnd5eapi.co/api'


class CLI
  # attr_accessor

  def self.run
    @json_spells = get_json(API_URL + "/spells")
    self.welcome_message
  end

  def self.welcome_message
    puts <<-'EOF'
    Hello there! This is a search tool
    for the wonderful Dnd 5th Edition API,
    http://www.dnd5eapi.co/ !

    Right now it is in test mode.
    Currently searching for:

    spells

    EOF

    self.print_json
  end

  def self.print_json
    puts @json_spells["count"]
    puts @json_spells
  end

end
