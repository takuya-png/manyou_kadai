FactoryBot.define do
  factory :task do
    title { 'test_title' }
    content { 'test_content' }
  end
  factory :task2, class: Task do
    title { 'test_title2' }
    content { 'test_content2' }
  end
  factory :task3, class: Task do
    title { 'test_title3' }
    content { 'test_content3' }
  end
end