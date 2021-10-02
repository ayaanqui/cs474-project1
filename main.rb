CMD = %w[s u m c q]

def create_instruction(command, message)
  "\t" + command + " — " + message
end

def instructions
  puts "Welcome to CS474 Project 1"
  puts "INSTRUCTIONS:"
  puts create_instruction CMD[0], "Display the five items of information above for the superclass of the current class"
  puts create_instruction CMD[1] + " n", "The n-th subclass of the current class becomes the current class"
  puts create_instruction CMD[2], "This command prints a list of the public class methods defined in the current class"
  puts create_instruction CMD[3] + " (aString)", "Display information for the class specified by name"
  puts create_instruction CMD[4], "This command exits your browser"
  puts ""
end

def get_subclasses(my_class)
  ObjectSpace.each_object(Class).select { |c| c < my_class }
end

def program_loop
  instructions
  cur_class = Object

  while true
    input = gets
    param1 = input[0]

    case param1
    when CMD[0]
      sub = get_subclasses cur_class
      sub.each_with_index { |c, i| puts "#{i+1}.) #{c}" }
    when CMD[1]
      sub = get_subclasses cur_class

      nth_item =  input[2..].to_i - 1
      if nth_item < 0 || nth_item > sub.length
        puts "Invalid index. Please try again."
      else
        puts sub[nth_item]
      end
    when CMD[2]
      puts "Print public methods of current class"
    when CMD[3]
      puts "Get class by name"
    when CMD[4]
      puts "Quit"
      break
    else
      puts "Unknown command. Please try on the commands listed above."
    end

    puts ""
  end
end

program_loop