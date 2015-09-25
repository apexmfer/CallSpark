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






end
