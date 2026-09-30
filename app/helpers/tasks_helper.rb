module TasksHelper
  def priority_label(priority)
    case priority
    when "low"
      "Thấp"
    when "medium"
      "Vừa"
    when "high"
      "Cao"
    else
      "Không xác định"
    end
  end
end