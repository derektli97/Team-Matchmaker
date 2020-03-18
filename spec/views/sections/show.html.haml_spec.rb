require 'rails_helper'

RSpec.describe "sections/show", type: :view do
  before(:each) do
    @section = assign(:section, Section.create!(
      :course => "Course",
      :section => "Section"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Course/)
    expect(rendered).to match(/Section/)
  end
end
