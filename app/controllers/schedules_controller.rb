class SchedulesController < ApplicationController
  include SchedulesHelper
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  # GET /schedules
  # GET /schedules.json
  def index
    @schedules = Schedule.all
  end

  # GET /schedules/1
  # GET /schedules/1.json
  def show
  end

  def execute
    Schedule.delete_all()
    start = Time.now
    p "Staring a new schedule"

    generate_schedules()
    enroll_students()

    finish = Time.now
    diff = finish - start

    p "create_new_schedule: " + diff.to_s

    respond_to do |format|
      format.html { redirect_to schedules_url, notice: 'Schedule was successfully created. Time: ' + diff.to_s }
      format.json { render :show, status: :created, location: @schedules }
    end
  end

  # GET /schedules/new
  def new
    @schedule = Schedule.new
  end

  # GET /schedules/1/edit
  def edit
  end

  # POST /schedules
  # POST /schedules.json
  def create
    @schedule = Schedule.new(schedule_params)

    respond_to do |format|
      if @schedule.save
        format.html { redirect_to @schedule, notice: 'Schedule was successfully created.' }
        format.json { render :show, status: :created, location: @schedule }
      else
        format.html { render :new }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schedules/1
  # PATCH/PUT /schedules/1.json
  def update
    respond_to do |format|
      if @schedule.update(schedule_params)
        format.html { redirect_to @schedule, notice: 'Schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @schedule }
      else
        format.html { render :edit }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.json
  def destroy
    @schedule.destroy
    respond_to do |format|
      format.html { redirect_to schedules_url, notice: 'Schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def schedule_params
      params.require(:schedule).permit(:time, :room_id, :course_id)
    end
end
