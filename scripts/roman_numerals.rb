NUMERAL_HASH = {
  1 => "I",
  5 => "V",
  10 => "X",
  50 => "L",
  100 => "C",
  500 => "D",
  1000 => "M"
}

def convert_to_old_roman number_to_convert
  reversed_numeral_hash = Hash[NUMERAL_HASH.to_a.reverse]
  answer = ""
  reversed_numeral_hash.each do |num, numeral|
    if number_to_convert >= num
      num_numerals, number_to_convert = number_to_convert.divmod(num)
      num_numerals.times { answer += numeral }
    end
  end
  answer
end

OLD_TO_NEW_NUMERALS = {
  "VIIII" => "IX", # 9
  "IIII" => "IV", # 4
  "LXXXX" => "XC", # 90
  "XXXX" => "XL", # 40
  "DCCCC" => "CM", # 900
  "CCCC" => "CD" # 400
}

def convert_to_new_roman number_to_convert
  answer = convert_to_old_roman(number_to_convert)
  OLD_TO_NEW_NUMERALS.each do |old_numeral, new_numeral|
    if answer.include? old_numeral
      answer.gsub! old_numeral, new_numeral
    end
  end
  answer
end

################# DTC ######################
p convert_to_old_roman(1) == "I"
p convert_to_old_roman(5) == "V"
p convert_to_old_roman(9) == "VIIII"
p convert_to_old_roman(10) == "X"
p convert_to_old_roman(19) == "XVIIII"
p convert_to_old_roman(23) == "XXIII"
p convert_to_old_roman(1623) == "MDCXXIII"

p convert_to_new_roman(4) == "IV"
p convert_to_new_roman(9) == "IX"
p convert_to_new_roman(19) == "XIX"
p convert_to_new_roman(40) == "XL"
p convert_to_new_roman(90) == "XC"
p convert_to_new_roman(400) == "CD"
p convert_to_new_roman(900) == "CM"
