class Parser

  def initialize(regex, string)
    @regex = regex
    @string = string
  end

  def highlight
    begin
      reg_exp = Regexp.new("("+@regex+")")
      result = @string.gsub reg_exp do
        "<span class=\"highlight\">#{$1}</span>"
      end
      result
    rescue RegexpError => e
      "<span class=\"alert-error\">Error: #{e.message}</span>"
    end
  end

  def matches
    begin
      reg_exp = Regexp.new(@regex)
      matches = []
      @string.gsub reg_exp do
       matches << $1
      end
      matches
    rescue
      []
    end
  end

end