require 'rails_helper'

RSpec.describe "sections/new", type: :view do
  before(:each) do
    assign(:section, Section.new(
      :course => "MyString",
      :section => "MyString"
    ))
  end

  it "renders new section form" do
    render

    assert_select "form[action=?][method=?]", sections_path, "post" do

      assert_select "input#section_course[name=?]", "section[course]"

      assert_select "input#section_section[name=?]", "section[section]"
    end
  end
end
