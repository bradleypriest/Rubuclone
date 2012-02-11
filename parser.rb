class Parser

  def initialize(regex, string)
    @regex = regex
    @string = string
  end

  def highlight
    reg_exp = Regexp.new("("+@regex+")")
    result = @string.gsub reg_exp do
      "<span class=\"highlight\">#{$1}</span>"
    end
    result
  end

  def matches
    reg_exp = Regexp.new(@regex)
    matches = []
    @string.gsub reg_exp do
     matches << $1
    end
    matches
  end

end