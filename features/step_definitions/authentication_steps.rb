Given /^that there does not exist a user with email "([^"]*)"$/ do |email|
  User.find_by_email(email).should be_nil
end

Given /^there exists a user with email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  User.find_all_by_email(email).each { |user| user.destroy! }
  User.create! :email => email, :password => password, :password_confirmation => password
end

Given /^that user "([^"]*)" is not confirmed$/ do |email|
  user = User.find_by_email(email)
  user.update_attribute(:confirmed_at, nil) if user.confirmed?
end

Given /^that user "([^"]*)" is confirmed$/ do |email|
  user = User.find_by_email(email)
  user.confirm! unless user.confirmed?
end

Given /^that user "([^"]*)" has attempted to login (\d+) times$/ do |email, login_attempts|
  User.find_by_email(email).update_attribute(:failed_attempts, login_attempts)
end

Given /^that user "([^"]*)" is locked$/ do |email|
  user = User.find_by_email(email)
  user.lock_access! unless user.access_locked?
end