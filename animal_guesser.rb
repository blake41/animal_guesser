require './node'
require 'pry'
require 'pry-nav'
class AnimalGuesser

  attr_reader :root

  def initialize(node)
    @root = node
  end

  def play
    puts "think of an animal..."
    paths = []
    parent = nil
    loop do
      current = root
      while current.is_a?(QuestionNode)
        puts current.ask
        answer = take_input
        if answer == "Y"
          parent = current
          current = current.yes
          paths << answer
        elsif answer == "N"
          parent = current
          current = current.no
          paths << answer
        end
      end
      # elsif current.is_a?(AnimalNode)
      puts current.ask
      answer = take_input
      if answer == "Y"
        puts "I win!"
      elsif answer == "N"
        paths << answer
        puts "You win.  Help me learn from my mistake before you go..."
        puts "what animal were you thinking of"
        new_animal = take_input
        puts "Give me a question to distinguish a #{new_animal} from #{current.text}"
        new_question = take_input
        puts "For a #{new_animal} what is your answer?"
        correct_answer = take_input
        old_current = current
        current = QuestionNode.new(new_question, parent)
        no = correct_answer == "Y" ? old_current : AnimalNode.new(new_animal, parent)
        yes = correct_answer == "Y" ? AnimalNode.new(new_animal, parent) : old_current
        current.set_children(yes, no)
        set_new_root(current, old_current)
        set_parent_pointer(parent, current, paths) if paths.count > 1
      end
    end
  end

  def set_parent_pointer(parent, current, paths)
    path = paths[-2]
    if path == "Y"
      parent.yes=(current)
    else
      parent.no=(current)
    end
  end

  def set_new_root(new_root, old_current)
    if old_current == root
      @root = new_root
    end
  end

  def take_input
    gets.chomp.capitalize
  end

end

a = AnimalGuesser.new(AnimalNode.new("Shark", nil))
a.play