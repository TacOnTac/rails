class PagesController < ApplicationController
  before_action :set_page, only: %i[ show edit update destroy ]

  # GET /pages or /pages.json
  def index
    if params[:category_id] != nil
      @pages = Page.where(category_id: params[:category_id])
    else
      @pages = Page.all.with_attached_image
    end

    @categories = Category.all
    page = Page.find(1)
  end

  # GET /pages/1 or /pages/1.json
  def show
  end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages or /pages.json
  def create
    @page = Page.new(page_params)
    @page.image.attach(params[:page][:image])

    respond_to do |format|
      if @page.save
        format.html { redirect_to page_url(@page), notice: "Page was successfully created." }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1 or /pages/1.json
  def update
    respond_to do |format|
      if @page.update(page_params)
        @page.image.attach(params[:page][:image]) if params[:page][:image]

        format.html { redirect_to page_url(@page), notice: "Page was successfully updated." }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1 or /pages/1.json
  def destroy
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url, notice: "Page was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def page_params
      params.require(:page).permit(:content, :nom, :titre, :slug, :image, :category_id, :country_id)
    end
end
