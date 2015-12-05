
class Api::V1::ApiListingsController < Api::BaseApiController
  protect_from_forgery with: :null_session
  before_filter :find_listing, only: [:show, :update, :delete]

  def index
    render json: Listing.all
  end

  def show
    render json: @listing
  end

  def create
    @listing = Listing.new(listing_params)
    if @listing.save
      render json: @listing
    else
      render nothing: true, status: :bad_request
    end
  end

  def update
    if @listing.update_attributes(listing_params)
      render json: @listing
    else
      render nothing: true, status: :bad_request
    end
  end

   def delete
    if @listing.destroy
      render nothing: true, status: :ok
    else
      render nothing: true, status: :bad_request
    end
  end

  private
    def find_listing
      @listing = Listing.find_by_id(params[:id])
      render nothing: true, status: :not_found unless @listing.present?
    end

    def listing_params
      params.permit(:id, :user, :price, :listing_type,
                                   :postal_code, :status)
    end
end

