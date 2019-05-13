require_relative '../config/environment.rb'

API_URL = 'http://dnd5eapi.co/api'


class CLI
  # attr_accessor

  def self.run
    # MOVE get_json CALLS TO A NEW METHOD -- DO NOT
    # CALL DURING self.run (SLOWS EVERYTHING DOWN!!)
    @json_spells = get_json(API_URL + "/spells")
    @json_features = get_json(API_URL + "/features")
    self.welcome_message
  end

  def self.welcome_message
    puts <<-'EOF'
    Hello there! This is a search tool
    for the wonderful Dnd 5th Edition API,
    http://www.dnd5eapi.co/ !

    Right now it is in test mode.
    Currently searching for:

    features

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
    2. Search local database for Spells (by level)
    3. Search local database for Features (by level)

    0. Exit


    EOF
    input = STDIN.gets.chomp

    if input == "1"
      # self.clone_spells
      self.clone_features
    elsif input == "2"
      self.query_spells_by_level
    elsif input == "3"
      self.query_features_by_level

    elsif input == "0"
      puts "Goodbye! <3"
      exit
    else
      puts "Invalid entry. Returning to main menu."
      self.main_menu
    end

  end




  # option 1 - clone (features) - DISABLED!!
  def self.clone_features
    puts "Press enter to clone all features, or 'q' to return to main menu."
    input = STDIN.gets.chomp
    if input == "q"
      self.main_menu
    else
      self.print_json_spells
    end
  end

  def self.print_json_spells
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

  # option 1 - clone (features) - DISABLED!!
  def self.clone_features
    puts "Press enter to clone all features, or 'q' to return to main menu."
    input = STDIN.gets.chomp
    if input == "q"
      self.main_menu
    else
      self.print_json_features
    end
  end

  def self.print_json_features
    puts @json_features["count"]
    puts @json_features
    self.save_features_to_db
  end

  def self.save_features_to_db
    @feature_count = @json_features["results"].count
    @feature_count.times do
      feature = get_json(API_URL + "/features/" + @feature_count.to_s)
      puts feature

      classes = []
      classes << feature["class"]["name"]

      # CLONE DISABLED - 414 features in local database
      # Feature.create(api_id: feature["_id"], api_index: feature["index"], name: feature["name"], desc: feature["desc"], level: feature["level"], classes: classes )

      @feature_count -= 1

    end
  end



  # option 2 - search database (spells)
  def self.query_spells_by_level
    puts "Input spell level minimum:"
    min = STDIN.gets.to_i
    puts "Input spell level maximum (or press enter to search minimum only):"
    max = STDIN.gets.chomp

    if max == ""
      max = min
    else
      max.to_i!
    end


    if min > max
      new_max = min
      min = max
      max = new_max
    end

    spells = Spell.order("name").where("level >= #{min} AND level <= #{max}")
    self.export_spell_text(spells, min, max)
  end

  def self.export_spell_text(spells, *args)
    output = File.open("app/output/spells.yml", "w")
    output << "Output for Spells, level #{args[0]} to #{args[1]}: \n \n"
    spells.each do |spell|
      output << "Spell name: " + spell.name + "\n"
      output << "Spell level: " + spell.level.to_s + "\n"
      spell.desc.each do |text|
        output << text + "\n"
      end
      output << "\n \n \n"
    end
    output.close
    exit
  end

  # option 3 - search database (features)
  def self.query_features_by_level
    puts "Input feature level minimum:"
    min = STDIN.gets.to_i
    puts "Input feature level maximum (or press enter to search minimum only):"
    max = STDIN.gets.chomp

    if max == ""
      max = min
    else
      max.to_i!
    end


    if min > max
      new_max = min
      min = max
      max = new_max
    end

    features = Feature.order("name").where("level >= #{min} AND level <= #{max}")
    self.export_feature_text(features, min, max)
  end

  def self.export_feature_text(features, *args)
    output = File.open("app/output/features.yml", "w")
    output << "Output for Features, level #{args[0]} to #{args[1]}: \n \n"
    features.each do |feature|
      output << "Feature name: " + feature.name + "\n"
      output << "Feature level: " + feature.level.to_s + "\n"
      feature.desc.each do |text|
        output << text + "\n"
      end
      output << "\n \n \n"
    end
    output.close
    exit
  end



end
