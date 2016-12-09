#CSCI3055U Project - Student Schedule App
#Khirthana Subramanian
#100453865

Shoes.app :title => "Schedule Builder App", :width => 640, :height => 430 do

  background whitesmoke
  border(darkblue,
         strokewidth: 6)
  stack(margin: 12) do
  para "Enter course code (ie: CSCI 3055U)"
    flow do
      @edit = edit_line

      button "Get schedule",:width => 100  do

  #para @edit.text
        alert "button clicked"
        @box = edit_box :width => 0.97, :height => 80, :text =>'',:margin_left => '2%'

        @file = File.new("schedule.txt", "r")
        @elements = Array.new
        @schedules = Array.new
        counter = 0

        @output="Schedule for "+ @edit.text+": \n"
        #@output="Schedule for CSCI 3055U: \n"
        @day=""

      #search for course code input by user and extract schedule from the schedule.txt file
        while (@line = @file.gets)
          #if @line.include? @edit.text
          if @line.include? "CSCI 3055U"
            @elements.insert(counter,@line)
            @e=@line.split("|")

      #format and display the day of class for user
            puts case @e[4]
            when "M"
              @day="Thursday"
            when "T"
              @day="Tuesday"
            when "W"
              @day="Wednesday"
            when "R"
              @day="Thursday"
            when "F"
              @day="Friday"
            else
              @day="Saturday"
            end

            @schedule=counter.to_s+" : "+@day+" "+@e[3]+":"+@e[5]+"-"+@e[6]+":"+@e[7]+" "+@e[2]+" "+@e[1]+" "+@e[8]

            @schedules.insert(counter,@schedule)

            @output=@output+@schedule
            counter = counter + 1
          end
        end

      #prints schedule to user
        @box.text= @output

      end
    end
  end
end
