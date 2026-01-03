const { commonRestaurants, totersUnique } = require('../data/restaurants');

class TotersAdapter {
    async getRestaurants() {
        // Combine common restaurants with Toters unique ones
        const allRestaurants = [
            ...commonRestaurants.map(r => ({
                name: r.name,
                cuisine: r.cuisine,
                rating: r.rating,
                deliveryTime: r.deliveryTime,
                price: r.toters.price,
                discount: r.toters.discount,
                discountType: r.toters.discount > 0 ? ['under', 'upto', 'flat'][Math.floor(Math.random() * 3)] : 'none',
                deliveryFee: r.toters.deliveryFee,
                available: r.toters.available,
                provider: 'Toters'
            })),
            ...totersUnique.map(r => ({
                name: r.name,
                cuisine: r.cuisine,
                rating: r.rating,
                deliveryTime: r.deliveryTime,
                price: r.toters.price,
                discount: r.toters.discount,
                discountType: r.toters.discount > 0 ? ['under', 'upto', 'flat'][Math.floor(Math.random() * 3)] : 'none',
                deliveryFee: r.toters.deliveryFee,
                available: r.toters.available,
                provider: 'Toters',
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
            throw new Error(`Restaurant "${restaurantName}" not found on Toters`);
        }

        const finalPrice = restaurant.price * (1 - restaurant.discount / 100) + restaurant.deliveryFee;

        return {
            provider: 'Toters',
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

module.exports = new TotersAdapter();
