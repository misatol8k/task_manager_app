FactoryBot.define do
  factory :label do
    name { "ラベルa" }
  end
  factory :second_label, class: Label do
    name { "ラベルb" }
  end
  factory :third_label, class: Label do
    name { "ラベルc" }
  end
end
