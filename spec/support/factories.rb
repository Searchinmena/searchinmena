FactoryGirl.define do
  factory :user do
    email 'aliciaflorrick@email.com'
    password 'voteforalicia'
    password_confirmation 'voteforalicia'
    category :seller
  end
end
