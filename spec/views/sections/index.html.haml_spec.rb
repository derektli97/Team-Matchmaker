require 'rails_helper'

RSpec.describe "sections/index", type: :view do
  before(:each) do
    assign(:sections, [
      Section.create!(
        :course => "Course",
        :section => "Section"
      ),
      Section.create!(
        :course => "Course",
        :section => "Section"
      )
    ])
  end

  it "renders a list of sections" do
    render
    assert_select "tr>td", :text => "Course".to_s, :count => 2
    assert_select "tr>td", :text => "Section".to_s, :count => 2
  end
end
