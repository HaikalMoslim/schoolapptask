class SchoolsController < ApplicationController
  before_action :set_school, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /schools or /schools.json
  def index
    @schools = School.all
    @schools = @schools.search(params[:query]) if params[:query].present?

    # Pagination setup
    @pagy, @paginated_schools = pagy(@schools.reorder(sort_column => sort_direction), items: params.fetch(:count, 10))

    # Retrieve all schools for the map
    @all_schools = @schools
  end

  def sort_column
    %w{id name address link}.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    %w{asc desc}.include?(params[:direction]) ? params[:direction] : "asc"
  end
  # GET /schools/1 or /schools/1.json
  def show
  end

  # GET /schools/new
  def new
    @school = School.new
  end

  # GET /schools/1/edit
  def edit
  end

  # POST /schools or /schools.json
  def create
    @school = School.new(school_params)

    respond_to do |format|
      if @school.save
        format.html { redirect_to school_url(@school), notice: "School was successfully created." }
        format.json { render :show, status: :created, location: @school }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schools/1 or /schools/1.json
  def update
    respond_to do |format|
      if @school.update(school_params)
        format.html { redirect_to school_url(@school), notice: "School was successfully updated." }
        format.json { render :show, status: :ok, location: @school }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schools/1 or /schools/1.json
  def destroy
    @school.destroy!

    respond_to do |format|
      format.html { redirect_to schools_url, notice: "School was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school
      @school = School.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def school_params
      params.require(:school).permit(:name, :address, :city, :state, :link, :latitude, :longitude, :about, :weblink)
    end
end
