#CSCI3055U Project - Student Schedule App
#Khirthana Subramanian 
#100453865

Shoes.app :title => "Student Schedule App", :width => 640, :height => 430 do

  background whitesmoke
  border(darkblue,
         strokewidth: 6)
  stack(margin: 12) do
  para "Enter course code (ie: CSCI 3055U)"
  flow do
  @edit = edit_line

  button "Get schedule",:width => 100  do

  #para @edit.text

  @box = edit_box :width => 0.97, :height => 80, :text =>'',:margin_left => '2%'


  @file = File.new("schedule.txt", "r")
  @elements = Array.new
  counter = 0
  while (@line = @file.gets)
    if @line.include? @edit.text
      @elements.insert(counter,@line)
      counter = counter + 1
    end
  end

  #@box.text=@elements[0]
  @box.text=@elements

  end
  end
  end

end
