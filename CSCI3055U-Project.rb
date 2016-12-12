#CSCI3055U Project - Student Schedule App

#User enters course code; program will extract appropriate schedule and dispay to user
#After viewing schedule output; 
#	user enter schedules lines number to save to csv file 
#		which can be imported to Google Calender and used as schedule for first week of classes

#Khirthana Subramanian
#100453865


require 'csv'

$counter=1

$schedules = Array.new


#method to extract schedule for user input course code using schedule.txt file
def get_schedule(input)
	 
  @file = File.new("schedule.txt", "r")
  @elements = Array.new

  @output_lines="Schedule for "+ input+": \n"

  @day=""

#search for course code input by user and extract schedule from the schedule.txt file
  while (@line = @file.gets)
  
	if @line.include? input
	  @elements.insert($counter,@line)
	  @e=@line.split("|")

#format and display the day of class for user
	  puts case @e[4]
	  when "M"
		@day="Monday"
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

	  @schedule=$counter.to_s+" :   "+@day+"   "+@e[3]+":"+@e[5]+"-"+@e[6]+":"+@e[7]+"   "+@e[2]+" "+@e[1]+"   "+@e[8]

	  $schedules.insert($counter,@schedule)

	  @output_lines=@output_lines+@schedule
	  $counter = $counter + 1
	end
  end

  @file.close
  
  if $schedules.empty?
	@output_lines=""
  end
  
  return @output_lines
end



#method to save selected schedules by user input to "MySchedule.csv" file 
def save_schedule(input)

 @input_array=input.split(",")
	 
 CSV.open("MySchedule.csv", "w") do |csv|
	  csv << ["Subject", "Start Date", "Start Time", "End Date","End Time","All Day Event","Description","Location","Private"]
	 
	  for @index in 0 ... (@input_array.size)
		  @selected_line=($schedules[(@input_array[@index]).to_i]).split("   ")
		  
		  @date=""
		  puts case @selected_line[1]
		  when "Monday"
			@date="09/12/2016"
		  when "Tuesday"
			@date="09/13/2016"
		  when "Wednesday"
			@date="09/14/2016"
		  when "Thursday"
			@date="09/08/2016"
		  when "Friday"
			@date="09/09/2016"
		  else
			@date="09/10/2016"
		  end

		  @time=@selected_line[2].split("-")
		  @start=@time[0].split(":")
		  @end=@time[1].split(":")
	  
		   if ((@end[1]).size)<2
			@end[1]=@end[1]+"0"
		   end
		   
		   if ((@start[0]).to_i)<12 
			@start_time=@time[0]+" AM"
		   elsif (@start[0]).eql? "12"
			@start_time=@time[0]+" PM"
		   else
			@start_time=(((@start[0]).to_i)-12).to_s+":"+@start[1]+" PM"
		   end
		   
		   if ((@end[0]).to_i)<12 
			@end_time=@time[1]+" AM"
		   elsif (@end[0]).eql? "12"
			@end_time=@time[1]+" PM"
		   else
			@end_time=(((@end[0]).to_i)-12).to_s+":"+@end[1]+" PM"
		   end
		  
		  csv << [@selected_line[3], @date, @start_time, @date,@end_time,"False","",@selected_line[4],"True"]
		  
		end
	end
end



#GUI using Shoes
Shoes.app :title => "Student Schedule Builder App", :width => 800, :height => 550 do
  
  #layout customized
  background white
  border(darkblue,
         strokewidth: 6)
		 
	
  #app name
  stack(margin_left: 12,margin_top:10) do
    @AppName = para "Student Schedule Builder"
    @AppName.style(stroke: darkblue,:align=>"center"  ,font: "Verdana Italic 24px" )
  end
  
  
  #uoit logo image
  stack(margin_left: '45%',margin_bottom:10) do
    @img = image 'uoit-logo.jpg'
    @img.style(height:50,width:80,:align=>"center")
  end
  
  
  #app information and instructions
  stack(margin_left: 12) do
    button "Info",:margin_left => '45%' do
      alert "Student Schedule Builder App   
	  \n       Enter course code and click -Get schedule- button to display schedule.    
	  \n       To view course schedule for course:
	  \n           -Enter course code(CSCI 3055U)   
	  OR\n          -Enter all for all course schedules    
	  OR\n          -Enter program code (CSCI or SOFE) for all program course schedules 
	  \n\n     After viewing the schedule output:
	  \n         -User can enter schedules lines number such as 1,2,5 
	  \n                 and click -Save schedule- to CSV file- button to save to CSV file 
	  \n         -CSV file can be imported to Google Calender and used as schedule for first week of classes
	  \n         -User can manually edit each events to repat on Google Calender
	  \n\nDeveloped by: Khirthana Subramanian 100453865"
    end
  end
  
  
    
    stack(margin: 12) do
		flow do
		  para "Enter course code (ie: CSCI 3055U): ",stroke: midnightblue
		  
		  #user input for course code is stored in @course_code
		  @course_code = edit_line
		  @course_code.style(width => 100)


		  #when button clicked, schedule is displayed to user
		  button "Get schedule",:width => 100  do
			
			#if user did not enter anything or entered input which is not within course code format
			if (@course_code.text).empty? or (@course_code.text).size>10
			  alert "Enter course code!"
			
			#if user input is "all" then schedule for all courses will be displayed
			elsif (@course_code.text).size<4 and (@course_code.text).eql? "all"
			  #calls method to display schedule
			  @output=get_schedule("")
			  
			  #prints schedule to user
			  @box = para:width => 0.97, :height => 80, :text =>'',:margin_left => '2%',font: "Times 16px" 
			  @box.text= @output
	 
			#if user entered input which is not within course code format
			elsif (@course_code.text).size<4 
				alert "Enter course code!"
				
			#if user input is within course code format
			else
			
			 #calls method to display schedule
			  @output=get_schedule(@course_code.text)

			  if @output.empty?
				alert "Enter valid course code!"
			  else
				#prints schedule to user
				@box = para :width => 0.97, :height => 80, :text =>'',:margin_left => '2%',font: "Times 16px" 
				@box.text= @output
			  end
			 
			end
		  end
		end
  end
  
  
  
  stack(margin: 12) do
    flow do
      para "Enter schedule line number:",stroke: midnightblue
	  
	  #user input for schedule line number is stored in @line_number
      @line_number = edit_line
      @line_number.style(width => 100)
	  
	  #when user click button, then selected schedules will be saved to CSV file
      button "Save schedule to CSV file",:width => 200 do
	  
	   #calls method to save selected schedule to CSV file
	   save_schedule(@line_number.text)
	   
      end
    end
  end
  
  
end