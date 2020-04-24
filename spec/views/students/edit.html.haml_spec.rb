require 'rails_helper'

RSpec.describe "students/edit", type: :view do
  before(:each) do
    @student = assign(:student, Student.create!(
      first_name: "MyString",
      last_name: "MyString",
      email: "MyString",
      gender: "MyString",
      ethnicity: "MyString",
      topics: "MyString",
      hardware: false,
      electives: "MyString",
      preferences: "MyString",
      section: nil,
      project: nil
    ))
  end

  it "renders the edit student form" do
    render

    assert_select "form[action=?][method=?]", student_path(@student), "post" do

      assert_select "input#student_first_name[name=?]", "student[first_name]"

      assert_select "input#student_last_name[name=?]", "student[last_name]"

      assert_select "input#student_email[name=?]", "student[email]"

      assert_select "input#student_gender[name=?]", "student[gender]"

      assert_select "input#student_ethnicity[name=?]", "student[ethnicity]"

      assert_select "input#student_topics[name=?]", "student[topics]"

      assert_select "input#student_hardware[name=?]", "student[hardware]"

      assert_select "input#student_electives[name=?]", "student[electives]"

      assert_select "input#student_preferences[name=?]", "student[preferences]"

      assert_select "input#student_section_id[name=?]", "student[section_id]"

      assert_select "input#student_project_id[name=?]", "student[project_id]"
    end
  end
end
