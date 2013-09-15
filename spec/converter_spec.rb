require 'converter'

TEST_BINARY = '1111000011110000'
TEST_DECIMAL = 42
TEST_HEXADECIMAL = "E5B6AED7"
TEST_FIFTEEN = 15
TEST_TWENTY_TWO = 22
TEST_TEN = 10
TEST_NEGATIVE = -15

describe Number do
  it "takes a binary number string then can return a decimal" do
    @number = Number.new(TEST_BINARY)
    @number.type.should == "binary"
    @number.to_decimal.should == 61680
  end

  it "takes a hexadecimal number string then can return a decimal" do
    @number = Number.new(TEST_HEXADECIMAL)
    @number.type.should == "hexadecimal"
    @number.to_decimal.should == 3853954775
  end

  it "takes an integer then can return a binary number string" do
    @number = Number.new(TEST_DECIMAL)
    @number.type.should == "decimal"
    @number.to_binary.should == "101010"
  end

  it "takes an integer then can return a hexadecimal number string" do
    @number = Number.new(TEST_DECIMAL)
    @number.type.should == "decimal"
    @number.to_hexadecimal.should == "2a"
  end

  it "takes an integer then can return a hexadecimal number string for other values" do
    @number1 = Number.new(TEST_FIFTEEN)
    @number1.type.should == "decimal"
    @number1.to_hexadecimal.should == "f"
    @number2 = Number.new(TEST_TWENTY_TWO)
    @number2.type.should == "decimal"
    @number2.to_hexadecimal.should == "16"
    @number3 = Number.new(TEST_TEN)
    @number3.type.should == "decimal"
    @number3.to_hexadecimal.should == "a"
  end

  it "takes a negative integer then can return a hexadecimal number string" do
    @number = Number.new(TEST_NEGATIVE)
    @number.type.should == "decimal"
    @number.to_hexadecimal.should == "-f"
  end
end
