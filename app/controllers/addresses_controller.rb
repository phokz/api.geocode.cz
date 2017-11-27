class AddressesController < ApplicationController
  def autocomplete
    result = Address.autocomplete(params[:term])
    render json: result.map { |a| render_item(a) }
  end

  def show
    address = Address.find(params[:id])
    render json: render_item(address)
  end

  private

  def render_item(a)
    {
      id: a.id,
      address: a.address,
      street: a.street.nil? ? nil :  a.street.name,
      number: a.number,
      evidence: a.evidence,
      orient: a.orient,
      postcode: a.postcode.number,
      city: a.city.name,
      city_part: a.city_part.nil? ? nil : a.city_part.name
    }
  end
end
