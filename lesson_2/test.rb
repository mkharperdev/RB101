require 'yaml'
MESSAGES = YAML.load_file('mortgage_calculator_messages.yml')

def prompt(message)
  puts "=> #{message}"
end


loop do
prompt(MESSAGES['another_calculation'])
  answer = gets.chomp
  if answer.downcase.start_with?('y') 
    break
  elsif answer.downcase.start_with?('n')
    prompt(MESSAGES['goodbye'])
  else
    prompt(MESSAGES['y_or_n'])
    next
  end
  break
end
