json.extract! schedule, :id, :time, :room_id, :course_id, :created_at, :updated_at
json.url schedule_url(schedule, format: :json)
