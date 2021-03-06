require 'rails_helper'

RSpec.describe "policies/show", :type => :view do
  before(:each) do
    @policy = assign(:policy, Policy.create!(
      :name => "Name",
      :company_id => Company.create(name: "test").id
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
  end
end
