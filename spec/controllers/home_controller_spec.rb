require 'rails_helper'

RSpec.describe HomeController, :type => :controller do
  # before :each do
  #   @file = fixture_file_upload('./spec/fixtures/valid_sample.csv', 'text/csv')
  # end
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'POST import_csv' do
    it 'import csv in file' do
      path = "./spec/fixtures/valid_sample.csv"
      params = {format: :csv, company_id: Company.first.id ,"file" => Rack::Test::UploadedFile.new(path, 'application/csv', true) }
      post :import_csv, :params => params
      expect(response.header['Content-Type']).to include 'text/csv'
      expect(response.status).to eq(302)
      expect(Employee.count).to eq(3)
      expect(flash[:notice]).to eq("Csv import successfully.")
    end


    it 'fail to import text in file' do
      path = "./spec/fixtures/sample.txt"
      params = {format: :csv, company_id: Company.first.id ,"file" => Rack::Test::UploadedFile.new(path, 'application/csv', true) }
      post :import_csv, :params => params
      expect(response.status).to eq(302)
      expect(flash[:notice]).to eq("File is not CSV")
    end
  end
end
