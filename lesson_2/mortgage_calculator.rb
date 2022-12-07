require 'yaml'
MESSAGES = YAML.load_file('mortgage_calculator_messages.yml')

def prompt(message)
  puts "=> #{message}"
end

def number?(input)
  integer?(input) || float?(input)
end

def integer?(input)
  input.to_i.to_s == input
end

def float?(input)
  input.to_f.to_s == input
end

prompt(MESSAGES['welcome'])

name = ''
loop do
  name = gets.chomp.strip.capitalize

  if name.empty?
    prompt(MESSAGES['valid_name'])
  else
    break
  end
end

prompt("Hi #{name}!")

loop do # main loop
  loan_amount = ''
  apr = ''
  monthly_loan_duration = ''
  answer = ''

  loop do
    prompt(MESSAGES['loan_amount'])
    loan_amount = gets.chomp

    if number?(loan_amount) && loan_amount.to_f > 0
      break
    else
      prompt(MESSAGES['valid_number'])
    end
  end

  loop do
    prompt(MESSAGES['apr'])
    apr = gets.chomp

    if number?(apr) && apr.to_f >= 0
      break
    else
      prompt(MESSAGES['valid_number'])
    end
  end

  loop do
    prompt(MESSAGES['monthly_loan_duration'])
    monthly_loan_duration = gets.chomp

    if number?(monthly_loan_duration) && monthly_loan_duration.to_f > 0
      break
    else
      prompt(MESSAGES['valid_number'])
    end
  end

  system('clear')

  annual_interest_rate = apr.to_f() / 100
  monthly_interest_rate = annual_interest_rate / 12
  if apr.to_i > 0
    monthly_payment = loan_amount.to_f() *
                      (monthly_interest_rate /
                      (1 - (1 + monthly_interest_rate)**
                      (-monthly_loan_duration.to_f)))
  else
    monthly_payment = loan_amount.to_f / monthly_loan_duration.to_f
  end

  display_summary = <<-MSG
  Thank you for using the loan calculator, #{name}!
     Your loan summary is:
    
     Loan Amount: #{loan_amount}
     Loan Duration: #{monthly_loan_duration} months
     Monthly Interest Rate: #{(monthly_interest_rate * 100).round(2)}%
     Monthly Payment: $#{monthly_payment.round(2)}
    
    MSG

  prompt(display_summary)

  # get if would like another calculation
  # validate y/n
  loop do
    prompt(MESSAGES['another_calculation'])
    answer = gets.chomp
    if answer.downcase.start_with?('y')
      break
    elsif answer.downcase.start_with?('n')
      at_exit { prompt(MESSAGES['goodbye']) }
      exit
    else
      prompt(MESSAGES['y_or_n'])
      redo
    end
  end
end
