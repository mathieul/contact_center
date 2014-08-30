FactoryGirl.define do
  factory :call, class: ContactCenter::Call do
    sequence(:sid, 1_000_000) { |n| n.to_s(16) }
  end
end
