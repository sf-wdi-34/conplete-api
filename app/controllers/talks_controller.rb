class TalksController < ApplicationController
  before_action :set_conference
  before_action :set_talk, only: [:show, :edit, :update, :destroy]

  # GET /conference/1/talks
  # GET /conference/1/talks.json
  def index
    @talks = @conference.talks
  end

  # GET /conference/1/talks/2
  # GET /conference/1/talks/2.json
  def show
  end

  # GET /conference/1/talks/new
  def new
    @talk = Talk.new
  end

  # GET /conference/1/talks/2/edit
  def edit
  end

  # POST /conference/1/talks
  # POST /conference/1/talks.json
  def create
    @talk = Talk.new(talk_params)

    respond_to do |format|
      if @talk.save
        @conference.talks << @talk
        format.html { redirect_to conference_talk_path(@conference, @talk), notice: 'Talk was successfully created.' }
        format.json { render :show, status: :created, location: @talk }
      else
        format.html { render :new }
        format.json { render json: @talk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conference/1/talks/2
  # PATCH/PUT /conference/1/talks/2.json
  def update
    respond_to do |format|
      if @talk.update(talk_params)
        format.html { redirect_to conference_talk_path(@conference, @talk), notice: 'Talk was successfully updated.' }
        format.json { render :show, status: :ok, location: @talk }
      else
        format.html { render :edit }
        format.json { render json: @talk.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conference/1/talks/2
  # DELETE /conference/1/talks/2.json
  def destroy
    @talk.destroy
    respond_to do |format|
      format.html { redirect_to conference_talks_path(@conference), notice: 'Talk was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conference
      @conference = Conference.find(params[:conference_id])
    end

    def set_talk
      @talk = Talk.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def talk_params
      params.require(:talk).permit(:title, :speaker_name, :start_time, :end_time, :conference_id)
    end
end
