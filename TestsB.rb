# Basic test requires
require 'minitest/autorun'
require 'minitest/pride'

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
  end

  def test_course_destruction_equals_lesson_annahilation
  end

  def test_course_contains_instructors_then_immune
  end

  def test_lessons_contains_inclass_assignments_and_vice_versa
  end

  def test_course_has_readings_within_course_lessons
  end

  def test_school_has_name
  end

  def test_terms_contains_name_startson_endson_schoolid
  end

  def test_user_contains_firstname_lastname_email
  end

  def test_user_email_is_unique
  end

  def test_appropriate_email_form_for_user
  end

  def test_validate_users_photo_url_begins_with_http_or_https
  end

  def test_assignments_contains_courseid_name_percentgrade
  end

  def test_assignment_name_unique_for_each_courseid
  end

end
