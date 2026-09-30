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
end
