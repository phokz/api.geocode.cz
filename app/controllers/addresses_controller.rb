class AddressesController < ApplicationController
  before_action :set_cors_header

  def autocomplete
    result = Address.autocomplete(params[:term])
    render json: result.map { |a| render_item(a) }
  end

  def show
    address = Address.find(params[:id])
    coords = Coord.find_by(id: params[:id])
    render json: render_item(address, coords)
  end

  private

  def render_item(a, coords=nil)
    {
      id: a.id,
      address: a.address,
      street: a.street.nil? ? nil : a.street.name,
      number: a.number,
      evidence: a.evidence,
      orient: a.orient,
      postcode: a.postcode.number,
      city: a.city.name,
      city_part: a.city_part.nil? ? nil : a.city_part.name,
      coordinates: render_coords(coords)
    }
  end

  def render_coords(coords)
    return nil if coords.nil?
    {
      jstk: {x: coords.x.to_f, y: coords.y.to_f}
    }
  end

  def set_cors_header
    response.headers['Access-Control-Allow-Origin'] = '*'
  end
end
