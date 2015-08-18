class PlacesController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy, :upvote, :downvote]

  # def index
  #   # @places = Place.all.page(params[:page]).per(3)
  #   @places = Place.search(params[:search])
  # end

  def index
  @places = Place.search(params[:search])
    if @places.class == Array
      @places = Kaminari.paginate_array(@posts).page(params[:page]).per(3) 
    else
      @places = @places.page(params[:page]).per(3) # if @posts is AR::Relation object 
    end
  end

  def new
    @place = Place.new
  end

  def create
    @place = current_user.places.create(place_params)
    if @place.valid?
      redirect_to root_path
    else
      render :new, :status => :unprocessable_entity
    end
  end

  def show
    @place = Place.find(params[:id])
    @comment = Comment.new
    @photo = Photo.new
  end

  def edit
    @place = Place.find(params[:id])

    if @place.user != current_user
      return render :text => 'Not Allowed', :status => :forbidden
    end  
  end

  def update
    @place = Place.find(params[:id])

    if @place.user != current_user
      return render :text => 'Not Allowed', :status => :forbidden
    end

    @place.update_attributes(place_params)
    if @place.valid?
      redirect_to root_path
    else
      render :edit, :status => :unprocessable_entity
    end
  end

  def destroy
    @place = Place.find(params[:id])
    if @place.user != current_user
      return render :text => 'Not Allowed', :status => :forbidden
    end

    @place.destroy
    redirect_to root_path
  end


  def upvote
    @place = Place.find(params[:id])
    @place.liked_by current_user
    redirect_to :back
  end

  def downvote
    @place = Place.find(params[:id])
    @place.downvote_from current_user
    redirect_to :back
  end


  private

  def place_params
    params.require(:place).permit(:name, :address, :description)
  end
end
