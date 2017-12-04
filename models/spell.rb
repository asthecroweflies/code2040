require 'json'
require_relative 'mention.rb'
require 'pp'
class Spell

  def initialize(params)
    @classification = params["Classification"]
    @effect = params["Effect"]
    @name = params["Spell(Lower)"]
    @formatted_name = params["Spell"]
    @book = params["Book"]
  end

  attr_reader :classification, :effect, :name, :formatted_name

  def self.data
    path = 'data/spells.json'
    file = File.read(path)
    JSON.parse(file)
  end

  def self.random
    new(data.sample)
  end

  def self.effects
    data.map{|el| el["Effect"]}
  end

  # These two methods are used to validate answers
  def self.is_spell_name?(str)
    data.index { |el| el["Spell(Lower)"] == (str.downcase) }
  end

  def self.is_spell_name_for_effect?(name, effect)
    data.index { |el| el["Spell(Lower)"] == name && el["Effect"] == effect }
  end


  # finds who appeared by a spell
  def count_occurence(excerpt) 
    #Character = Struct.new(:forename, :surname)
    #puts excerpt
    
    characters = 
    [
      {:id => 0, :forename => 'harry', :surname => 'potter'},
      {:id => 1, :forename => 'hermoine', :surname => 'granger'},
      {:id => 2, :forename => 'ron', :surname => 'weasley'},
      {:id => 3, :forename => 'draco', :surname => 'malfoy'},
      {:id => 4, :forename => 'neville', :surname => 'longbottom'},
      {:id => 5, :forename => 'severus', :surname => 'snape'},
      {:id => 6, :forename => 'remus', :surname => 'lupin'},
      {:id => 7, :forename => 'alastor', :surname => 'moody'},
      {:id => 8, :forename => 'albus', :surname => 'dumbledore'},
      {:id => 9, :forename => 'voldemort', :surname => 'he who shall not be named'}
    ]

    char_mentioned = Array.new(10, 0) #boolean array to indicate if character appears


    #puts characters[]
    found = false;
    characters.each do |c|

      if (excerpt.include? "#{c[:forename]}" || "#{c[:surname]}")
        index = "#{c[:id]}".to_int()
        char_mentioned.map{|x| x == index ? 1 : x }
      end 
      

      return char_mentioned
    end
  end

  def reverse_name

    
    b1_m = b2_m = b3_m = b4_m = b5_m = b6_m = b7_m = 0 # total mentions per book
    character_mention = Array.new(10, 0);#how often a character appeared near a spell
    non_naiveity_count = Array.new(10, 0);#how often a character appeared by unforgiveable

    popularity_score = 0.0;
    non_naiveity_score = 0.0;

    all_mentions = JSON.parse(File.read('data/mentions.json'));
    for m in all_mentions
      case m["Book"]
        when "1: SS"
          b1_m = b1_m + 1
          character_mention.transpose.map{|character| count_occurence(m)}

        when "2: CoS"
          b2_m = b2_m + 1

        when "3 PoA"
          b3_m = b3_m + 1

        when "4 GoF"
          b4_m = b4_m + 1

        when "5 OotP"
          b5_m = b5_m + 1

        when "6 HBP"
          b6_m = b6_m + 1

        when "7: DH"
          b7_m = b7_m + 1

      end

#      if (m["Book"].eql? "")
#      puts m["Concordance"]
    end

    puts "book 1 has #{b1_m} mentions!"
    puts "book 7 has #{b7_m}"

    count_occurence(character_mention, non_naiveity_count, "ree")

    #return 'shazbot'
    return @name.reverse	
  end

  # Spell 2: Counter
  # This instance method should return the number
  # (integer) of mentions of the spell.
  # Tests: `bundle exec rspec -t counter .`
  def mention_count

  mention_count = 0
  m = Mention.data 

  for a_mention in m
    if (@name.eql? a_mention["Spell"])
      mention_count = mention_count + 1
    end
  end

  return mention_count
  end
  # Spell 3: Letter
  # This instance method should return an array of all spell names
  # which start with the same first letter as the spell's name
  # Tests: `bundle exec rspec -t letter .`
  def names_with_same_first_letter
    name_array = Array.new
    s = Spell.data

    for a_spell in s
      if (@name[0].eql? a_spell["Spell(Lower)"][0])
        name_array.push(a_spell["Spell(Lower)"])
      end
    end

  return name_array
  end

  # Spell 4: Lookup
  # This class method takes a Mention object and
  # returns a Spell object with the same name.
  # If none are found it should return nil.
  # Tests: `bundle exec rspec -t lookup .`
  def self.find_by_mention(mention)

    spell_data = Spell.data

    for a_spell in spell_data
      if (mention.name == a_spell["Spell(Lower)"])

        #puts "a match! " + a_spell["Spell(Lower)"]
        found_spell = Spell.new({"Classification" => a_spell["Classification"], 
                                 "Effect" => a_spell["Effect"],
                                 "Spell(Lower)" => a_spell["Spell(Lower)"],
                                 "Spell" => a_spell["Spell"]})
        return found_spell  
      end
    end 

  return nil
  end

end
