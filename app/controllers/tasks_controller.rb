class TasksController < ApplicationController
  before_action :set_task, only: %i[update destroy toggle]

  def index
    @task = Task.new(priority: "medium")
    @filter = params[:filter].presence_in(%w[all active today completed]) || "all"
    @tasks = filtered_tasks.order(completed: :asc, created_at: :desc)
    @total_count = Task.count
    @completed_count = Task.completed.count
    @active_count = @total_count - @completed_count
    @completion_rate = @total_count.zero? ? 0 : ((@completed_count.to_f / @total_count) * 100).round
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to root_path, notice: "Đã thêm công việc mới."
    else
      load_index_data
      render :index, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      redirect_back fallback_location: root_path, notice: "Đã cập nhật công việc."
    else
      redirect_back fallback_location: root_path, alert: @task.errors.full_messages.to_sentence
    end
  end

  def toggle
    completed = !@task.completed?
    @task.update!(completed: completed, completed_at: completed ? Time.current : nil)
    redirect_back fallback_location: root_path
  end

  def destroy
    @task.destroy
    redirect_back fallback_location: root_path, notice: "Đã xóa công việc."
  end

  def clear_completed
    removed_count = Task.completed.delete_all
    redirect_to root_path, notice: "Đã dọn #{removed_count} công việc hoàn thành."
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :notes, :priority, :due_date, :image)
  end

  def filtered_tasks
    case @filter
    when "active" then Task.active
    when "today" then Task.active.due_today
    when "completed" then Task.completed
    else Task.all
    end
  end

  def load_index_data
    @filter = "all"
    @tasks = Task.order(completed: :asc, created_at: :desc)
    @total_count = Task.count
    @completed_count = Task.completed.count
    @active_count = @total_count - @completed_count
    @completion_rate = @total_count.zero? ? 0 : ((@completed_count.to_f / @total_count) * 100).round
  end
end
