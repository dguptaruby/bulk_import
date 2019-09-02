require 'csv'
require 'activerecord-import'
class HomeController < ApplicationController
  before_action :file_type, only: [:import_csv]

  def index
  end

  def import_csv  
    @company = Company.find_by(id: params[:company_id])
    if @type == 'csv'
      employees = Employee.csv_generate(params[:file], @company)
      respond_to do |format|
        if employees.present?
          format.csv { redirect_to root_path, notice: 'Csv import successfully.' }
          format.js { redirect_to root_path, notice: 'Csv import successfully.' }
        else
          format.csv { redirect_to root_path, notice: 'Csv is already imported.' }
          format.js { redirect_to root_path, notice: 'Csv is already imported.' }
        end
      end
    else 
      respond_to do |format|
        format.csv { redirect_to root_path, notice: 'File is not CSV' }
        format.js { redirect_to root_path, notice: 'File is not CSV' }
      end
    end
  end

  private

  def file_type
    @type = params[:file].path.split('.').last.to_s.downcase
  end
end
