Product.create(
  asin: 'B012CS70R8',
  features: [
    'Durable aluminum alloy',
    '31/32\' tapered handle with All Sports grip',
    '2 5/8\' barrel',
    '1-Year Warranty'
  ],
  images: [
    'https://images-na.ssl-images-amazon.com/images/I/31atFOoU%2BuL.jpg'
  ],
  inventory: 78,
  price: 4_987,
  rank: 57_842,
  reviews_count: 29,
  title: 'Easton S400 3 BBCOR Adult Baseball Bat'
)

Product.create(
  asin: 'B01MCZ1JGZ',
  features: [
    'Louisville Slugger Genuine S3X Mixed Ash Wood Baseball Bat Louisville Slugger\'s adult wood bats are pulled from their original production line for some minor flaw that will not affect the bat\'s performance. These small production errors mean deep savings on superior bats ideal for practice, batting cages or even games. Bat Specifications Wood: Series 3X Ash Finishes: Natural Finish & Black Finish Turning Model: Mixed Cupped: Yes Available Sizes: $size$'
  ],
  images: [
    'https://images-na.ssl-images-amazon.com/images/I/610R0VlP0EL._SL1500_.jpg',
    'https://images-na.ssl-images-amazon.com/images/I/51Vw4I1jNzL._SL1500_.jpg',
    'https://images-na.ssl-images-amazon.com/images/I/61-Flp8I4dL._SL1500_.jpg',
    'https://images-na.ssl-images-amazon.com/images/I/51cwBso-T0L._SL1500_.jpg'
  ],
  inventory: 100,
  price: 1_998,
  rank: 8_607,
  reviews_count: 49,
  title: 'Louisville Slugger Genuine Series 3X Ash Mixed Baseball Bat'
)

Product.create(
  asin: 'B01KQJXB8W',
  features: [
    'New St 7u1+ alloy one-piece construction that delivers a huge sweet spot and stiffer feel on contact',
    'Balanced swing weight for increased bat speed and control',
    'New Custom lizard skin premium performance grip',
    '31/32 inch standard handle'
  ],
  images: [
    'https://images-na.ssl-images-amazon.com/images/I/61LJEW4zUjL._SL1500_.jpg',
    'https://images-na.ssl-images-amazon.com/images/I/61gV4kpuGVL._SL1500_.jpg',
    'https://images-na.ssl-images-amazon.com/images/I/61SFLrftQrL._SL1500_.jpg',
    'https://images-na.ssl-images-amazon.com/images/I/812GL4j-T3L._SL1500_.jpg',
    'https://images-na.ssl-images-amazon.com/images/I/711Uoa%2BdyJL._SL1500_.jpg'
  ],
  inventory: 99,
  price: 11_995,
  rank: 31_176,
  reviews_count: 11,
  title: 'Louisville Slugger Omaha 517 BBCOR (-3) Baseball Bat'
)

Product.create(
  asin: 'B011DXBGBO',
  features: [
    'Drop (Length-to-Weight Ratio): -11--\'Drop\' is a weight-to-length ratio of a bat. Certain drops are required or limited for use in different leagues.. Bat Material: Alloy --A lightweight and durable bat material. . Model Number: YBRR11.',
    'Barrel Size: 2¼\' Youth League Barrel. Handle : Standard. Bat Performance Factor: Meets 1.15 BPF.'
  ],
  images: [
    'https://images-na.ssl-images-amazon.com/images/I/61ZNsF7iGhL._SL1500_.jpg',
    'https://images-na.ssl-images-amazon.com/images/I/719-euS5cfL._SL1500_.jpg'
  ],
  inventory: 123,
  price: 3_495,
  rank: 88_073,
  reviews_count: 16,
  title: 'Rawlings  YBRR11 Raptor Youth Minus 11, 2 1/4 Barrel Bat'
)

Product.create(
  asin: 'B00ID6X87A',
  features: [
    'Wooden baseball bat',
    'Composite wood',
    'Good quality',
    'Perfect bat for beginners and children',
    'Ideal for discovering baseball and practicing in your leisure time.'
  ],
  images: [
    'https://images-na.ssl-images-amazon.com/images/I/51w0G%2BQbjXL._SL1000_.jpg',
    'https://images-na.ssl-images-amazon.com/images/I/51qnKTXbQCL._SL1000_.jpg',
    'https://images-na.ssl-images-amazon.com/images/I/51rYeRXnziL._SL1000_.jpg',
    'https://images-na.ssl-images-amazon.com/images/I/51isBDNfbbL._SL1000_.jpg'
  ],
  inventory: 12,
  price: 1_990,
  rank: 75_150,
  reviews_count: 56,
  title: 'Barnett BB-W Wooden Baseball Bat'
)

Product.create(
  asin: 'B00MIS8HDO',
  features: [
    'One-piece alloy construction',
    'Professionally-inspired extended barrel profile',
    'Ring-free barrel technology',
    'Patented anti-vibration knob',
    'BBCOR Certified'
  ],
  images: [
    'https://images-na.ssl-images-amazon.com/images/I/51HItBh60HL._SL1500_.jpg',
    'https://images-na.ssl-images-amazon.com/images/I/51ZKWqf9w0L._SL1500_.jpg'
  ],
  inventory: 68,
  price: 15_550,
  rank: 45_573,
  reviews_count: 56,
  title: 'Marucci Cat 6 BBCOR Baseball Bat'
)

user = User.create(email: 'demo@demo.com', password: '1234567', password_confirmation: '1234567')

Group.create(
  user: user,
  name: 'Baseball Bats',
  product: Product.find_by(asin: 'B012CS70R8'),
  products: Product.where(asin: %w[B01MCZ1JGZ B01KQJXB8W B011DXBGBO B00ID6X87A B00MIS8HDO])
)
