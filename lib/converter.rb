class Number
  @numbers = {10 => "A", 11 => "B", 12 => "C", 13 => "D", 14 => "E", 15 => "F"}

  def initialize(number)
    @number = number
  end

  def type
    determine_type
  end

  def to_decimal
    type = determine_type
    return @number if type == "decimal"
    return binary_to_decimal if type == "binary"
    return hexadecimal_to_decimal
  end

  def to_binary
    type = determine_type
    return @number if type == "binary"
    return decimal_to_binary if type == "decimal"
    return hexadecimal_to_binary
  end

  def to_hexadecimal
    type = determine_type
    return @number if type == "hexadecimal"
    return decimal_to_hexadecimal if type == "decimal"
    return binary_to_hexadecimal
  end

  private
  def determine_type
    return "decimal" if @number.is_a? Numeric
    return "binary" if number_is_binary
    return "hexadecimal"
  end

  def number_is_binary
    @number.each_char do |c|
      return false unless (c == '1' || c == '0')
    end
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
    return @numbers[n] if (10..15).include? n
    return "error"
  end
end
