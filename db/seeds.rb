kitsu = Client.create!(
  name: 'Kitsu',
  description: 'The Official Kitsu Website and Apps',
  homepage: 'https://kitsu.io',
  owner_id: 2, # Josh
  permissions: 1
)

puts "Kitsu Application:"
puts "    key: #{kitsu.key}"
puts " secret: #{kitsu.secret}"
