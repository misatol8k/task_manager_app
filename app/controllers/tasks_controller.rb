class TasksController < ApplicationController
  before_action :login_required
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:task].present? && params[:task][:label_id].present?
      @labels = Labeling.where(label_id: params[:task][:label_id]).pluck(:task_id)
      @tasks = Task.selected.includes(:labels).where(id: @labels).where(user_id: current_user.id).search_name(params[:task][:name]).search_status(params[:task][:status]).page(params[:page])
    elsif params[:task].present?
      @tasks = current_user.tasks.selected.includes(:labels).search_name(params[:task][:name]).search_status(params[:task][:status]).page(params[:page])
    else
      @tasks = current_user.tasks.selected.includes(:labels).order(created_at: :desc).page(params[:page])
    end
    if params[:sort_expired]
      @tasks = current_user.tasks.selected.includes(:labels).sort_end_date.page(params[:page])
    elsif params[:sort_priority]
      @tasks = current_user.tasks.selected.includes(:labels).sort_priority.page(params[:page])
    else
      @tasks = current_user.tasks.selected.includes(:labels).order(created_at: :desc).page(params[:page])
    end
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)
    if params[:back]
      render :new
    elsif @task.save
      redirect_to tasks_url, notice: t('view.create_notice')
    else
      render :new
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: t('view.destroy_notice', name: @task.name)
  end

  def edit
  end

  def show
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_url, notice: t('view.update_notice')
    else
      render :edit
    end
  end

  private

  def set_task
    @task = current_user.tasks.includes(:labels).find(params[:id])
  end

  def task_params
    params.required(:task).permit(:name, :content, :end_date, :status, :priority, :id, :user_id, {label_ids: []} )
  end
end
