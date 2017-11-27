require 'json'
load 'models/mention.rb'

=begin
class Mention

  def initialize(params)
    puts "GON INSILTIAZE A MENTION"
    @book = params["Book"]
    @quote = params["Concordance"]
    @position = params["Position"]
    @name = params["Spell"]
  end

  attr_reader :book, :quote, :position, :name

  def self.data
    path = 'data/mentions.json'
    file = File.read(path)
    JSON.parse(file)
  end

  def self.random
    new(data.sample)
  end

end
=end
class Spell

  def initialize(params)
    @classification = params["Classification"]
    @effect = params["Effect"]
    @name = params["Spell(Lower)"]
    @formatted_name = params["Spell"]
    @book = params["Book"]
    @quote = params["Concordance"]
    @position = params["Position"]
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

  # To get access to the collaborative repository, complete the methods below.

  # Spell 1: Reverse
  # This instance method should return the reversed name of a spell
  # Tests: `bundle exec rspec -t reverse .`
  def reverse_name
    spell_name = @name
    return spell_name.reverse	
  end

  # Spell 2: Counter
  # This instance method should return the number
  # (integer) of mentions of the spell.
  # Tests: `bundle exec rspec -t counter .`
  def mention_count
    puts "a mention"
    p "b4"
    m = Mentions.new({"Book": @book, "Concordance": @quote, "Position": @position, "Spell(Lower)": @name})
    puts m    #puts m.instance_variable_get(:@position)

    p "b5"
#    puts @book
#
#    spell_name = @name
#    count = 0
#    @mention_data = JSON.parse(File.read('data/mentions.json'))

#    @mention_data.each do |spell_instance|
        #count = 0
#        if (spell_name.eql? spell_instance["Spell"])
#	    count += 1
#            puts spell_name + " has appeared in Book" + spell_instance["Book"] + " for the " + count.to_s + " time!"
    
#	end
#    end
#    puts "we found " + spell_name + " " + count.to_s + " times! "
#    return count
  p "dunnit"
  end

  # Spell 3: Letter
  # This instance method should return an array of all spell names
  # which start with the same first letter as the spell's name
  # Tests: `bundle exec rspec -t letter .`
  def names_with_same_first_letter
    ['write this method']
  end

  # Spell 4: Lookup
  # This class method takes a Mention object and
  # returns a Spell object with the same name.
  # If none are found it should return nil.
  # Tests: `bundle exec rspec -t lookup .`
  def self.find_by_mention(mention)
    Spell.new({"Classification" => 'write this method',
               "Effect" => 'write this method',
               "Spell(Lower)" => 'write this method',
               "Spell" => 'write this method'})
  end

end
