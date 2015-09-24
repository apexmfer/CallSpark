module DemoInventoryHelper

  def inDemoInventorySpace
    controller_name == "demo_inventory" || controller_name == "checkout" || controller_name == "part_detail"
  end


end
