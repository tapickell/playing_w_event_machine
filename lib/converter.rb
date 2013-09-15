class Number

  def initialize(number)
    @number = number
    @numbers = {"10" => "A", "11" => "B", "12" => "C", "13" => "D", "14" => "E", "15" => "F"}
  end

  def type
    determine_type
  end

  def to_decimal
    return @number.to_i(16) if type == "hexadecimal"
    return @number.to_i(2) if type == "binary"
    @number
  end

  def to_binary
    return @number.to_i(16).to_s(2) if type == "hexadecimal"
    return @number.to_s(2) if type == "decimal"
    @number
  end

  def to_hexadecimal
    return @number.to_i(2).to_s(16) if type == "binary"
    return @number.to_s(16) if type == "decimal"
    @number
  end

  def determine_type
    return "binary" if number_is_binary?
    return "hexadecimal" if number_is_hex?
    "decimal"
  end

  def number_is_hex?
    @number.each_char do |c|
      return true if @numbers.values.includes? c
    end
    false
  end

  def number_is_binary?
    @number.each_char do |c|
      return false unless (c == '1' || c == '0')
    end
    true
  end

  def binary_to_decimal
    count = 0
    bit = @number.length
    @number.each_char do |c|
      bit -= 1
      count += (1*2**bit) if c == "1"
    end
    count
  end

  def hexadecimal_to_decimal
    count = 0
    bit = @number.length
    @number.each_char do |c|
      bit -= 1
      number = (c.to_i == 0) ? letter_to_number(c) : c.to_i
      count += (number*16**bit)
    end
    count
  end

  def decimal_to_hexadecimal
    number = @number
    hexadecimal = ""
    if number < 0
      negative = true
      number = number.abs
    end
    while number > 0
      hexadecimal.prepend(number_to_letter(number % 16))
      number = number / 16
    end
    hexadecimal = hex_twos_comp(hexadecimal) if negative
    hexadecimal
  end

  def hex_twos_comp(hexadecimal)
    twos_hex = []
    hexadecimal = [hexadecimal] unless hexadecimal.is_a? Array
    hexadecimal.each do |digit|
      number = @numbers.include? digit ? letter_to_number(digit) : digit.to_i
      twos_hex << (15 - number) + 1
    end
    twos_hex.to_s
  end

  def decimal_to_binary
    number = @number
    binary = ""
    while number > 0
      binary.prepend(number % 2 == 1 ? "1" : "0")
      number = number / 2
    end
    binary
  end

  def letter_to_number(c)
    number = c.ord
    number - 55
  end

  def number_to_letter(n)
    return n.to_s if n < 10
    return @numbers[n.to_s] if (10..15).include? n
    return "error"
  end
end
