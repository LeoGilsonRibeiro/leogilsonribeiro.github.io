# frozen_string_literal: false

# Roman_Numerals
# source: https://gist.github.com/jergagon1/73a13b7729fced86755d#file-roman_numerals-rb
NUMERAL_HASH = {
  1 => 'I',
  5 => 'V',
  10 => 'X',
  50 => 'L',
  100 => 'C',
  500 => 'D',
  1000 => 'M'
}.freeze

def convert_to_old_roman(number_to_convert)
  reversed_numeral_hash = Hash[NUMERAL_HASH.to_a.reverse]
  answer                = ''
  reversed_numeral_hash.each do |num, numeral|
    if number_to_convert >= num
      num_numerals, number_to_convert = number_to_convert.divmod(num)
      num_numerals.times { answer += numeral }
    end
  end
  answer
end

OLD_TO_NEW_NUMERALS = {
  'VIIII' => 'IX', # 9
  'IIII' => 'IV', # 4
  'LXXXX' => 'XC', # 90
  'XXXX' => 'XL', # 40
  'DCCCC' => 'CM', # 900
  'CCCC' => 'CD' # 400
}.freeze

def convert_to_new_roman number_to_convert
  answer = convert_to_old_roman(number_to_convert)
  OLD_TO_NEW_NUMERALS.each do |old_numeral, new_numeral|
    if answer.include? old_numeral
      answer.gsub! old_numeral, new_numeral
    end
  end
  answer
end
