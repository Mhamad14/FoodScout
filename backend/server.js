const express = require('express');
const cors = require('cors');
const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

// Placeholder for adapters
const totersAdapter = require('./adapters/toters');
const talabatAdapter = require('./adapters/talabat');
const lezzoAdapter = require('./adapters/lezzo');

app.get('/', (req, res) => {
    res.send('Restaurant Comparison API is running - Talabat, Lezzo, and Toters');
});

app.get('/restaurants', async (req, res) => {
    try {
        // Get all restaurants from all providers
        const [toters, talabat, lezzo] = await Promise.all([
            totersAdapter.getRestaurants(),
            talabatAdapter.getRestaurants(),
            lezzoAdapter.getRestaurants()
        ]);

        // Merge and deduplicate restaurants, showing all providers
        const restaurantMap = new Map();

        [...toters, ...talabat, ...lezzo].forEach(restaurant => {
            const key = restaurant.name;
            if (!restaurantMap.has(key)) {
                restaurantMap.set(key, {
                    name: restaurant.name,
                    cuisine: restaurant.cuisine,
                    rating: restaurant.rating,
                    deliveryTime: restaurant.deliveryTime,
                    providers: []
                });
            }

            restaurantMap.get(key).providers.push({
                name: restaurant.provider,
                price: restaurant.price,
                discount: restaurant.discount,
                discountType: restaurant.discountType,
                deliveryFee: restaurant.deliveryFee,
                available: restaurant.available,
                exclusive: restaurant.exclusive || false
            });
        });

        const mergedRestaurants = Array.from(restaurantMap.values());
        res.json(mergedRestaurants);
    } catch (error) {
        console.error('Error fetching restaurants:', error);
        res.status(500).json({ error: 'Failed to fetch restaurants' });
    }
});

// Simple in-memory cache
const cache = new Map();
const CACHE_TTL = 5 * 60 * 1000; // 5 minutes

app.get('/compare', async (req, res) => {
    const { restaurant } = req.query;
    if (!restaurant) {
        return res.status(400).json({ error: 'Restaurant name is required' });
    }

    // Check cache
    const cached = cache.get(restaurant);
    if (cached && (Date.now() - cached.timestamp < CACHE_TTL)) {
        console.log(`Serving ${restaurant} from cache`);
        return res.json(cached.data);
    }

    try {
        // Parallel execution for all three providers
        const [toters, talabat, lezzo] = await Promise.allSettled([
            totersAdapter.search(restaurant),
            talabatAdapter.search(restaurant),
            lezzoAdapter.search(restaurant)
        ]);

        const results = [];
        let cheapestPrice = Infinity;
        let cheapestProvider = null;

        // Process results from each provider
        [
            { name: 'Toters', result: toters },
            { name: 'Talabat', result: talabat },
            { name: 'Lezzo', result: lezzo }
        ].forEach(provider => {
            if (provider.result.status === 'fulfilled') {
                results.push(provider.result.value);
                if (provider.result.value.total < cheapestPrice) {
                    cheapestPrice = provider.result.value.total;
                    cheapestProvider = provider.name;
                }
            } else {
                // Provider doesn't have this restaurant or error occurred
                console.log(`${provider.name} error:`, provider.result.reason);
            }
        });

        if (results.length === 0) {
            return res.status(404).json({ error: 'Restaurant not found on any platform' });
        }

        const responseData = {
            query: restaurant,
            cheapestProvider,
            maxDiscount: Math.max(...results.map(r => r.discount)),
            results
        };

        // Save to cache
        cache.set(restaurant, {
            timestamp: Date.now(),
            data: responseData
        });

        res.json(responseData);
    } catch (error) {
        console.error('Comparison error:', error);
        res.status(500).json({ error: 'Failed to compare prices' });
    }
});

app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
