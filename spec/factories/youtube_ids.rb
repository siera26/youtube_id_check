# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :youtube_id do
    sequence(:y_id) {|n| "y_id_#{n}"}
    name "Test"
  end
end
