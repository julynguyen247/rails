require "test_helper"

class TasksHelperTest < ActionView::TestCase
  test "translates task priorities into Vietnamese" do
    assert_equal "Thấp", priority_label("low")
    assert_equal "Vừa", priority_label("medium")
    assert_equal "Cao", priority_label("high")
  end

  test "returns a fallback for an unknown priority" do
    assert_equal "Không xác định", priority_label("something-else")
  end
end
