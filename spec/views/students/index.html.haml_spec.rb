require 'rails_helper'

RSpec.describe "students/index", type: :view do
  before(:each) do
    assign(:students, [
      Student.create!(
        first_name: "First Name",
        last_name: "Last Name",
        email: "Email",
        gender: "Gender",
        ethnicity: "Ethnicity",
        topics: "Topics",
        hardware: false,
        electives: "Electives",
        preferences: "Preferences",
        section: nil,
        project: nil
      ),
      Student.create!(
        first_name: "First Name",
        last_name: "Last Name",
        email: "Email",
        gender: "Gender",
        ethnicity: "Ethnicity",
        topics: "Topics",
        hardware: false,
        electives: "Electives",
        preferences: "Preferences",
        section: nil,
        project: nil
      )
    ])
  end

  it "renders a list of students" do
    render
    assert_select "tr>td", text: "First Name".to_s, count: 2
    assert_select "tr>td", text: "Last Name".to_s, count: 2
    assert_select "tr>td", text: "Email".to_s, count: 2
    assert_select "tr>td", text: "Gender".to_s, count: 2
    assert_select "tr>td", text: "Ethnicity".to_s, count: 2
    assert_select "tr>td", text: "Topics".to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: "Electives".to_s, count: 2
    assert_select "tr>td", text: "Preferences".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
