Task.find_or_create_by!(title: "Lên kế hoạch cho tuần mới") do |task|
  task.notes = "Chọn 3 mục tiêu quan trọng nhất cần hoàn thành."
  task.priority = "high"
  task.due_date = Date.current
end

Task.find_or_create_by!(title: "Đọc 20 trang sách") do |task|
  task.priority = "low"
  task.due_date = Date.current + 1.day
end

Task.find_or_create_by!(title: "Dọn dẹp hộp thư") do |task|
  task.priority = "medium"
  task.completed = true
  task.completed_at = Time.current
end
