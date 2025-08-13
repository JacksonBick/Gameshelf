# This file seeds the database with initial data for all environments.
# It is idempotent and safe to run multiple times.

sample_games = [
  {
    title: "Zelda: Breath of the Wild",
    platform: "Switch",
    status: "Completed",
    release_date: Date.new(2017, 3, 3),
    rating: 10,
    description: "Open-world adventure in Hyrule.",
    cover_url: "https://example.com/zelda-botw.jpg"
  },
  {
    title: "Elden Ring",
    platform: "PC",
    status: "Playing",
    release_date: Date.new(2022, 2, 25),
    rating: 9,
    description: "Action RPG set in the Lands Between.",
    cover_url: "https://example.com/elden-ring.jpg"
  },
  {
    title: "Hades",
    platform: "Switch",
    status: "Backlog",
    release_date: Date.new(2020, 9, 17),
    rating: 0,
    description: "Rogue-like dungeon crawler.",
    cover_url: "https://example.com/hades.jpg"
  }
]

sample_games.each do |attrs|
  game = Game.find_or_initialize_by(title: attrs[:title], platform: attrs[:platform])
  game.assign_attributes(attrs)
  game.save!
end
