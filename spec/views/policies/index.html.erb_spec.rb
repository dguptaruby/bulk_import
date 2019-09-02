require 'rails_helper'

RSpec.describe "policies/index", :type => :view do
  before(:each) do
    assign(:policies, [
      Policy.create!(
        :name => "Name4",
        :company_id => Company.create(name: "test").id
      ),
      Policy.create!(
        :name => "Name1",
        :company_id => Company.create(name: "test").id
      )
    ])
  end

  it "renders a list of policies" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 0
    assert_select "tr>td", :text => nil.to_s, :count => 0
  end
end
