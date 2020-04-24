require 'rails_helper'

RSpec.describe "sections/edit", type: :view do
  before(:each) do
    @section = assign(:section, Section.create!(
      :course => "MyString",
      :section => "MyString"
    ))
  end

  it "renders the edit section form" do
    render

    assert_select "form[action=?][method=?]", section_path(@section), "post" do

      assert_select "input#section_course[name=?]", "section[course]"

      assert_select "input#section_section[name=?]", "section[section]"
    end
  end
end
