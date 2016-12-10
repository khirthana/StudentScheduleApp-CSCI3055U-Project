#CSCI3055U Project - Student Schedule App
#Khirthana Subramanian
#100453865

Shoes.app :title => "Schedule Builder App", :width => 800, :height => 550 do

  background whitesmoke
  border(darkblue,
         strokewidth: 6)
  stack(margin_left: 12,margin_top:10) do
    @AppName = para "Schedule Builder App"
    @AppName.style(stroke: darkblue,:align=>"center"  ,font: "Verdana Italic 24px" )
  end
  stack(margin_left: '45%',margin_bottom:10) do
    @img = image 'uoit-logo.jpg'
    @img.style(height:50,width:80,:align=>"center")
  end
  stack(margin_left: 12) do
    button "Info",:margin_left => '45%' do
      alert "Schedule Builder App\n\n   Enter course code and click -Get schedule- button to display schedule. \n\n   To view course schedule for course, enter course code(CSCI 3055U) \nOR\n   enter all for all course schedules \nOR\n   enter program code (CSCI or SOFE) for all program course schedules\n\nDeveloped by: Khirthana Subramanian 100453865"
    end
  end
    stack(margin: 12) do
    flow do
      para "Enter course code (ie: CSCI 3055U): ",stroke: midnightblue

      @edit = edit_line
      @edit.style(width => 100)

      button "Get schedule",:width => 100  do

        if (@edit.text).empty? or (@edit.text).size<4 or (@edit.text).size>9
          alert "Enter course code!"

        elsif (@edit.text).eql? "all"
          @box = edit_box :width => 0.97, :height => 80, :text =>'',:margin_left => '2%'

          @file = File.new("schedule.txt", "r")
          @elements = Array.new
          @schedules = Array.new
          counter = 0

          @output="Schedule for "+ @edit.text+": \n"
          @day=""
        #search for course code input by user and extract schedule from the schedule.txt file
          while (@line = @file.gets)
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

          @file.close

          #prints schedule to user
          @box.text= @output

        else
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

          @file.close

        #prints schedule to user
          @box.text= @output

        end
      end
    end
  end
  stack(margin: 12) do
    flow do
      para "Enter schedule line number:",stroke: midnightblue
      @edit2 = edit_line
      @edit2.style(width => 100)
      button "Save schedule to CSV file",:width => 200 do
      end
    end
  end
end