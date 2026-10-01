require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "requires a title" do
    task = Task.new(title: "", priority: "medium")

    assert_not task.valid?
    assert_includes task.errors[:title], "can't be blank"
  end

  test "only accepts known priorities" do
    task = Task.new(title: "Test task", priority: "urgent")

    assert_not task.valid?
  end

  test "detects an overdue active task" do
    task = Task.new(title: "Old task", priority: "high", due_date: Date.current - 1.day)

    assert task.overdue?
    task.completed = true
    assert_not task.overdue?
  end

  test "searches title and notes case insensitively" do
    title_match = Task.create!(title: "Chuẩn bị Sprint Alpha", priority: "high")
    notes_match = Task.create!(title: "Gọi khách hàng", notes: "Trao đổi về sprint alpha", priority: "medium")
    Task.create!(title: "Mua cà phê", priority: "low")

    assert_equal [title_match, notes_match].sort, Task.matching("SPRINT ALPHA").sort
  end

  test "treats SQL wildcards as regular search characters" do
    literal_match = Task.create!(title: "Hoàn thành 100%", priority: "medium")
    Task.create!(title: "Công việc khác", priority: "low")

    assert_equal [literal_match], Task.matching("100%")
  end
end
