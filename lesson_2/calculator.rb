# ask the user for two numbers
# ask the user for an operation to perform
# perform the operation on the two numbers
# output the result

# answer = gets
# puts answer
# at the top of file

require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
  puts("=> #{message}")
end

# def valid_number?(num)
#   num.to_i != 0
# end
def number?(input)
  integer?(input) || float?(input)
end

def integer?(input)
  input.to_i.to_s == input
end

def float?(input)
  input.to_f.to_s == input
end

def operation_to_message(op)
  case op
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end

prompt(MESSAGES['welcome'])

name = nil
loop do
  name = gets.chomp

  if name.empty?
    prompt(MESSAGES['valid_name'])
  else
    break
  end
end

prompt("Hi #{name}!")

loop do # main loop
  number1 = nil

  loop do
    prompt(MESSAGES['first_number'])
    number1 = gets.chomp

    if number?(number1)
      break
    else
      prompt(MESSAGES['valid_number'])
    end
  end

  number2 = nil

  loop do
    prompt(MESSAGES['second_number'])
    number2 = gets.chomp

    if number?(number2)
      break
    else
      prompt(MESSAGES['valid_number'])
    end
  end

  # operator_prompt = <<-MSG
  #   What operation would you like to perform? 
  #   1) add 
  #   2) subtract 
  #   3) multiply 
  #   4) divide
  # MSG

  prompt(MESSAGES['operator_prompt'])
  operator = nil
  loop do
    operator = gets.chomp

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(MESSAGES['choose'])
    end
  end

  prompt("#{operation_to_message(operator)} the two numbers...")

  # if operator == '1'
  #   result = number1.to_i + number2.to_i
  # elsif operator == '2'
  #   result = number1.to_i - number2.to_i
  # elsif operator == '3'
  #   result = number1.to_i * number2.to_i
  # else
  #   result = number1.to_f / number2.to_f
  # end

  result = case operator
           when '1'
             number1.to_f + number2.to_f
           when '2'
             number1.to_f - number2.to_f
           when '3'
             number1.to_f * number2.to_f
           when '4'
             number1.to_f / number2.to_f
           end

  prompt("The result is #{result}")

  prompt(MESSAGES['another_calculation'])
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt(MESSAGES['goodbye'])
