Fabricator(:video) do
  title { Faker::Lorem.words(1).join('') }
  description { Faker::Lorem.paragraphs(1).join('') }
  category_id { Fabricate(:category).id }
end
