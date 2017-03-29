module SchedulesHelper
	$times = [7,8,10,11,1,3,5,6]

	def generate_schedules()
		sh = Array.new
		courses = Course.all
		contador = 0
		Room.all.each do |room|
			$times.each do |t|
				if contador <= courses.count
					sh << Schedule.new(room: room, course: courses[contador], time: t)
					contador += 1
				end
			end
		end
		sh.each(&:save)
	end

	def enroll_students()
		Student.all.each do |s|
			s.courses.each do |c|
				sche = Schedule.where(course: c).first
				if sche == nil
					break
				end
				can_i_met = true
				s.schedules.each do |stu_sch|
					if stu_sch.time == sche.time
						can_i_met = false
					end
				end
				if can_i_met 
					s.schedules.push(sche)
					s.save
				end
			end
		end
	end
	
end
