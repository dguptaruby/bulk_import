require 'rails_helper'

RSpec.describe "employees/index", :type => :view do
  before(:each) do
    assign(:employees, [
      Employee.create!(
        :name => "test2",
        :email => "test1@gmail.com",
        :phone => "1234567890",
        :company_id => Company.create(name: "test").id
      ),
      Employee.create!(
        :name => "test2",
        :email => "test2@gmail.com",
        :phone => "1234567890",
        :company_id => Company.create(name: "test").id
      )
    ])
  end

  it "renders a list of employees" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 0
    assert_select "tr>td", :text => "Email".to_s, :count => 0
    assert_select "tr>td", :text => "Phone".to_s, :count => 0
    assert_select "tr>td", :text => nil.to_s, :count => 0
  end
end
