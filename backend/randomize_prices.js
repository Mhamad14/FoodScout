const fs = require('fs');

// Read the current restaurant data
const restaurantsData = require('./data/restaurants.js');

// Helper function to generate random price within a range
function randomPrice(min, max) {
    return Math.round((Math.random() * (max - min) + min) * 100) / 100;
}

// Helper function to generate random discount
function randomDiscount() {
    // More realistic discount distribution
    const discounts = [0, 10, 15, 20, 25, 30, 35, 40, 45, 50];
    const weights = [5, 10, 15, 20, 25, 20, 15, 10, 5, 3]; // Higher weight for moderate discounts
    const totalWeight = weights.reduce((a, b) => a + b, 0);
    
    let random = Math.random() * totalWeight;
    for (let i = 0; i < discounts.length; i++) {
        random -= weights[i];
        if (random <= 0) {
            return discounts[i];
        }
    }
    return 20; // fallback
}

// Helper function to generate random delivery fee
function randomDeliveryFee() {
    const fees = [0.99, 1.49, 1.99, 2.49, 2.99, 3.49, 3.99];
    return fees[Math.floor(Math.random() * fees.length)];
}

// Function to randomize restaurant pricing to ensure different winners
function randomizeRestaurant(restaurant) {
    // Base price range for different cuisines
    let basePriceRange;
    switch (restaurant.cuisine) {
        case 'Fast Food':
            basePriceRange = [8, 18];
            break;
        case 'Pizza':
            basePriceRange = [12, 25];
            break;
        case 'Middle Eastern':
            basePriceRange = [10, 20];
            break;
        case 'Asian':
            basePriceRange = [11, 22];
            break;
        case 'Healthy':
            basePriceRange = [12, 23];
            break;
        case 'Coffee':
            basePriceRange = [3, 8];
            break;
        case 'Desserts':
            basePriceRange = [6, 15];
            break;
        default:
            basePriceRange = [10, 25];
    }
    
    // Generate different base prices for each provider
    const talabatBase = randomPrice(basePriceRange[0], basePriceRange[1]);
    const lezzoBase = randomPrice(basePriceRange[0], basePriceRange[1]);
    const totersBase = randomPrice(basePriceRange[0], basePriceRange[1]);
    
    // Generate different discounts for each provider
    const talabatDiscount = randomDiscount();
    const lezzoDiscount = randomDiscount();
    const totersDiscount = randomDiscount();
    
    // Generate different delivery fees
    const talabatDelivery = randomDeliveryFee();
    const lezzoDelivery = randomDeliveryFee();
    const totersDelivery = randomDeliveryFee();
    
    return {
        ...restaurant,
        talabat: {
            price: talabatBase,
            discount: talabatDiscount,
            deliveryFee: talabatDelivery,
            available: true
        },
        lezzo: {
            price: lezzoBase,
            discount: lezzoDiscount,
            deliveryFee: lezzoDelivery,
            available: true
        },
        toters: {
            price: totersBase,
            discount: totersDiscount,
            deliveryFee: totersDelivery,
            available: true
        }
    };
}

// Randomize all common restaurants
const randomizedCommon = restaurantsData.commonRestaurants.map(randomizeRestaurant);

// Randomize unique restaurants
const randomizeUnique = (uniqueList, appName) => {
    return uniqueList.map(restaurant => {
        const randomized = randomizeRestaurant(restaurant);
        return {
            ...restaurant,
            [appName.toLowerCase()]: randomized[appName.toLowerCase()]
        };
    });
};

const randomizedTalabatUnique = randomizeUnique(restaurantsData.talabatUnique, 'Talabat');
const randomizedLezzoUnique = randomizeUnique(restaurantsData.lezzoUnique, 'Lezzo');
const randomizedTotersUnique = randomizeUnique(restaurantsData.totersUnique, 'Toters');

// Create the updated data structure
const updatedData = `// Restaurant data for Talabat, Lezzo, and Toters apps
// 40 common restaurants across all apps + 10 unique per app
// Prices and discounts randomized for realistic competition

const commonRestaurants = ${JSON.stringify(randomizedCommon, null, 4)};

const talabatUnique = ${JSON.stringify(randomizedTalabatUnique, null, 4)};

const lezzoUnique = ${JSON.stringify(randomizedLezzoUnique, null, 4)};

const totersUnique = ${JSON.stringify(randomizedTotersUnique, null, 4)};

module.exports = {
    commonRestaurants,
    talabatUnique,
    lezzoUnique,
    totersUnique
};`;

// Write the updated data back to the file
fs.writeFileSync('./data/restaurants.js', updatedData);

console.log('Restaurant prices and discounts have been randomized!');
console.log('Different apps will now win on different restaurants.');

// Show some sample winners
function calculateFinalPrice(price, discount, deliveryFee) {
    return price * (1 - discount / 100) + deliveryFee;
}

console.log('\nSample price comparisons:');
randomizedCommon.slice(0, 5).forEach(restaurant => {
    const talabatFinal = calculateFinalPrice(restaurant.talabat.price, restaurant.talabat.discount, restaurant.talabat.deliveryFee);
    const lezzoFinal = calculateFinalPrice(restaurant.lezzo.price, restaurant.lezzo.discount, restaurant.lezzo.deliveryFee);
    const totersFinal = calculateFinalPrice(restaurant.toters.price, restaurant.toters.discount, restaurant.toters.deliveryFee);
    
    const prices = [
        { app: 'Talabat', price: talabatFinal },
        { app: 'Lezzo', price: lezzoFinal },
        { app: 'Toters', price: totersFinal }
    ].sort((a, b) => a.price - b.price);
    
    console.log(`${restaurant.name}: ${prices[0].app} wins ($${prices[0].price.toFixed(2)})`);
});
