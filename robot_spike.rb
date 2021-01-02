
def command
  @command = gets.chomp
end

case command
when 'N'
  location[1] += 1
end