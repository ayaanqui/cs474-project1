require_relative "./merge_sort"

class Project1
  attr_accessor(:cur_class)
  CMD = %w[s u m c q]

  def initialize
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
      when "m"
        command_m
      when "c"
        command_c input
      when "q"
        break
      else
        puts "Unknown command. Please try on the commands listed above."
      end

      puts ""
    end
  end


  private

  def command_s
    class_name = @cur_class.name ? @cur_class.name : "None"
    puts "1. Class name: #{class_name}"

    if class_name.eql? "Object"
      superclass_name = "None. This is the root class"
    else
      superclass_name = @cur_class.superclass.name ? @cur_class.superclass : "None"
    end
    puts "2. Super class name: #{superclass_name}"

    sorter = MergeSort.new

    puts "3. List of subclasses: "
    sub = get_subclasses @cur_class
    if sub.length > 0
      sorter.sort(sub)
        .each_with_index { |c, i| puts "\t#{i+1}. #{c}" }
    else
      puts "\tNone"
    end

    puts "4. List of instance methods: "
    methods = @cur_class.methods false
    if methods.length > 0
      sorter.sort(methods)
        .each_with_index { |m, i| puts "\t#{i+1}. #{m}" }
    else
      puts "\tNone"
    end

    puts "5. List of instance variables"
    variables = @cur_class.instance_variables
    if variables.length > 0
      sorter.sort(variables)
        .each_with_index { |v, i| puts "\t#{i+1}. #{v}" }
    else
      puts "\tNone"
    end
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

  def command_m
    pub_methods = @cur_class.public_methods(false)
    if pub_methods.length > 0
      pub_methods.each { |c| puts c }
    else
      puts "None"
    end
  end

  def command_c(input)
    class_name = input[2..].strip
    all_classes = get_subclasses Object
    my_class = all_classes.find { |c| c.name.eql? class_name }

    if my_class
      @cur_class = my_class
      command_s
    else
      puts "No class with such name exists"
    end
  end

  def get_subclasses(my_class)
    ObjectSpace
      .each_object(Class)
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
