require 'rails_helper'

RSpec.describe "students/show", type: :view do
  before(:each) do
    @student = assign(:student, Student.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Gender/)
    expect(rendered).to match(/Ethnicity/)
    expect(rendered).to match(/Topics/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Electives/)
    expect(rendered).to match(/Preferences/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
