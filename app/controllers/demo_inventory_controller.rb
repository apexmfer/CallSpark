class DemoInventoryController < ApplicationController

  def info
    barcode = params['id'];

    part = Demohardware.where(:barcode => barcode).first

    details = Partdetail.find_by_id(part.product_id);

    description = details.getDescription

    render json: [part,details,description]

  end


end
