class KicksController < ApplicationController
  before_action :set_kick, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:new, :edit, :destroy]

  # GET /kicks
  # GET /kicks.json
  def index
    @kicks = Kick.joins(:offers)


    # Search parameter rules


    #Check if search is empty - if it is, bring back everything
    if params[:search].blank?
      params[:search] ="*"
    end


    #Check if there is a manufacturer param?
    if params[:manufacturer].present?
      #Check it's not blank
      unless params[:manufacturer]['manu'].blank?
        manufacturers = params[:manufacturer]['manu']
        #filter out the emptys
        manufacturers.reject! { |m| m.empty? }
        #if it's blank, fire back 'search everything'
        if manufacturers.blank?
          manufacturers = {not: nil}
        end
      end
    else
      #if there's not a manufacturer param, also search everything
      manufacturers = {not: nil}
    end


    # Search where product type has a value
    #Check if there is a product type param?
    if params[:product_type].present?
      #Check it's not blank
      unless params[:product_type]['prod'].blank?
      product_type = params[:product_type]['prod']
      #filter out the emptys
      product_type.reject! { |m| m.empty? }
      #if it's blank, fire back 'search everything'
      if product_type.blank?
        product_type = {not: nil}
      end
    end
    else
      #if there's not a product_type param, also search everything
      product_type = {not: nil}
    end



    # Search for price range
    #Check if there is a lowest price param?
    if params[:lowest_price].present?
      #Check it's not blank
      unless params[:lowest_price].blank?
        lowest_price = params[:lowest_price]
        #if it's blank, fire back 'search everything'
        if lowest_price.blank?
          lowest_price = 0
        end
      end
    else
      #if there's not a product_type param, also search everything
      lowest_price = 0
    end

    #Check if there is a lowest price param?
    if params[:highest_price].present?
      #Check it's not blank
      unless params[:highest_price].blank?
        highest_price = params[:highest_price]
        #if it's blank, fire back 'search everything'
        if highest_price.blank?
          highest_price = 10000
        end
      end
    else
      #if there's not a product_type param, also search everything
      highest_price = 10000
    end




    @kickssearch = Kick.includes(:offers).search params[:search], where: { manufacturer: manufacturers, product_type: product_type, lowest_price: {gte: lowest_price}, highest_price: {lte: highest_price} },  suggest: true

    # manufacturer: ["Nike", " Vans"]
    #manufacturer: manufacturers, product_type: product_type
    #{lowest_price: {range: {from:20,to:30} }}
    #facets: {lowest_price: {ranges: price_ranges}},


    @kickssuggestions = @kickssearch.suggestions
    @kicksproducttype = Kick.uniq.pluck(:product_type)
    @kicksmanufacturer = Kick.uniq.pluck(:manufacturer)
    @maxprice = Offer.all

    #test = Kick.find(1)
    #@price = @kickssearch.each do |e|
    #  e.offers.price
    #end

    #@price = Offer.where(kick_id: @kicks)

  end

  # GET /kicks/1
  # GET /kicks/1.json
  def show

  end

  # GET /kicks/new
  def new
    @kick = Kick.new
  end

  # GET /kicks/1/edit
  def edit
  end

  # POST /kicks
  # POST /kicks.json
  def create
    @kick = Kick.new(kick_params)

    respond_to do |format|
      if @kick.save
        format.html { redirect_to @kick, notice: 'Kick was successfully created.' }
        format.json { render :show, status: :created, location: @kick }
      else
        format.html { render :new }
        format.json { render json: @kick.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kicks/1
  # PATCH/PUT /kicks/1.json
  def update
    respond_to do |format|
      if @kick.update(kick_params)
        format.html { redirect_to @kick, notice: 'Kick was successfully updated.' }
        format.json { render :show, status: :ok, location: @kick }
      else
        format.html { render :edit }
        format.json { render json: @kick.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kicks/1
  # DELETE /kicks/1.json
  def destroy
    @kick.destroy
    respond_to do |format|
      format.html { redirect_to kicks_url, notice: 'Kick was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kick
      @kick = Kick.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kick_params
      params.require(:kick).permit(:name, :product_type, :manufacturer)
    end
end
