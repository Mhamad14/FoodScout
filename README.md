# Toters vs Talabat Price Comparison MVP

A read-only mobile app to compare delivery fees and total costs between Toters and Talabat in Iraq.

## 🚀 Getting Started

### Prerequisites
- Node.js (v14+)
- Flutter SDK

### Backend Setup
1. Navigate to `backend/`:
   ```bash
   cd backend
   npm install
   ```
2. Start the server:
   ```bash
   npm start
   ```
   Server runs on `http://localhost:3000`.

### Mobile App Setup
1. Navigate to root (Flutter project):
   ```bash
   flutter pub get
   ```
2. Run the app:
   ```bash
   flutter run
   ```

## 🏗 Architecture
- **Backend**: Node.js/Express. Uses adapter pattern for providers. Currently uses **MOCK DATA** by default.
- **Mobile**: Flutter. Simple UI to search and display comparison.

## 🔮 Future Improvements
- **Scaling**: Move to serverless functions (AWS Lambda) for adapters to handle high concurrency.
- **Monetization**: Affiliate links to Toters/Talabat, or "Featured Restaurants" ads.
- **Real Data**: Implement actual reverse-engineered API calls in `adapters/`.
