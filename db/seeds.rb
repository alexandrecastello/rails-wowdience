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
EventType.create!(name: "Theater")

puts "🎭 Created event types"

# Create Locations
locations = [
  { name: "Allianz Parque", address: "Rua Palestra Itália, 214", city: "São Paulo", state: "SP", country: "Brasil", zipcode: 01234 },
  { name: "Espaço Unimed", address: "Av. Paulista, 2073", city: "São Paulo", state: "SP", country: "Brasil", zipcode: 01311 },
  { name: "Vibra São Paulo", address: "Marginal Pinheiros, 12209", city: "São Paulo", state: "SP", country: "Brasil", zipcode: 02012 },
  { name: "Teatro Municipal", address: "Praça Ramos de Azevedo", city: "São Paulo", state: "SP", country: "Brasil", zipcode: 01037 },
  { name: "Sambódromo", address: "Av. Olavo Fontoura, 1209", city: "São Paulo", state: "SP", country: "Brasil", zipcode: 02012 }
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
  { name: "Dua Lipa" },
  { name: "Ivete Sangalo" }
]

artists.each { |artist| Artist.create!(artist) }

puts "🎤 Created artists"

# Create Users
users = [
  {
    first_name: "João",
    last_name: "Silva",
    email: "joao.silva@email.com",
    password: "123456"
  },
  {
    first_name: "Maria",
    last_name: "Santos",
    email: "maria.santos@email.com",
    password: "123456"
  },
  {
    first_name: "Pedro",
    last_name: "Costa",
    email: "pedro.costa@email.com",
    password: "123456"
  },
  {
    first_name: "Ana",
    last_name: "Oliveira",
    email: "ana.oliveira@email.com",
    password: "123456"
  },
  {
    first_name: "Carlos",
    last_name: "Ferreira",
    email: "carlos.ferreira@email.com",
    password: "123456"
  },
  {
    first_name: "Beatriz",
    last_name: "Almeida",
    email: "beatriz.almeida@email.com",
    password: "123456"
  },
  {
    first_name: "Rafael",
    last_name: "Lima",
    email: "rafael.lima@email.com",
    password: "123456"
  },
  {
    first_name: "Camila",
    last_name: "Rodrigues",
    email: "camila.rodrigues@email.com",
    password: "123456"
  }
]

users.each { |user| User.create!(user) }

puts "👥 Created users"

# Create Events
events = [
  {
    name: "Coldplay - Music of the Spheres World Tour",
    start_date: 2.months.ago,
    event_type: concert_type,
    location: Location.find_by(name: "Allianz Parque"),
    description: "Experience the magic of Coldplay's latest world tour with spectacular visuals and unforgettable performances."
  },
  {
    name: "Taylor Swift - The Eras Tour",
    start_date: 1.month.ago,
    event_type: concert_type,
    location: Location.find_by(name: "Espaço Unimed"),
    description: "Join Taylor Swift for an incredible journey through all her musical eras in this spectacular show."
  },
  {
    name: "Rock in Rio 2024",
    start_date: 3.months.ago,
    event_type: festival_type,
    location: Location.find_by(name: "Vibra São Paulo"),
    description: "The biggest music festival in Brazil returns with the best national and international artists."
  },
  {
    name: "Ed Sheeran - Mathematics Tour",
    start_date: 2.weeks.ago,
    event_type: concert_type,
    location: Location.find_by(name: "Teatro Municipal"),
    description: "An intimate acoustic performance by Ed Sheeran featuring songs from his latest album."
  },
  {
    name: "Adele - 30 Tour",
    start_date: 1.week.ago,
    event_type: concert_type,
    location: Location.find_by(name: "Espaço Unimed"),
    description: "Experience Adele's powerful vocals and emotional performances in this unforgettable concert."
  },
  {
    name: "Ivete Sangalo - Clareou",
    start_date: 3.weeks.ago,
    event_type: concert_type,
    location: Location.find_by(name: "Sambódromo"),
    description: "A festa mais animada do Brasil! Ivete Sangalo traz seu show 'Clareou' com os maiores sucessos da música brasileira."
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
# Create reviews for all events using our new users
Event.all.each do |event|
  # Create 3-6 reviews per event using our new users
  rand(3..6).times do
    user = User.all.sample
    next if event.reviews.exists?(user: user) # Skip if user already reviewed

    # Create rating-comment pairs that make sense together
    rating_comment_pairs = [
      # 5.0 - Excelente
      { rating: 5.0, comment: "Que show incrível! A energia do palco era contagiante e a performance foi impecável. O artista realmente se conectou com o público de uma forma única, criando momentos mágicos que ficarão na memória para sempre. A qualidade do som estava perfeita e a iluminação complementou perfeitamente cada música. Recomendo muito para quem quer viver uma experiência musical inesquecível!" },
      { rating: 5.0, comment: "Uma das melhores experiências musicais da minha vida! Desde o momento que entrei no local até o último acorde, tudo foi perfeito. O artista demonstrou uma versatilidade incrível, alternando entre músicas mais calmas e momentos de pura energia. O público estava animado e participativo, criando uma atmosfera única. A organização do evento também foi exemplar, com entrada rápida e atendimento cordial." },
      { rating: 5.0, comment: "Minha cantora favorita! Não vejo a hora de assistir outros shows dela!" },
      { rating: 5.0, comment: "Ivete arrasou como sempre! Show de primeira qualidade!" },
      { rating: 5.0, comment: "A festa mais animada que já fui! Recomendo demais!" },
      { rating: 5.0, comment: "Perfeito! Música, dança e alegria em dose tripla!" },

      # 4.5 - Muito bom
      { rating: 4.5, comment: "Show espetacular que superou todas as minhas expectativas! A produção do palco estava impecável, com efeitos visuais que complementaram perfeitamente a música. O artista mostrou uma conexão genuína com o público, contando histórias entre as músicas e criando momentos de intimidade mesmo em um ambiente grande. A qualidade técnica foi excepcional, com som cristalino e iluminação que criou diferentes atmosferas para cada canção." },
      { rating: 4.5, comment: "Show de altíssima qualidade que vale cada centavo investido! A performance foi técnica e emocionalmente perfeita, demonstrando a maturidade artística do intérprete. A produção visual estava impecável, com projeções e efeitos que enriqueceram a experiência sem distrair da música. O público estava completamente envolvido, cantando junto e criando uma energia única. Definitivamente voltarei para outros shows!" },
      { rating: 4.5, comment: "Show sensacional! Ivete é uma artista incrível!" },

      # 4.0 - Bom
      { rating: 4.0, comment: "Experiência musical inesquecível! O artista trouxe uma energia contagiante que envolveu todo o público desde o primeiro momento. A setlist foi perfeita, mesclando sucessos conhecidos com músicas mais intimistas. O que mais me impressionou foi a interação com o público - o artista realmente se importa com os fãs e isso fica evidente em cada gesto e palavra. O local também estava bem estruturado, com boa visibilidade e acústica excelente." },
      { rating: 4.0, comment: "Noite perfeita de música e emoção! O artista conseguiu criar uma conexão especial com cada pessoa na plateia, fazendo com que todos se sentissem parte do espetáculo. A qualidade do som estava excepcional, permitindo ouvir cada detalhe da performance. A organização do evento foi impecável, com entrada organizada e atendimento cordial. Uma experiência que recomendo para todos os amantes da boa música!" },

      # 3.5 - Regular/Bom
      { rating: 3.5, comment: "Performance interessante! O artista demonstrou boa técnica e o público estava animado. A qualidade do som estava adequada e a iluminação funcionou bem. Alguns momentos foram realmente especiais, mas no geral foi um show regular. Vale a pena para quem é fã, mas não superou minhas expectativas." },
      { rating: 3.5, comment: "Show ok, mas poderia ser melhor. A performance foi boa, mas senti que faltou algo especial. O som estava decente e o local era adequado. Algumas músicas foram muito boas, outras nem tanto. No geral, uma experiência agradável mas não memorável." },

      # 3.0 - Regular
      { rating: 3.0, comment: "Show mediano, esperava mais. A performance foi técnica mas sem muito brilho. O som estava ok, mas não excepcional. O público estava animado, o que ajudou a criar uma boa atmosfera. Não foi ruim, mas também não foi nada de mais. Talvez para fãs mais dedicados seja melhor." },
      { rating: 3.0, comment: "Experiência regular. O artista fez o básico bem, mas não trouxe nada de especial. A qualidade do som estava adequada e o local era confortável. Algumas músicas foram boas, outras nem tanto. No geral, um show que cumpre o que promete, mas não vai além disso." },

      # 2.5 - Ruim/Regular
      { rating: 2.5, comment: "Show decepcionante. A performance foi técnica mas sem emoção. O som estava com problemas em alguns momentos e a iluminação era básica. O público tentou se animar, mas faltou energia do palco. Esperava muito mais considerando o preço do ingresso. Não recomendo." },
      { rating: 2.5, comment: "Bom show, mas o preço estava alto. A performance foi ok, mas não justificou o valor cobrado. O som estava decente, mas a produção foi simples. Algumas músicas foram boas, outras nem tanto. No geral, uma experiência mediana que poderia ter sido melhor." },

      # 2.0 - Ruim
      { rating: 2.0, comment: "Show ruim. A performance foi técnica mas sem alma. O som estava com problemas constantes e a iluminação era inadequada. O público estava desanimado e muitos saíram antes do final. Esperava muito mais considerando a reputação do artista. Definitivamente não vale o preço." },
      { rating: 2.0, comment: "Experiência decepcionante. O artista não se conectou com o público e a performance foi mecânica. O som estava ruim e a organização deixou a desejar. O local estava lotado e mal ventilado. Não recomendo para ninguém." },

      # 1.5 - Muito ruim
      { rating: 1.5, comment: "Show muito ruim. A performance foi técnica mas completamente sem emoção. O som estava terrível e a iluminação era inadequada. O público estava desanimado e muitos saíram antes do final. Esperava muito mais considerando a reputação do artista. Definitivamente não vale o preço e não recomendo." },

      # 1.0 - Péssimo
      { rating: 1.0, comment: "Show péssimo. A performance foi técnica mas completamente sem alma. O som estava terrível e a iluminação era inadequada. O público estava desanimado e muitos saíram antes do final. Esperava muito mais considerando a reputação do artista. Definitivamente não vale o preço e não recomendo para ninguém." },

      # 0.5 - Terrível
      { rating: 0.5, comment: "Show terrível. A performance foi técnica mas completamente sem emoção. O som estava terrível e a iluminação era inadequada. O público estava desanimado e muitos saíram antes do final. Esperava muito mais considerando a reputação do artista. Definitivamente não vale o preço e não recomendo para ninguém. Uma das piores experiências musicais da minha vida." }
    ]

    selected_pair = rating_comment_pairs.sample

    Review.create!(
      user: user,
      event: event,
      rating: selected_pair[:rating],
      comment: selected_pair[:comment]
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
puts "   - joao.silva@email.com / 123456 (João Silva)"
puts "   - maria.santos@email.com / 123456 (Maria Santos)"
puts "   - pedro.costa@email.com / 123456 (Pedro Costa)"
puts "   - ana.oliveira@email.com / 123456 (Ana Oliveira)"
puts "   - carlos.ferreira@email.com / 123456 (Carlos Ferreira)"
puts "   - beatriz.almeida@email.com / 123456 (Beatriz Almeida)"
puts "   - rafael.lima@email.com / 123456 (Rafael Lima)"
puts "   - camila.rodrigues@email.com / 123456 (Camila Rodrigues)"
