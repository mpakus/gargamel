class Users::ItemsPaymentsController < ApplicationController

  def index
    @payments = current_user.payments

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @payments }
    end
  end

  def show
    @payment = current_user.payments.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @payment }
    end
  end

  def new
    @payment = current_user.payments.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

#TODO !!!!!!
  def edit
    #@item = Item.find(params[:id])
    @item = current_user.items.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    #@item = Item.new(params[:item])
    @item = current_user.items.create(params[:item])

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
    #@item = Item.find(params[:id])
    @item = current_user.items.find(params[:id])

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
    @item = current_user.items.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end

end
