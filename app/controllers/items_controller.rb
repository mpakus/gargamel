class ItemsController < ApplicationController
  before_filter :sidebar

  def sidebar
    @categories = Category.all
    @items_last = Item.all(:limit => 4)
  end

  def index
    @items = Item.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  def showcategory
    @items = Item.where("category_id = ?", params[:id])
    @c = Category.find(params[:id])
    
    render :template => "items/index.html"
  end

  def show
    @item = Item.find(params[:id])
    @price = "123"#@item.price #TODO
    @name = "werfv"#@item.name
    

    @transaction = PaymentsPl['bank'].new_transaction(:amount => @price, :desc => @name, :client_ip => request.remote_addr, :js => '0')

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end


  def edit
    @item = Item.find(params[:id])
  end


  def create
    @item = Item.new(params[:item])

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end
end
