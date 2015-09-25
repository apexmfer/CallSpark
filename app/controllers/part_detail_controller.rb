class PartDetailController < ApplicationController

  skip_before_filter :require_login, only: [:index,:show,:data]

  require 'csv'

  def import

  parts_file_url =  params[:newpart][:parts_csv_file]
  descriptions_file_url =  params[:newpart][:descriptions_csv_file]


  csv_text = File.read(parts_file_url.path)
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|

      partNumber = row.field("CatalogNumber").gsub(/\s+/, "").upcase
      descriptionId = row.field("Description")
      familyId  = row.field("FamilyID")
      typeId  = row.field("TypeID")
      subtypeId  = row.field("SubtypeID")

      matches = Partdetail.where(:catalog_number => partNumber)

      if(matches.empty?)
        Partdetail.create(:catalog_number => partNumber, :description => descriptionId, :familyID => familyId, :typeID => typeId, :subtypeID => subtypeId)
        p partNumber
      end

  end


  ProductDescriptions.delete_all


  csv_text = File.read(descriptions_file_url.path)
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|


      id = row.field(0)

      if(id)
        id = id.gsub(/\s+/, "").to_i
      end

      text = row.field("Caption")

      existingDescription = ProductDescriptions.find_by_id(id)



      if existingDescription
        item = existingDescription

        else

        item = ProductDescriptions.new
        item.id = id
        end

        # set some values
        item.text = text
        item.save


        p item.id
        p text

  end


  redirect_to '/part_detail', alert: 'Parts created'

  end


  def destroy

    Partdetail.find(params['id']).destroy

     redirect_to '/partdetail/', notice: 'deleted part'
   end

   def info
     partid = params['id'];

     part = Partdetail.find_by_id(partid)



     render json: [part.catalog_number,part.getDescription]

   end


   def create
     # , "newpart"=>{"barcode"=>"grdgr", "catalognumber"=>"drgrdg", "description"=>"drgr"}, "action"=>"create", "controller"=>"partdetail"}




     inputcatalognumber = params['newpart']['catalognumber']

     product = Partdetail.where(:catalog_number => inputcatalognumber).first
     if(product == nil)
       product = Partdetail.new(:catalog_number => inputcatalognumber,:description => params['newpart']['description'])
       product.save
       p "created new hardware type"
      end

     part = Demohardware.new(:product_id => product.id,:barcode => params['newpart']['barcode'],:series => params['newpart']['series'])
     part.save

     redirect_to '/partdetail/'
   end




end
