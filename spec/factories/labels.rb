FactoryBot.define do
  factory :label do
    name { "喜" }
  end

  factory :label2, class: Label do
    name { "怒" }
  end

  factory :label3, class: Label do
    name { "哀" }
  end
end