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

    (press enter to continue)

    EOF
    STDIN.gets.chomp

    self.main_menu
  end

  def self.main_menu
    puts <<-'EOF'
    Main Menu
    ======================================

    1. Clone data from Dnd 5th Edition API
    2. Search local database

    0. Exit


    EOF
    input = STDIN.gets.chomp

    if input == "1"
      self.clone_spells
    elsif input == "2"
      # puts "input == 2"
      # exit
    elsif input == "0"
      "Goodbye! <3"
      exit
    else
      "Invalid entry. Returning to main menu."
      self.main_menu
    end

  end

  def self.clone_spells
    puts "Press enter to clone all spells (!!temporarily disabled!!), or 'q' to return to main menu."
    input = STDIN.gets.chomp
    if input == "q"
      self.main_menu
    else
      self.print_json
    end
  end

  def self.print_json
    puts @json_spells["count"]
    puts @json_spells
    self.save_spells_to_db
  end

  def self.save_spells_to_db
    @spell_count = @json_spells["results"].count
    @spell_count.times do
      spell = get_json(API_URL + "/spells/" + @spell_count.to_s)
      puts spell

      classes = []
      spell["classes"].each do |class_hash|
        classes << class_hash["name"]
      end

      # # CURRENT DATABASE IS SEEDED WITH ALL 319 SPELLS,
      # # CRUD FUNCTIONALITY DISABLED
      # Spell.create(api_id: spell["_id"], api_index: spell["index"], name: spell["name"], desc: spell["desc"], level: spell["level"], classes: classes, duration: spell["duration"], casting_time: spell["casting_time"] )

      @spell_count -= 1

    end
  end

end
