require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = Task.create!(title: "Việc cần làm", priority: "medium")
  end

  test "shows the dashboard" do
    get root_url

    assert_response :success
    assert_select "h1", "Làm việc nhẹ đầu hơn."
    assert_select ".task-item", minimum: 1
  end

  test "searches tasks while keeping the selected filter" do
    completed_match = Task.create!(title: "Báo cáo tháng", priority: "high", completed: true)
    Task.create!(title: "Báo cáo tuần", priority: "medium", completed: false)

    get root_url, params: { filter: "completed", q: "báo cáo" }

    assert_response :success
    assert_select ".task-item", count: 1
    assert_select ".task-item h3", text: completed_match.title
    assert_select "input[name='q'][value='báo cáo']"
    assert_select ".filter-chip.is-active", text: /Đã xong/
  end

  test "shows a search-specific empty state" do
    get root_url, params: { q: "không tồn tại" }

    assert_response :success
    assert_select ".task-item", count: 0
    assert_select ".empty-state h3", "Không tìm thấy công việc"
  end

  test "creates a task" do
    assert_difference("Task.count", 1) do
      post tasks_url, params: { task: { title: "Việc mới", priority: "high" } }
    end

    assert_redirected_to root_url
  end

  test "creates a task with an image" do
    image = fixture_file_upload(Rails.root.join("public/apple-touch-icon.png"), "image/png")

    assert_difference(["Task.count", "ActiveStorage::Attachment.count"], 1) do
      post tasks_url, params: { task: { title: "Việc có ảnh", priority: "medium", image: image } }
    end

    assert Task.order(:created_at).last.image.attached?
  end

  test "toggles a task" do
    patch toggle_task_url(@task)

    assert @task.reload.completed?
    assert_not_nil @task.completed_at
  end

  test "deletes a task" do
    assert_difference("Task.count", -1) { delete task_url(@task) }
  end
end
