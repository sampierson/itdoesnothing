# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :unconfirmed_user, :class => User do
    email
    password "secret"
  end

  factory :confirmed_user, :parent => :unconfirmed_user do
    confirmed_at Time.now
  end

  factory :admin_user, :parent => :confirmed_user do
    roles ['admin']
  end
end
