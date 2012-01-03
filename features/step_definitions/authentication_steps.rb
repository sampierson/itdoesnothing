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

Given /^that user "([^"]*)" has role "([^"]*)"$/ do |email, role|
  user = User.find_by_email(email)
  user.roles << role
  user.save!
end

Given /^that user "([^"]*)" has attempted to login (\d+) times$/ do |email, login_attempts|
  User.find_by_email(email).update_attribute(:failed_attempts, login_attempts)
end

Given /^that user "([^"]*)" is locked$/ do |email|
  user = User.find_by_email(email)
  user.lock_access! unless user.access_locked?
end

Given /^(?:|I )sign out/ do
  click_link('settings')
  click_link('Sign out')
end

Given /^(?:|I )attempt to sign up as "([^"]*)" with password "([^"]*)"/ do |email, password|
  visit path_to('the home page')
  click_link('Sign up')
  fill_in('Email', :with => email)
  fill_in('Password', :with => password)
  fill_in('Password confirmation', :with => password)
  click_button('Sign up')
end

Given /^(?:|I )attempt to sign in as "([^"]*)" with password "([^"]*)"/ do |email, password|
  visit path_to('the home page')
  click_link('Sign in')
  fill_in('Email', :with => email)
  fill_in('Password', :with => password)
  click_button('Sign in')
end

Given /^(?:|I )sign in as "([^"]*)" with password "([^"]*)"/ do |email, password|
  visit path_to('the home page')
  click_link('Sign in')
  fill_in('Email', :with => email)
  fill_in('Password', :with => password)
  click_button('Sign in')
  page.should have_content("Signed in successfully")
end

Given /^site availability is set to "([^"]*)"/ do |availability_level|
  AppConfiguration.instance.update_attribute :site_availability, ("SiteAvailability::" + availability_level.upcase.gsub(" ", "_")).constantize
end

Then /^(?:|I )should be signed in$/ do
  page.should have_content("Sign out")
end

Then /^(?:|I )should be signed out$/ do
  page.should have_content("Sign in")
end
