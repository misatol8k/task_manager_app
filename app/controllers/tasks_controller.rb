class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:task].present?
      if params[:task][:name].present? && params[:task][:status].present?
        # SQLインジェクションの対応する search_name_status
        @tasks = Task.search_name(params[:task][:name]).search_status(params[:task][:status])
      elsif params[:task][:name].present?
        @tasks = Task.search_name(params[:task][:name])
      elsif params[:task][:status].present?
        @tasks = Task.search_status(params[:task][:status])
      end
    elsif params[:sort_expired]
      @tasks = Task.all.sort_end_date
    else
      @tasks = Task.all.order(created_at: :desc)
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
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
      redirect_to tasks_url, notice: t('view.uptade_notice')
    else
      render :edit
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.required(:task).permit(:name, :content, :end_date, :status, :priority, :id,)
  end
end
