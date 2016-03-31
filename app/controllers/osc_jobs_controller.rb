class OscJobsController < ApplicationController
  before_action :set_osc_job, only: [:show, :edit, :update, :destroy, :submit, :copy]

  # GET /osc_jobs
  # GET /osc_jobs.json
  def index
    @osc_jobs = OscJob.preload(:jobs)
  end

  # GET /osc_jobs/1
  # GET /osc_jobs/1.json
  def show
    @osc_job = OscJob.find(params[:id])
    @osc_job.jobs.last.update_status! unless @osc_job.jobs.last.nil?
  end

  # GET /osc_jobs/new
  def new
    @osc_job = OscJob.new
    @templates = Template.all
  end

  # GET /osc_jobs/1/edit
  def edit
    @templates = Template.all
  end

  # POST /osc_jobs
  # POST /osc_jobs.json
  def create
    # FIXME: web form should create OscJob from params[:path] and optional
    # values like custom script name, host, etc
    @osc_job = OscJob.new(osc_job_params)
    @osc_job.staged_dir = @osc_job.stage.to_s
    new_script_path = Pathname.new(@osc_job.staged_dir).join(@osc_job.staged_script_name).to_s
    @osc_job.script_path = new_script_path

    respond_to do |format|
      if @osc_job.save
        format.html { redirect_to osc_jobs_url, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @osc_job }
      else
        format.html { render :new }
        format.json { render json: @osc_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /osc_jobs/1
  # PATCH/PUT /osc_jobs/1.json
  def update
    respond_to do |format|
      if @osc_job.update(osc_job_params)
        format.html { redirect_to osc_jobs_path, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @osc_job }
      else
        format.html { render :edit }
        format.json { render json: @osc_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /osc_jobs/1/stop
  def stop
    @osc_job = OscJob.find(params[:id])
    @osc_job.jobs.last.update_status!

    respond_to do |format|
      if !@osc_job.submitted?
        format.html { redirect_to osc_jobs_url, alert: 'Job has not been submitted.' }
        format.json { head :no_content }
      elsif @osc_job.stop
        format.html { redirect_to osc_jobs_url, notice: 'Job was successfully stopped.' }
        format.js   { render :show }
        format.json { head :no_content }
      else
        @errors = @osc_job.errors
        format.html { redirect_to osc_jobs_url, alert: "Job failed to be stopped: #{@osc_job.errors.to_a}" }
        format.json { render json: @osc_job.errors, status: :internal_server_error }
      end
    end
  end

  # DELETE /osc_jobs/1
  # DELETE /osc_jobs/1.json
  def destroy
    respond_to do |format|
      if @osc_job.destroy
        format.html { redirect_to osc_jobs_url, notice: 'Job was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to osc_jobs_url, alert: "Job failed to be destroyed: #{@osc_job.errors.to_a}" }
        format.json { render json: @osc_job.errors, status: :internal_server_error }
      end
    end
  end

  # PUT /osc_jobs/1/submit
  # PUT /osc_jobs/1/submit.json
  def submit
    respond_to do |format|
      if @osc_job.submitted?
        format.html { redirect_to osc_jobs_url, alert: 'Job has already been submitted.' }
        format.json { head :no_content }
      elsif @osc_job.submit
        format.html { redirect_to osc_jobs_url, notice: 'Job was successfully submitted.' }
        format.json { head :no_content }
      else
        format.html { redirect_to osc_jobs_url, alert: "Job failed to be submitted: #{@osc_job.errors.to_a}" }
        format.json { render json: @osc_job.errors, status: :internal_server_error }
      end
    end
  end

  # PUT /osc_jobs/1/copy
  def copy
    @osc_job = @osc_job.copy
    @osc_job.staged_dir = @osc_job.stage.to_s

    respond_to do |format|
      if @osc_job.save
        format.html { redirect_to @osc_job, notice: 'Job was successfully copied.' }
        format.json { render :show, status: :created, location: @osc_job }
      else
        format.html { redirect_to osc_jobs_url, alert: "Job failed to be copied: #{@osc_job.errors.to_a}" }
        format.json { render json: @osc_job.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_osc_job
      @osc_job = OscJob.preload(:jobs).find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def osc_job_params
      params.require(:osc_job).permit!
    end
end
