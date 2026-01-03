const { commonRestaurants, lezzoUnique } = require('../data/restaurants');

class LezzoAdapter {
    async getRestaurants() {
        // Combine common restaurants with Lezzo unique ones
        const allRestaurants = [
            ...commonRestaurants.map(r => ({
                name: r.name,
                cuisine: r.cuisine,
                rating: r.rating,
                deliveryTime: r.deliveryTime,
                price: r.lezzo.price,
                discount: r.lezzo.discount,
                discountType: r.lezzo.discount > 0 ? ['under', 'upto', 'flat'][Math.floor(Math.random() * 3)] : 'none',
                deliveryFee: r.lezzo.deliveryFee,
                available: r.lezzo.available,
                provider: 'Lezzo'
            })),
            ...lezzoUnique.map(r => ({
                name: r.name,
                cuisine: r.cuisine,
                rating: r.rating,
                deliveryTime: r.deliveryTime,
                price: r.lezzo.price,
                discount: r.lezzo.discount,
                discountType: r.lezzo.discount > 0 ? ['under', 'upto', 'flat'][Math.floor(Math.random() * 3)] : 'none',
                deliveryFee: r.lezzo.deliveryFee,
                available: r.lezzo.available,
                provider: 'Lezzo',
                exclusive: true
            }))
        ];

        return allRestaurants;
    }

    async search(restaurantName) {
        const allRestaurants = await this.getRestaurants();
        const restaurant = allRestaurants.find(r =>
            r.name.toLowerCase().includes(restaurantName.toLowerCase())
        );

        if (!restaurant) {
            throw new Error(`Restaurant "${restaurantName}" not found on Lezzo`);
        }

        const finalPrice = restaurant.price * (1 - restaurant.discount / 100) + restaurant.deliveryFee;

        return {
            provider: 'Lezzo',
            restaurant: restaurant.name,
            originalPrice: restaurant.price,
            discount: restaurant.discount,
            discountType: restaurant.discountType || (restaurant.discount > 0 ? 'flat' : 'none'),
            deliveryFee: restaurant.deliveryFee,
            total: finalPrice,
            available: restaurant.available,
            exclusive: restaurant.exclusive || false,
            rating: restaurant.rating,
            deliveryTime: restaurant.deliveryTime
        };
    }
}

module.exports = new LezzoAdapter();
