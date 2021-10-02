class Project1
  attr_accessor(:cur_class)
  CMD = %w[s u m c q]

  def initialize
    super
    @cur_class = Object
  end

  def program_loop
    self.instructions

    while true
      input = gets
      param1 = input[0]

      case param1
      when "s"
        command_s
      when "u"
        command_u input
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

  def command_s
    puts "1. Class name: " + @cur_class.name

    puts "2. Super class name: " + @cur_class.class.superclass.class.name

    puts "3. List of subclasses: "
    sub = get_subclasses @cur_class
    sub.each_with_index { |c, i| puts "\t#{i+1}.) #{c}" }

    puts "4. List of instance methods: "
    @cur_class
      .class
      .instance_methods
      .each_with_index { |m, i| puts "\t#{i+1}.) #{m}" }

    puts "5. List of instance variables"
    @cur_class
      .class
      .instance_variables
      .each_with_index { |v, i| puts "\t#{i+1}.) #{v}" }
  end

  def command_u(input)
    sub = get_subclasses @cur_class

    nth_item =  input[2..].to_i - 1
    if nth_item < 0 || nth_item > sub.length
      puts "Invalid index. Please try again."
    else
      @cur_class = sub[nth_item]
      command_s
    end
  end

  def get_subclasses(my_class)
    ObjectSpace
      .each_object(@cur_class.class)
      .select { |c| c < my_class }
  end

  def create_instruction(command, message)
    "\t" + command + " — " + message
  end

  def instructions
    puts "Welcome to CS474 Project 1"
    puts "INSTRUCTIONS:"
    puts create_instruction CMD[0], "Display the five items of information above for the superclass of the current class"
    puts create_instruction CMD[1] + " n", "The n-th subclass of the current class becomes the current class"
    puts create_instruction CMD[2], "This command prints a list of the public class methods defined in the current class"
    puts create_instruction CMD[3] + " name", "Display information for the class specified by name"
    puts create_instruction CMD[4], "This command exits your browser"
    puts ""
  end
end

program = Project1.new
program.program_loop