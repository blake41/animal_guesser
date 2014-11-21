class Node

  attr_accessor :no, :yes, :parent

  def set_children(yes, no)
    @yes = yes
    @no = no
  end

end

class AnimalNode < Node

  attr_reader :text

  def initialize(text, parent)
    @text = text
  end

  def ask
    "Is it a #{text}?"
  end

end

class QuestionNode < Node

  attr_reader :text

  def initialize(text, parent)
    @text = text
  end

  def ask
    text
  end

end

