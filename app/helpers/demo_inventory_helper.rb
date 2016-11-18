module DemoInventoryHelper



    def all_barcodes_for_autocomplete

      list = [];

          Demohardware.all.each do |c|
                list << { value:  c.id   , label:   c.barcode  }
            end

      return list.to_json

    end

    def all_catalog_numbers_for_autocomplete

      list = [];

          Partdetail.all.each do |c|
                list << { value:  c.id   , label:   c.catalog_number  }
            end

      return list.to_json

    end



end
