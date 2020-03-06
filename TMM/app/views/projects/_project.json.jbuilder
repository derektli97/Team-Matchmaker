json.extract! project, :id, :title, :description, :max_group_size, :min_group_size, :topics, :hardware, :industry_sponsored, :client, :created_at, :updated_at
json.url project_url(project, format: :json)
