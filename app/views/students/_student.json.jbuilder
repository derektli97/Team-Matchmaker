json.extract! student, :id, :first_name, :last_name, :email, :gender, :ethnicity, :topics, :hardware, :electives, :preferences, :section_id, :project_id, :created_at, :updated_at
json.url student_url(student, format: :json)
