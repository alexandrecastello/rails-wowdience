# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "🌱 Starting database seeding..."

# Clear existing data
Review.destroy_all
EventArtist.destroy_all
Event.destroy_all
Artist.destroy_all
Location.destroy_all
EventType.destroy_all
User.destroy_all

puts "🗑️  Cleared existing data"

# Create Event Types
concert_type = EventType.create!(name: "Concert")
festival_type = EventType.create!(name: "Festival")
theater_type = EventType.create!(name: "Theater")

puts "🎭 Created event types"

# Create Locations
locations = [
  { name: "Allianz Parque", address: "Rua Palestra Itália, 214", city: "São Paulo", state: "SP", country: "Brasil", zipcode: 01234 },
  { name: "Espaço Unimed", address: "Av. Paulista, 2073", city: "São Paulo", state: "SP", country: "Brasil", zipcode: 01311 },
  { name: "Vibra São Paulo", address: "Av. Olavo Fontoura, 1209", city: "São Paulo", state: "SP", country: "Brasil", zipcode: 02012 },
  { name: "Teatro Municipal", address: "Praça Ramos de Azevedo", city: "São Paulo", state: "SP", country: "Brasil", zipcode: 01037 }
]

locations.each { |loc| Location.create!(loc) }

puts "📍 Created locations"

# Create Artists
artists = [
  { name: "Coldplay" },
  { name: "Taylor Swift" },
  { name: "Ed Sheeran" },
  { name: "Adele" },
  { name: "Bruno Mars" },
  { name: "Billie Eilish" },
  { name: "The Weeknd" },
  { name: "Dua Lipa" }
]

artists.each { |artist| Artist.create!(artist) }

puts "🎤 Created artists"

# Create Users
users = [
  { first_name: "João", last_name: "Silva", email: "joao@example.com", password: "password123" },
  { first_name: "Maria", last_name: "Santos", email: "maria@example.com", password: "password123" },
  { first_name: "Pedro", last_name: "Costa", email: "pedro@example.com", password: "password123" },
  { first_name: "Ana", last_name: "Oliveira", email: "ana@example.com", password: "password123" },
  { first_name: "Carlos", last_name: "Ferreira", email: "carlos@example.com", password: "password123" }
]

users.each { |user| User.create!(user) }

puts "👥 Created users"

# Create Events
events = [
  {
    name: "Coldplay - Music of the Spheres World Tour",
    start_date: 1.month.from_now,
    event_type: concert_type,
    location: Location.find_by(name: "Allianz Parque"),
    description: "Experience the magic of Coldplay's latest world tour with spectacular visuals and unforgettable performances."
  },
  {
    name: "Taylor Swift - The Eras Tour",
    start_date: 2.months.from_now,
    event_type: concert_type,
    location: Location.find_by(name: "Espaço Unimed"),
    description: "Join Taylor Swift for an incredible journey through all her musical eras in this spectacular show."
  },
  {
    name: "Rock in Rio 2024",
    start_date: 3.months.from_now,
    event_type: festival_type,
    location: Location.find_by(name: "Vibra São Paulo"),
    description: "The biggest music festival in Brazil returns with the best national and international artists."
  },
  {
    name: "Ed Sheeran - Mathematics Tour",
    start_date: 1.week.from_now,
    event_type: concert_type,
    location: Location.find_by(name: "Teatro Municipal"),
    description: "An intimate acoustic performance by Ed Sheeran featuring songs from his latest album."
  },
  {
    name: "Adele - 30 Tour",
    start_date: 2.weeks.from_now,
    event_type: concert_type,
    location: Location.find_by(name: "Espaço Unimed"),
    description: "Experience Adele's powerful vocals and emotional performances in this unforgettable concert."
  }
]

events.each do |event_data|
  event = Event.create!(event_data)

  # Add random artists to events
  random_artists = Artist.all.sample(rand(1..3))
  random_artists.each do |artist|
    EventArtist.create!(event: event, artist: artist)
  end
end

puts "🎪 Created events with artists"

# Create Reviews
events_with_reviews = Event.limit(3)
users_for_reviews = User.all

events_with_reviews.each do |event|
  # Create 2-4 reviews per event
  rand(2..4).times do
    user = users_for_reviews.sample
    next if event.reviews.exists?(user: user) # Skip if user already reviewed

    Review.create!(
      user: user,
      event: event,
      rating: [0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0].sample, # Ratings between 0.5-5.0 for demo
      comment: [
        "Que show incrível! A energia do palco era contagiante e a performance foi impecável. O artista realmente se conectou com o público de uma forma única, criando momentos mágicos que ficarão na memória para sempre. A qualidade do som estava perfeita e a iluminação complementou perfeitamente cada música. Recomendo muito para quem quer viver uma experiência musical inesquecível!",

        "Uma das melhores experiências musicais da minha vida! Desde o momento que entrei no local até o último acorde, tudo foi perfeito. O artista demonstrou uma versatilidade incrível, alternando entre músicas mais calmas e momentos de pura energia. O público estava animado e participativo, criando uma atmosfera única. A organização do evento também foi exemplar, com entrada rápida e atendimento cordial.",

        "Show espetacular que superou todas as minhas expectativas! A produção do palco estava impecável, com efeitos visuais que complementaram perfeitamente a música. O artista mostrou uma conexão genuína com o público, contando histórias entre as músicas e criando momentos de intimidade mesmo em um ambiente grande. A qualidade técnica foi excepcional, com som cristalino e iluminação que criou diferentes atmosferas para cada canção.",

        "Experiência musical inesquecível! O artista trouxe uma energia contagiante que envolveu todo o público desde o primeiro momento. A setlist foi perfeita, mesclando sucessos conhecidos com músicas mais intimistas. O que mais me impressionou foi a interação com o público - o artista realmente se importa com os fãs e isso fica evidente em cada gesto e palavra. O local também estava bem estruturado, com boa visibilidade e acústica excelente.",

        "Show de altíssima qualidade que vale cada centavo investido! A performance foi técnica e emocionalmente perfeita, demonstrando a maturidade artística do intérprete. A produção visual estava impecável, com projeções e efeitos que enriqueceram a experiência sem distrair da música. O público estava completamente envolvido, cantando junto e criando uma energia única. Definitivamente voltarei para outros shows!",

        "Noite perfeita de música e emoção! O artista conseguiu criar uma conexão especial com cada pessoa na plateia, fazendo com que todos se sentissem parte do espetáculo. A qualidade do som estava excepcional, permitindo ouvir cada detalhe da performance. A organização do evento foi impecável, com entrada organizada e atendimento cordial. Uma experiência que recomendo para todos os amantes da boa música!",

        "Performance absolutamente arrebatadora! O artista demonstrou uma versatilidade incrível, alternando entre momentos de pura energia e canções mais intimistas. A produção do palco estava espetacular, com iluminação que criou diferentes atmosferas para cada música. O que mais me impressionou foi a autenticidade da performance - cada música foi interpretada com paixão genuína. O público estava completamente envolvido, criando uma energia contagiante.",

        "Show fantástico que superou todas as expectativas! A qualidade técnica foi impecável, com som cristalino e iluminação que complementou perfeitamente cada momento da apresentação. O artista mostrou uma conexão genuína com o público, contando histórias pessoais e criando momentos de intimidade mesmo em um ambiente grande. A setlist foi perfeita, mesclando sucessos conhecidos com músicas mais profundas. Uma experiência musical inesquecível!",

        "Experiência musical excepcional que ficará marcada na memória! O artista trouxe uma energia contagiante que envolveu todo o público desde o primeiro acorde. A performance foi técnica e emocionalmente perfeita, demonstrando a maturidade artística do intérprete. A produção visual estava impecável, com efeitos que enriqueceram a experiência sem distrair da música. O local estava bem estruturado, com boa visibilidade e acústica excelente.",

        "Show de altíssima qualidade que vale muito mais do que o preço do ingresso! A performance foi impecável, com o artista demonstrando uma versatilidade incrível e uma conexão genuína com o público. A qualidade do som estava excepcional, permitindo ouvir cada detalhe da apresentação. A organização do evento foi exemplar, com entrada rápida e atendimento cordial. Definitivamente uma das melhores experiências musicais da minha vida!"
      ].sample
    )
  end
end

puts "⭐ Created reviews"

puts "✅ Database seeding completed successfully!"
puts "📊 Summary:"
puts "   - #{EventType.count} event types"
puts "   - #{Location.count} locations"
puts "   - #{Artist.count} artists"
puts "   - #{User.count} users"
puts "   - #{Event.count} events"
puts "   - #{Review.count} reviews"
puts ""
puts "🔑 Test accounts created:"
puts "   - joao@example.com / password123"
puts "   - maria@example.com / password123"
puts "   - pedro@example.com / password123"
puts "   - ana@example.com / password123"
puts "   - carlos@example.com / password123"
