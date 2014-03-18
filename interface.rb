require './interface_include'

def set_up
  lists = List.all
  main_menu
end

def main_menu
  system('clear')
  puts 'Here are your lists:'
  list_lists
  puts 'Enter "add list" to add a list'
  puts 'Enter "view name" to view a list'
  puts 'Enter "delete name_of_list" to delete a list'
  input = gets.chomp.split
  if input[0] == 'add'
    input.shift
    add_list(input.join(' '))
  elsif input[0] == 'view'
    input.shift
    input.join(' ')
    view_list(input.join(' '))
  elsif input[0] == 'delete'
    input.shift
    delete_list(input.join(' '))
    main_menu
  else
    puts "Sorry, I cant do that Dave."
    sleep(1)
    main_menu
  end
end

def list_lists
  List.all.each_with_index do |list, index|
    puts (index+1).to_s  + '. ' + list.name + " " + list.id.to_s
  end
end

def delete_list(list_name)
  list_id = DB.exec("SELECT * FROM lists WHERE name = ('#{list_name}');")[0]["id"]

  DB.exec("DELETE FROM tasks WHERE list_id = '#{list_id}';")
  DB.exec("DELETE FROM lists WHERE name = '#{list_name}';")
end

def add_list(list_name)
  new_list = List.new({:name => list_name})
  new_list.save
  main_menu
end


def view_list(list_name)
  system('clear')
  puts "--#{list_name}--"
  list_id = DB.exec("SELECT * FROM lists WHERE name = ('#{list_name}');")[0]["id"]
  list_tasks(list_id)

  puts 'Enter "add task_name" to add a task'
  puts 'Enter "delete name_of_task" to delete a task'
  #puts 'Enter "check name_of_task" to check-off a task'
  puts 'Enter "return" to return to main menu'
  input = gets.chomp.split
  if input[0] == 'add'
    input.shift
    add_task(list_name, input.join(' '), DB.exec("SELECT * FROM lists WHERE name = ('#{list_name}');")[0]["id"])
  elsif input[0] == 'delete'
    input.shift
    delete_task(list_name, input.join(' '))
  elsif input[0] == 'return'
    main_menu
  elsif input[0] == 'mark'
    input.shift
    check_task(list_name, input.join(' '), list_id)
  else
    puts "Sorry, I cant do that Dave."
    sleep(1)
    view_list(list_name)
  end
end

def list_tasks(list_id)
  Task.all.each do |task|
    if task.list_id.to_i == list_id.to_i
      puts task.name
    end

  end
end

def add_task(list_name ,task_name, list_id)
  new_task = Task.new(task_name, list_id)
  new_task.save
  view_list(list_name)
end

# def check_task(list_name , task_name, list_id)

#   main_menu
# end

def delete_task(list_name, task_name)
  DB.exec("DELETE FROM tasks WHERE name = ('#{task_name}');")
  view_list(list_name)
end

set_up





























































# require "curses"
# include Curses

# def show_message(message)
#   width = message.length + 6
#   win = Window.new(5, width,
#                (lines - 5) / 2, (cols - width) / 2)
#   win.box(?|, ?-)
#   win.setpos(2, 3)
#   win.addstr(message)
#   win.refresh
#   win.getch
#   win.close
# end

# init_screen
# begin
#   crmode
# #  show_message("Hit any key")
#   setpos((lines - 5) / 2, (cols - 10) / 2)
#   addstr("Hit any key")
#   refresh
#   getch
#   show_message("Hello, World!")
#   refresh
# ensure
#   close_screen
# end
