# Basic test requires
require 'minitest/autorun'
require 'minitest/pride'
require 'bundler/setup'
require 'active_record'
require 'pry'
# Include both the migration and the app itself
require './migration'
require './application'

# Overwrite the development database connection with a test connection.
ActiveRecord::Base.establish_connection(
adapter:  'sqlite3',
database: 'test.sqlite3'
)

# Gotta run migrations before we can run tests.  Down will fail the first time,
# so we wrap it in a begin/rescue.
begin ApplicationMigration.migrate(:down)
rescue
end
ApplicationMigration.migrate(:up)


# Finally!  Let's test the thing.
class ApplicationTest < Minitest::Test

  def test_truth
    assert true
  end

  def test_lesson_destruction_equals_reading_annahilation
    a = Lesson.create!(name: "hi")
    b = Reading.create!(lesson_id: "this one", caption: "oops")
    a.delete
    assert_equal false, b.id == nil
  end

  def test_course_destruction_equals_lesson_annahilation
    c = Course.create!(name: "anatomy")
    d = Lesson.create!(name: "head")
    c.delete
    assert_equal false, d.name == nil
  end

  def test_course_contains_instructors_then_immune

  end

  def test_lessons_contains_inclass_assignments_and_vice_versa

  end

  def test_course_has_readings_within_course_lessons
    course_1 = Course.create!(name: "History")
    lesson_1 = Lesson.create!(name: "To be or not to be")
    readings_1 = Reading.create!(lesson_id: lesson_1.id, caption: "Civil")
    lesson_1.readings << (readings_1)
    course_1.lessons << (lesson_1)
    binding.pry
    assert_equal course_1.readings, [readings_1]
  end

  def test_school_must_have_name
    school_2 = School.create!(name: "New")
    assert_equal false, school_2.id == nil
    assert_raises(StandardError) do
      school_1 = School.create!
    end
  end

  def test_terms_contains_name_startson_endson_schoolid
    y = Term.create!(name: "1", starts_on: "2/2/22", ends_on: "1/1/11", school_id:"xxx")
    assert_equal false, y.name == nil
    assert_equal false, y.starts_on == nil
    assert_equal false, y.ends_on == nil
    assert_equal false, y.school_id == nil
    assert_raises(StandardError) do
      x = Term.create!
    end
  end

  def test_user_contains_firstname_lastname_email
    user_1 = User.create(first_name: "john")
    user_2 = User.create(last_name: "doe")
    user_3 = User.create(email: "generic")
    user_4 = User.create
    assert_equal false, user_1.first_name == nil
    assert_equal false, user_2.last_name == nil
    assert_equal false, user_3.email == nil
    assert_equal true, user_4.first_name == nil
    assert_equal true, user_4.last_name == nil
    assert_equal true, user_4.id == nil
  end

  def test_user_email_is_unique
    user_5 = User.create!(first_name: "ray", last_name: "fin", middle_name: "a", email: "http://alpha@mail.com", photo_url: "https://suck@suckage.suckmore")
    assert_equal user_5.email, "http://alpha@mail.com"
    assert_raises(StandardError) do
    user_6 = User.create!(first_name: "dun", last_name: "don", middle_name: "d", email: "http://alpha@mail.com", photo_url: "https://suck@suckage.suckmore")
end


  end

  def test_appropriate_email_form_for_user
    skip
    assert_raises(StandardError) do
    h = User.create!(first_name: "shy", last_name: "in", middle_name: "c", email: "ta.com", photo_url: "https://ay@g.com")
  end

  end

  def test_validate_users_photo_url_begins_with_http_or_https
    n = User.create!(first_name: "hellen", last_name: "deer", middle_name: "s", email: "a@a.com", photo_url: "https://a@g.com")
    assert_equal n.photo_url, "https://a@g.com"
    assert_raises(StandardError) do
      m = User.create!(first_name: "jack", last_name: "dine", middle_name: "t", email: "aat@a.com", photo_url: "m.m.com")
    end
  end

  def test_assignments_contains_courseid_name_percentgrade
    course_3 = Course.create!(name: "other")
    assignment_4 = Assignment.create!(name:"true science", course_id: course_3.id,percent_of_grade: 5)
    assert_equal false, assignment_4 == nil
    assert_raises(StandardError) do
    assignment_1 = Assignment.create!(name: "science")
    assignment_2 = Assignment.create!(course_id: course_3.id)
    assignment_3 = Assignment.create!(percent_of_grade: 1.2)
  end

  end

  def test_assignment_name_unique_for_each_courseid


  end


end
