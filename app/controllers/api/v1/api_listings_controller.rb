
class Api::V1::ApiListingsController < Api::BaseApiController
  protect_from_forgery with: :null_session
  before_filter :find_listing, only: [:show, :update, :delete]

  ##
  # Returns the list of all listings
  #
  # GET /api/v1/
  #
  # params:
  #   none
  #
  # = Examples
  #
  #   resp = conn.get("/api/v1/")
  #
  #   resp.code
  #   => 200
  #
  #   resp.body
  #   =>  [
  #          {
  #            "id": 1,
  #            "user": "Shivam Bansal",
  #            "price": 1000000,
  #            "listing_type": "sale",
  #           "postal_code": 440010,
  #            "status": "active",
  #            "created_at": "2015-12-05T13:37:44.540Z",
  #            "updated_at": "2015-12-05T13:37:44.540Z"
  #          }
  #        ]
  #
  def index
    render json: Listing.all
  end

  ##
  # Returns the requested listing
  #
  # GET /api/v1/:id
  #
  # params:
  #   none
  #
  # = Examples
  #
  #   resp = conn.get("/api/v1/1")
  #
  #   resp.code
  #   => 200
  #
  #   resp.body
  #   => 
  #          {
  #            "id": 1,
  #            "user": "Shivam Bansal",
  #            "price": 1000000,
  #            "listing_type": "sale",
  #            "postal_code": 440010,
  #            "status": "active",
  #            "created_at": "2015-12-05T13:37:44.540Z",
  #            "updated_at": "2015-12-05T13:37:44.540Z"
  #          }
  #
  #   resp = conn.get("/api/v1/54")
  #
  #   resp.code
  #   => 404
  #
  #   resp.body
  #   => 
  #
  def show
    render json: @listing
  end

  ##
  # Creates a new listing
  #
  # POST /api/v1/
  #
  # params:
  #   user: string (user should exist in user service db)
  #   price: integer 
  #   listing_type: string ("rent" or "sale")
  #   postal_code: integer
  #   status: string ("active" or "closed" or "deleted")
  #
  # = Examples
  #
  #   resp = conn.post("/api/v1/?user=Shivam Bansal&price=1000000&listing_type=sale&postal_code=440010&status=active")
  #
  #   resp.code
  #   => 200
  #
  #   resp.body
  #   => 
  #          {
  #            "id": 1,
  #            "user": "Shivam Bansal",
  #            "price": 1000000,
  #            "listing_type": "sale",
  #            "postal_code": 440010,
  #            "status": "active",
  #            "created_at": "2015-12-05T13:37:44.540Z",
  #            "updated_at": "2015-12-05T13:37:44.540Z"
  #          }
  #
  #   resp = conn.post("/api/v1/1/?user=Shiva&price=1000000&listing_type=sale&postal_code=440010&status=active")
  #
  #   resp.code
  #   => 400
  #
  #   resp.body
  #   => 
  #
  def create
    @listing = Listing.new(listing_params)
    if @listing.save
      render json: @listing
    else
      render nothing: true, status: :bad_request
    end
  end

  ##
  # Updates the requested listing
  #
  # PUT /api/v1/:id
  #
  # params:
  #   user: string (user should exist in user service db)
  #   price: integer 
  #   listing_type: string ("rent" or "sale")
  #   postal_code: integer
  #   status: string ("active" or "closed" or "deleted")
  #
  # = Examples
  #
  #   resp = conn.put("/api/v1/1/?user=Shivam Bansal&price=1000000&listing_type=sale&postal_code=440010&status=active")
  #
  #   resp.code
  #   => 200
  #
  #   resp.body
  #   => 
  #          {
  #            "id": 1,
  #            "user": "Shivam Bansal",
  #            "price": 1000000,
  #            "listing_type": "sale",
  #            "postal_code": 440010,
  #            "status": "active",
  #            "created_at": "2015-12-05T13:37:44.540Z",
  #            "updated_at": "2015-12-05T13:37:44.540Z"
  #          }
  #
  #   resp = conn.put("/api/v1/54?user=Shivam Bansal&price=1000000&listing_type=sale&postal_code=440010&status=active")
  #
  #   resp.code
  #   => 404
  #
  #   resp.body
  #   => 
  #
  #   resp = conn.put("/api/v1/1/?user=Shiva&price=1000000&listing_type=sale&postal_code=440010&status=active")
  #
  #   resp.code
  #   => 400
  #
  #   resp.body
  #   => 
  #
  def update
    if @listing.update_attributes(listing_params)
      render json: @listing
    else
      render nothing: true, status: :bad_request
    end
  end

  ##
  # Deletes the requested listing
  #
  # DELETE /api/v1/:id
  #
  # params:
  #   none
  #
  # = Examples
  #
  #   resp = conn.delete("/api/v1/2")
  #
  #   resp.code
  #   => 200
  #
  #   resp.body
  #   => 
  #
  #   resp = conn.delete("/api/v1/54")
  #
  #   resp.code
  #   => 404
  #
  #   resp.body
  #   => 
  #
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

