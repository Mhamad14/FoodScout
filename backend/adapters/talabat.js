const { commonRestaurants, talabatUnique } = require('../data/restaurants');

class TalabatAdapter {
    async getRestaurants() {
        // Combine common restaurants with Talabat unique ones
        const allRestaurants = [
            ...commonRestaurants.map(r => ({
                name: r.name,
                cuisine: r.cuisine,
                rating: r.rating,
                deliveryTime: r.deliveryTime,
                price: r.talabat.price,
                discount: r.talabat.discount,
                discountType: r.talabat.discount > 0 ? ['under', 'upto', 'flat'][Math.floor(Math.random() * 3)] : 'none',
                deliveryFee: r.talabat.deliveryFee,
                available: r.talabat.available,
                provider: 'Talabat'
            })),
            ...talabatUnique.map(r => ({
                name: r.name,
                cuisine: r.cuisine,
                rating: r.rating,
                deliveryTime: r.deliveryTime,
                price: r.talabat.price,
                discount: r.talabat.discount,
                discountType: r.talabat.discount > 0 ? ['under', 'upto', 'flat'][Math.floor(Math.random() * 3)] : 'none',
                deliveryFee: r.talabat.deliveryFee,
                available: r.talabat.available,
                provider: 'Talabat',
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
            throw new Error(`Restaurant "${restaurantName}" not found on Talabat`);
        }

        const finalPrice = restaurant.price * (1 - restaurant.discount / 100) + restaurant.deliveryFee;

        return {
            provider: 'Talabat',
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

module.exports = new TalabatAdapter();
