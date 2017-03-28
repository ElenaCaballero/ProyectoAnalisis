module SchedulesHelper
	$times = [7,8,10,11,1,3,5,6]

	def c_exists_in_room?(c)
		#check if the course is in any room
		sch = Schedule.all
		if sch.find(c.id) != nil
			return true
		else
			return false
		end
	end

	def assign_course_to_room(c, e)
		print "Hello"
		#(2)if the course already has a room, check if it collides for the student
		#if it doesn't, assign a room to it
		if c_exists_in_room?(c)
			colliding_times(c, e)
		else
			available_time_of_room(c, e)
		end
	end

	def room_available?(r, time)
		#check if room is available at the time
		v = r.schedules.where(time: time)
    return v.blank? #true: not available, false: available
	end

	def available_time_of_room(c, e)
		#(x) check it there is an available room for the course that doesn't collide
		# with the student's schedule
		Room.all.each do |r|
			$times.each do |t|
				if !room_available?(r, t)
					available_time_for_student(c, t, e, r)
				end
			end
			#colliding_times()
		end
	end

	def student_available?(e, time)
		#check if student is available at the time
		v = e.schedules.where(time: time)
		return v.blank? #true: not available, false: available
	end

	def available_time_for_student(c, t, e, r)
		#(a)check if the time is available for the student
		#if it is add the schedule, if not, check the next
		if !student_available?(e, t)
			Schedule.create!(room: r, course: c, time: t, students: e)
		else
			$times.each_with_index {|t, i|
				if i+1 < $times.count
					sig = $times[i+1]
					available_time_for_student(c, sig, e, r)
				end
			}
		end
	end

	def student_can_take_course(c, e)
		#check if student can take class 
		m = Schedule.find(c.id)
		e.courses.find(c.id).schedules.each do |s|
			if m.time == s.time
				return -1 #they collide
			end
		end
		return m.time, m.room.number #they don't
	end

	def colliding_times(c, e)
		#(y) if class is in room check if student can take class at time
		if student_can_take_course(c, e) != -1
			t, r = student_can_take_course(c, e)
			Schedule.create!(room: r, course: c, time: t, students: e)
		else
			assign_course_to_room(c, e)
		end
	end

	#def other_times_of_other_courses(c, e)
	#	m = Schedule.find(c.id).time
	#	arr = Array.new
	#	Course.all.each do |a|
	#		if m == Schedule.find(a.id).time
	#			a.schedules.each do |d|
	#				arr.push(d.time)
	#			end
	#			return arr 
	#		end
	#	end
	#	return -1
	#end

	#def other_times(c, e)
		#(z) check if course has another available time
		#revisar si la clase que choca del alumno tiene otros horarios que no choquen 
		#si tienen y no chocan
			#cambiar el horario(Schedule) de la otra clase el time y el room
		#si (tienen y chocan) o no tienen
			#se abre un nuevo horario para la clase actual (volver a 2)
	#	arr = other_times_of_other_courses(c, e)
	#	m = e.schedules
	#	continue = 0
	#	time = 0
	#	room = 0
	#	course = 0
	#
	#	if arr.count == 0
	#		continue = 0
	#	else
	#		m.each do |s|
	#			arr.each do |a|
	#				if (s.time == a) 
	#					continue = 0
	#					break
	#				else
	#					time = a
	#					course = get_course_by_time(t)
	#					room = get_room_by_time(t)
	#					continue = 1
	#					break
	#				end
	#			end
	#		end
	#	end
	#	
	#	if continue == 1
			#cambiar el horario(Schedule) de la otra clase el time y el room
	#	elsif continue == 0
	#		assign_course_to_room(c, e)
	#	end
		
	#end

end
