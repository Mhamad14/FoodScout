// Restaurant data for Talabat, Lezzo, and Toters apps
// Authentic restaurants from Sulaymaniah, Iraq - including fast food, local, and international

const commonRestaurants = [
    {
        "name": "Burger Land Slemani",
        "cuisine": "Fast Food",
        "rating": 4.5,
        "deliveryTime": "20-30 min",
        "talabat": { "price": 12.00, "discount": 25, "deliveryFee": 1.49, "available": true },
        "lezzo": { "price": 11.50, "discount": 20, "deliveryFee": 1.99, "available": true },
        "toters": { "price": 12.50, "discount": 30, "deliveryFee": 0.99, "available": true }
    },
    {
        "name": "Pizza Hot Sulaymaniyah",
        "cuisine": "Pizza",
        "rating": 4.3,
        "deliveryTime": "25-35 min",
        "talabat": { "price": 18.00, "discount": 20, "deliveryFee": 1.99, "available": true },
        "lezzo": { "price": 17.50, "discount": 25, "deliveryFee": 2.49, "available": true },
        "toters": { "price": 18.50, "discount": 15, "deliveryFee": 1.49, "available": true }
    },
    {
        "name": "Fried Chicken House",
        "cuisine": "Fried Chicken",
        "rating": 4.4,
        "deliveryTime": "20-30 min",
        "talabat": { "price": 14.00, "discount": 30, "deliveryFee": 1.49, "available": true },
        "lezzo": { "price": 13.50, "discount": 25, "deliveryFee": 1.99, "available": true },
        "toters": { "price": 14.50, "discount": 35, "deliveryFee": 0.99, "available": true }
    },
    {
        "name": "Shawarma King Suli",
        "cuisine": "Shawarma",
        "rating": 4.6,
        "deliveryTime": "15-25 min",
        "talabat": { "price": 8.00, "discount": 15, "deliveryFee": 0.99, "available": true },
        "lezzo": { "price": 7.50, "discount": 20, "deliveryFee": 1.49, "available": true },
        "toters": { "price": 8.50, "discount": 25, "deliveryFee": 0.99, "available": true }
    },
    {
        "name": "Kabab Slemani",
        "cuisine": "Kebab",
        "rating": 4.8,
        "deliveryTime": "25-35 min",
        "talabat": { "price": 22.00, "discount": 10, "deliveryFee": 1.99, "available": true },
        "lezzo": { "price": 21.50, "discount": 15, "deliveryFee": 2.49, "available": true },
        "toters": { "price": 22.50, "discount": 20, "deliveryFee": 1.49, "available": true }
    },
    {
        "name": "Tika Corner",
        "cuisine": "Kebab",
        "rating": 4.5,
        "deliveryTime": "20-30 min",
        "talabat": { "price": 15.00, "discount": 25, "deliveryFee": 1.49, "available": true },
        "lezzo": { "price": 14.50, "discount": 30, "deliveryFee": 1.99, "available": true },
        "toters": { "price": 15.50, "discount": 20, "deliveryFee": 0.99, "available": true }
    },
    {
        "name": "Falafel Suli",
        "cuisine": "Falafel",
        "rating": 4.3,
        "deliveryTime": "15-25 min",
        "talabat": { "price": 5.00, "discount": 20, "deliveryFee": 0.99, "available": true },
        "lezzo": { "price": 4.50, "discount": 25, "deliveryFee": 1.49, "available": true },
        "toters": { "price": 5.50, "discount": 15, "deliveryFee": 0.99, "available": true }
    },
    {
        "name": "Masgouf Al-Dijla",
        "cuisine": "Grilled Fish",
        "rating": 4.9,
        "deliveryTime": "45-55 min",
        "talabat": { "price": 35.00, "discount": 10, "deliveryFee": 0.00, "available": true },
        "lezzo": { "price": 34.00, "discount": 15, "deliveryFee": 0.00, "available": true },
        "toters": { "price": 36.00, "discount": 20, "deliveryFee": 0.00, "available": true }
    },
    {
        "name": "Dolma House",
        "cuisine": "Traditional Iraqi",
        "rating": 4.7,
        "deliveryTime": "35-45 min",
        "talabat": { "price": 18.00, "discount": 15, "deliveryFee": 1.99, "available": true },
        "lezzo": { "price": 17.50, "discount": 20, "deliveryFee": 2.49, "available": true },
        "toters": { "price": 18.50, "discount": 25, "deliveryFee": 1.49, "available": true }
    },
    {
        "name": "Biryani Palace",
        "cuisine": "Biryani",
        "rating": 4.6,
        "deliveryTime": "30-40 min",
        "talabat": { "price": 16.00, "discount": 20, "deliveryFee": 1.99, "available": true },
        "lezzo": { "price": 15.50, "discount": 25, "deliveryFee": 2.49, "available": true },
        "toters": { "price": 16.50, "discount": 30, "deliveryFee": 1.49, "available": true }
    },
    {
        "name": "Quzi Restaurant",
        "cuisine": "Traditional Iraqi",
        "rating": 4.8,
        "deliveryTime": "50-60 min",
        "talabat": { "price": 45.00, "discount": 10, "deliveryFee": 0.00, "available": true },
        "lezzo": { "price": 44.00, "discount": 15, "deliveryFee": 0.00, "available": true },
        "toters": { "price": 46.00, "discount": 20, "deliveryFee": 0.00, "available": true }
    },
    {
        "name": "Mam Khalil Kebab",
        "cuisine": "Kebab",
        "rating": 4.7,
        "deliveryTime": "25-35 min",
        "talabat": { "price": 20.00, "discount": 15, "deliveryFee": 1.99, "available": true },
        "lezzo": { "price": 19.50, "discount": 20, "deliveryFee": 2.49, "available": true },
        "toters": { "price": 20.50, "discount": 25, "deliveryFee": 1.49, "available": true }
    },
    {
        "name": "Lahmajun Bakery",
        "cuisine": "Lahmajun",
        "rating": 4.4,
        "deliveryTime": "15-25 min",
        "talabat": { "price": 6.00, "discount": 25, "deliveryFee": 0.99, "available": true },
        "lezzo": { "price": 5.50, "discount": 30, "deliveryFee": 1.49, "available": true },
        "toters": { "price": 6.50, "discount": 20, "deliveryFee": 0.99, "available": true }
    },
    {
        "name": "Samoon & Foul",
        "cuisine": "Breakfast",
        "rating": 4.3,
        "deliveryTime": "15-25 min",
        "talabat": { "price": 4.00, "discount": 15, "deliveryFee": 0.99, "available": true },
        "lezzo": { "price": 3.50, "discount": 20, "deliveryFee": 1.49, "available": true },
        "toters": { "price": 4.50, "discount": 25, "deliveryFee": 0.99, "available": true }
    },
    {
        "name": "Kubba Express",
        "cuisine": "Kubba",
        "rating": 4.5,
        "deliveryTime": "20-30 min",
        "talabat": { "price": 10.00, "discount": 20, "deliveryFee": 1.49, "available": true },
        "lezzo": { "price": 9.50, "discount": 25, "deliveryFee": 1.99, "available": true },
        "toters": { "price": 10.50, "discount": 30, "deliveryFee": 0.99, "available": true }
    },
    {
        "name": "Broast House Suli",
        "cuisine": "Fried Chicken",
        "rating": 4.4,
        "deliveryTime": "20-30 min",
        "talabat": { "price": 12.00, "discount": 30, "deliveryFee": 1.49, "available": true },
        "lezzo": { "price": 11.50, "discount": 25, "deliveryFee": 1.99, "available": true },
        "toters": { "price": 12.50, "discount": 35, "deliveryFee": 0.99, "available": true }
    },
    {
        "name": "Zanger Burger",
        "cuisine": "Fast Food",
        "rating": 4.2,
        "deliveryTime": "15-25 min",
        "talabat": { "price": 8.00, "discount": 25, "deliveryFee": 0.99, "available": true },
        "lezzo": { "price": 7.50, "discount": 30, "deliveryFee": 1.49, "available": true },
        "toters": { "price": 8.50, "discount": 20, "deliveryFee": 0.99, "available": true }
    },
    {
        "name": "Chay Khana Suli",
        "cuisine": "Cafe",
        "rating": 4.5,
        "deliveryTime": "10-20 min",
        "talabat": { "price": 5.00, "discount": 10, "deliveryFee": 0.99, "available": true },
        "lezzo": { "price": 4.50, "discount": 15, "deliveryFee": 1.49, "available": true },
        "toters": { "price": 5.50, "discount": 20, "deliveryFee": 0.99, "available": true }
    },
    {
        "name": "Baklava House",
        "cuisine": "Desserts",
        "rating": 4.7,
        "deliveryTime": "15-25 min",
        "talabat": { "price": 15.00, "discount": 10, "deliveryFee": 1.49, "available": true },
        "lezzo": { "price": 14.50, "discount": 15, "deliveryFee": 1.99, "available": true },
        "toters": { "price": 15.50, "discount": 20, "deliveryFee": 0.99, "available": true }
    },
    {
        "name": "Fresh Juice Slemani",
        "cuisine": "Juices",
        "rating": 4.4,
        "deliveryTime": "10-20 min",
        "talabat": { "price": 4.00, "discount": 15, "deliveryFee": 0.99, "available": true },
        "lezzo": { "price": 3.50, "discount": 20, "deliveryFee": 1.49, "available": true },
        "toters": { "price": 4.50, "discount": 25, "deliveryFee": 0.99, "available": true }
    },
    {
        "name": "Tashreeb House",
        "cuisine": "Traditional Iraqi",
        "rating": 4.6,
        "deliveryTime": "35-45 min",
        "talabat": { "price": 14.00, "discount": 20, "deliveryFee": 1.99, "available": true },
        "lezzo": { "price": 13.50, "discount": 25, "deliveryFee": 2.49, "available": true },
        "toters": { "price": 14.50, "discount": 30, "deliveryFee": 1.49, "available": true }
    },
    {
        "name": "Pacha Restaurant",
        "cuisine": "Traditional Iraqi",
        "rating": 4.3,
        "deliveryTime": "40-50 min",
        "talabat": { "price": 16.00, "discount": 15, "deliveryFee": 1.99, "available": true },
        "lezzo": { "price": 15.50, "discount": 20, "deliveryFee": 2.49, "available": true },
        "toters": { "price": 16.50, "discount": 25, "deliveryFee": 1.49, "available": true }
    },
    {
        "name": "Goizha Restaurant",
        "cuisine": "Kurdish Cuisine",
        "rating": 4.8,
        "deliveryTime": "40-50 min",
        "talabat": { "price": 35.00, "discount": 10, "deliveryFee": 0.00, "available": true },
        "lezzo": { "price": 34.00, "discount": 15, "deliveryFee": 0.00, "available": true },
        "toters": { "price": 36.00, "discount": 20, "deliveryFee": 0.00, "available": true }
    },
    {
        "name": "Azadi Grill",
        "cuisine": "Kebab",
        "rating": 4.5,
        "deliveryTime": "25-35 min",
        "talabat": { "price": 18.00, "discount": 20, "deliveryFee": 1.99, "available": true },
        "lezzo": { "price": 17.50, "discount": 25, "deliveryFee": 2.49, "available": true },
        "toters": { "price": 18.50, "discount": 30, "deliveryFee": 1.49, "available": true }
    },
    {
        "name": "Margat Fasoulia",
        "cuisine": "Traditional Iraqi",
        "rating": 4.4,
        "deliveryTime": "30-40 min",
        "talabat": { "price": 12.00, "discount": 25, "deliveryFee": 1.49, "available": true },
        "lezzo": { "price": 11.50, "discount": 30, "deliveryFee": 1.99, "available": true },
        "toters": { "price": 12.50, "discount": 20, "deliveryFee": 0.99, "available": true }
    },
    {
        "name": "Timman Bagilla",
        "cuisine": "Traditional Iraqi",
        "rating": 4.5,
        "deliveryTime": "30-40 min",
        "talabat": { "price": 10.00, "discount": 20, "deliveryFee": 1.49, "available": true },
        "lezzo": { "price": 9.50, "discount": 25, "deliveryFee": 1.99, "available": true },
        "toters": { "price": 10.50, "discount": 30, "deliveryFee": 0.99, "available": true }
    },
    {
        "name": "Kleicha Bakery",
        "cuisine": "Desserts",
        "rating": 4.6,
        "deliveryTime": "15-25 min",
        "talabat": { "price": 8.00, "discount": 15, "deliveryFee": 0.99, "available": true },
        "lezzo": { "price": 7.50, "discount": 20, "deliveryFee": 1.49, "available": true },
        "toters": { "price": 8.50, "discount": 25, "deliveryFee": 0.99, "available": true }
    },
    {
        "name": "Sushi Slemani",
        "cuisine": "Sushi",
        "rating": 4.3,
        "deliveryTime": "35-45 min",
        "talabat": { "price": 25.00, "discount": 15, "deliveryFee": 2.49, "available": true },
        "lezzo": { "price": 24.00, "discount": 20, "deliveryFee": 2.99, "available": true },
        "toters": { "price": 26.00, "discount": 25, "deliveryFee": 1.99, "available": true }
    },
    {
        "name": "Chinese Dragon",
        "cuisine": "Chinese",
        "rating": 4.2,
        "deliveryTime": "30-40 min",
        "talabat": { "price": 18.00, "discount": 20, "deliveryFee": 1.99, "available": true },
        "lezzo": { "price": 17.50, "discount": 25, "deliveryFee": 2.49, "available": true },
        "toters": { "price": 18.50, "discount": 30, "deliveryFee": 1.49, "available": true }
    },
    {
        "name": "Italian Corner",
        "cuisine": "Italian",
        "rating": 4.4,
        "deliveryTime": "30-40 min",
        "talabat": { "price": 22.00, "discount": 15, "deliveryFee": 1.99, "available": true },
        "lezzo": { "price": 21.50, "discount": 20, "deliveryFee": 2.49, "available": true },
        "toters": { "price": 22.50, "discount": 25, "deliveryFee": 1.49, "available": true }
    },
    {
        "name": "Turkish Doner",
        "cuisine": "Shawarma",
        "rating": 4.5,
        "deliveryTime": "15-25 min",
        "talabat": { "price": 9.00, "discount": 25, "deliveryFee": 0.99, "available": true },
        "lezzo": { "price": 8.50, "discount": 30, "deliveryFee": 1.49, "available": true },
        "toters": { "price": 9.50, "discount": 20, "deliveryFee": 0.99, "available": true }
    },
    {
        "name": "Saj Manakish",
        "cuisine": "Lebanese",
        "rating": 4.3,
        "deliveryTime": "15-25 min",
        "talabat": { "price": 7.00, "discount": 20, "deliveryFee": 0.99, "available": true },
        "lezzo": { "price": 6.50, "discount": 25, "deliveryFee": 1.49, "available": true },
        "toters": { "price": 7.50, "discount": 30, "deliveryFee": 0.99, "available": true }
    },
    {
        "name": "Chicken Tikka House",
        "cuisine": "Kebab",
        "rating": 4.6,
        "deliveryTime": "25-35 min",
        "talabat": { "price": 16.00, "discount": 25, "deliveryFee": 1.49, "available": true },
        "lezzo": { "price": 15.50, "discount": 30, "deliveryFee": 1.99, "available": true },
        "toters": { "price": 16.50, "discount": 20, "deliveryFee": 0.99, "available": true }
    },
    {
        "name": "Grilled Fish Darya",
        "cuisine": "Grilled Fish",
        "rating": 4.7,
        "deliveryTime": "40-50 min",
        "talabat": { "price": 28.00, "discount": 15, "deliveryFee": 1.99, "available": true },
        "lezzo": { "price": 27.00, "discount": 20, "deliveryFee": 2.49, "available": true },
        "toters": { "price": 29.00, "discount": 25, "deliveryFee": 1.49, "available": true }
    },
    {
        "name": "Mix Grill Palace",
        "cuisine": "Kebab",
        "rating": 4.5,
        "deliveryTime": "30-40 min",
        "talabat": { "price": 25.00, "discount": 20, "deliveryFee": 1.99, "available": true },
        "lezzo": { "price": 24.00, "discount": 25, "deliveryFee": 2.49, "available": true },
        "toters": { "price": 26.00, "discount": 30, "deliveryFee": 1.49, "available": true }
    },
    {
        "name": "Halabja Kitchen",
        "cuisine": "Kurdish Cuisine",
        "rating": 4.6,
        "deliveryTime": "35-45 min",
        "talabat": { "price": 20.00, "discount": 15, "deliveryFee": 1.99, "available": true },
        "lezzo": { "price": 19.00, "discount": 20, "deliveryFee": 2.49, "available": true },
        "toters": { "price": 21.00, "discount": 25, "deliveryFee": 1.49, "available": true }
    },
    {
        "name": "Sardam Restaurant",
        "cuisine": "Kurdish Cuisine",
        "rating": 4.7,
        "deliveryTime": "40-50 min",
        "talabat": { "price": 30.00, "discount": 10, "deliveryFee": 0.00, "available": true },
        "lezzo": { "price": 29.00, "discount": 15, "deliveryFee": 0.00, "available": true },
        "toters": { "price": 31.00, "discount": 20, "deliveryFee": 0.00, "available": true }
    },
    {
        "name": "Ice Cream Slemani",
        "cuisine": "Ice Cream",
        "rating": 4.4,
        "deliveryTime": "15-25 min",
        "talabat": { "price": 6.00, "discount": 20, "deliveryFee": 1.49, "available": true },
        "lezzo": { "price": 5.50, "discount": 25, "deliveryFee": 1.99, "available": true },
        "toters": { "price": 6.50, "discount": 30, "deliveryFee": 0.99, "available": true }
    },
    {
        "name": "Nan & Panir",
        "cuisine": "Breakfast",
        "rating": 4.3,
        "deliveryTime": "10-20 min",
        "talabat": { "price": 5.00, "discount": 15, "deliveryFee": 0.99, "available": true },
        "lezzo": { "price": 4.50, "discount": 20, "deliveryFee": 1.49, "available": true },
        "toters": { "price": 5.50, "discount": 25, "deliveryFee": 0.99, "available": true }
    }
];

const talabatUnique = [
    {
        "name": "Hardee's Slemani",
        "cuisine": "Fast Food",
        "rating": 4.2,
        "deliveryTime": "20-30 min",
        "talabat": { "price": 15.00, "discount": 30, "deliveryFee": 1.49, "available": true }
    },
    {
        "name": "Pizza Hut Suli",
        "cuisine": "Pizza",
        "rating": 4.3,
        "deliveryTime": "30-40 min",
        "talabat": { "price": 22.00, "discount": 25, "deliveryFee": 1.99, "available": true }
    },
    {
        "name": "KFC Sulaymaniyah",
        "cuisine": "Fried Chicken",
        "rating": 4.4,
        "deliveryTime": "20-30 min",
        "talabat": { "price": 16.00, "discount": 20, "deliveryFee": 1.49, "available": true }
    },
    {
        "name": "Domino's Suli",
        "cuisine": "Pizza",
        "rating": 4.1,
        "deliveryTime": "25-35 min",
        "talabat": { "price": 18.00, "discount": 35, "deliveryFee": 0.99, "available": true }
    },
    {
        "name": "Subway Slemani",
        "cuisine": "Sandwiches",
        "rating": 4.2,
        "deliveryTime": "20-30 min",
        "talabat": { "price": 12.00, "discount": 15, "deliveryFee": 1.49, "available": true }
    },
    {
        "name": "Papa John's Suli",
        "cuisine": "Pizza",
        "rating": 4.0,
        "deliveryTime": "30-40 min",
        "talabat": { "price": 20.00, "discount": 25, "deliveryFee": 1.99, "available": true }
    },
    {
        "name": "Baskin Robbins",
        "cuisine": "Ice Cream",
        "rating": 4.5,
        "deliveryTime": "15-25 min",
        "talabat": { "price": 8.00, "discount": 20, "deliveryFee": 1.49, "available": true }
    },
    {
        "name": "Starbucks Slemani",
        "cuisine": "Cafe",
        "rating": 4.4,
        "deliveryTime": "15-25 min",
        "talabat": { "price": 10.00, "discount": 10, "deliveryFee": 1.99, "available": true }
    },
    {
        "name": "Cinnabon Suli",
        "cuisine": "Desserts",
        "rating": 4.3,
        "deliveryTime": "15-25 min",
        "talabat": { "price": 8.00, "discount": 15, "deliveryFee": 1.49, "available": true }
    },
    {
        "name": "Krispy Kreme",
        "cuisine": "Desserts",
        "rating": 4.2,
        "deliveryTime": "15-25 min",
        "talabat": { "price": 12.00, "discount": 20, "deliveryFee": 1.99, "available": true }
    }
];

const lezzoUnique = [
    {
        "name": "Healthy Bowl Suli",
        "cuisine": "Healthy",
        "rating": 4.5,
        "deliveryTime": "25-35 min",
        "lezzo": { "price": 14.00, "discount": 25, "deliveryFee": 1.99, "available": true }
    },
    {
        "name": "Green Salad Bar",
        "cuisine": "Salads",
        "rating": 4.4,
        "deliveryTime": "20-30 min",
        "lezzo": { "price": 12.00, "discount": 20, "deliveryFee": 1.49, "available": true }
    },
    {
        "name": "Protein Kitchen",
        "cuisine": "Healthy",
        "rating": 4.3,
        "deliveryTime": "25-35 min",
        "lezzo": { "price": 18.00, "discount": 15, "deliveryFee": 1.99, "available": true }
    },
    {
        "name": "Smoothie King Suli",
        "cuisine": "Juices",
        "rating": 4.5,
        "deliveryTime": "10-20 min",
        "lezzo": { "price": 8.00, "discount": 30, "deliveryFee": 0.99, "available": true }
    },
    {
        "name": "Vegan Corner",
        "cuisine": "Vegan",
        "rating": 4.2,
        "deliveryTime": "25-35 min",
        "lezzo": { "price": 16.00, "discount": 20, "deliveryFee": 1.99, "available": true }
    },
    {
        "name": "Acai Bowl House",
        "cuisine": "Healthy",
        "rating": 4.4,
        "deliveryTime": "20-30 min",
        "lezzo": { "price": 14.00, "discount": 25, "deliveryFee": 1.49, "available": true }
    },
    {
        "name": "Fresh Wrap Suli",
        "cuisine": "Healthy",
        "rating": 4.3,
        "deliveryTime": "20-30 min",
        "lezzo": { "price": 10.00, "discount": 20, "deliveryFee": 1.49, "available": true }
    },
    {
        "name": "Detox Juice Bar",
        "cuisine": "Juices",
        "rating": 4.5,
        "deliveryTime": "10-20 min",
        "lezzo": { "price": 7.00, "discount": 25, "deliveryFee": 0.99, "available": true }
    },
    {
        "name": "Quinoa Kitchen",
        "cuisine": "Healthy",
        "rating": 4.2,
        "deliveryTime": "25-35 min",
        "lezzo": { "price": 15.00, "discount": 15, "deliveryFee": 1.99, "available": true }
    },
    {
        "name": "Organic Bites",
        "cuisine": "Healthy",
        "rating": 4.4,
        "deliveryTime": "25-35 min",
        "lezzo": { "price": 16.00, "discount": 20, "deliveryFee": 1.49, "available": true }
    }
];

const totersUnique = [
    {
        "name": "Gourmet Burger Suli",
        "cuisine": "Burgers",
        "rating": 4.7,
        "deliveryTime": "30-40 min",
        "toters": { "price": 22.00, "discount": 15, "deliveryFee": 0.00, "available": true }
    },
    {
        "name": "Premium Steak House",
        "cuisine": "Steak",
        "rating": 4.8,
        "deliveryTime": "45-55 min",
        "toters": { "price": 55.00, "discount": 10, "deliveryFee": 0.00, "available": true }
    },
    {
        "name": "Seafood Paradise",
        "cuisine": "Seafood",
        "rating": 4.6,
        "deliveryTime": "40-50 min",
        "toters": { "price": 45.00, "discount": 15, "deliveryFee": 0.00, "available": true }
    },
    {
        "name": "Royal Kebab",
        "cuisine": "Kebab",
        "rating": 4.9,
        "deliveryTime": "35-45 min",
        "toters": { "price": 35.00, "discount": 10, "deliveryFee": 0.00, "available": true }
    },
    {
        "name": "Chef's Kitchen Suli",
        "cuisine": "Fine Dining",
        "rating": 4.8,
        "deliveryTime": "50-60 min",
        "toters": { "price": 60.00, "discount": 15, "deliveryFee": 0.00, "available": true }
    },
    {
        "name": "Lobster House",
        "cuisine": "Seafood",
        "rating": 4.7,
        "deliveryTime": "45-55 min",
        "toters": { "price": 70.00, "discount": 10, "deliveryFee": 0.00, "available": true }
    },
    {
        "name": "Wagyu Suli",
        "cuisine": "Steak",
        "rating": 4.9,
        "deliveryTime": "50-60 min",
        "toters": { "price": 85.00, "discount": 10, "deliveryFee": 0.00, "available": true }
    },
    {
        "name": "Truffle Experience",
        "cuisine": "Fine Dining",
        "rating": 4.8,
        "deliveryTime": "55-65 min",
        "toters": { "price": 75.00, "discount": 15, "deliveryFee": 0.00, "available": true }
    },
    {
        "name": "Prime Rib House",
        "cuisine": "Steak",
        "rating": 4.7,
        "deliveryTime": "45-55 min",
        "toters": { "price": 50.00, "discount": 20, "deliveryFee": 0.00, "available": true }
    },
    {
        "name": "Elite Slemani",
        "cuisine": "Fine Dining",
        "rating": 5.0,
        "deliveryTime": "60-70 min",
        "toters": { "price": 95.00, "discount": 10, "deliveryFee": 0.00, "available": true }
    }
];

module.exports = {
    commonRestaurants,
    talabatUnique,
    lezzoUnique,
    totersUnique
};