# SewoApp

A comprehensive Flutter e-commerce application for vehicle rental management system. This app allows users to browse vehicle catalogs, manage orders, handle payments, and track rental history.

## Features

### 🚗 **Catalog Management**
- Browse vehicle catalog with detailed specifications
- Vehicle filtering and search functionality
- View vehicle details including fuel type, top speed, and features
- Popular and promotional vehicle listings

### 👥 **User Management**
- Customer registration and profile management
- Admin user management system
- Session management with secure authentication

### 🛒 **Shopping Cart & Orders**
- Add vehicles to cart for rental
- Manage cart items (add, edit, remove)
- Order processing and management
- Order history tracking

### 💰 **Payment System**
- Multiple bank account support
- Payment proof upload functionality
- Payment status tracking
- Bank selection for transactions

### 📦 **Product & Inventory**
- Product category management
- Unit/measurement management
- Inventory tracking system

### 🚚 **Shipping & Delivery**
- Shipping cost calculation (Ongkir)
- Delivery area management
- Order fulfillment tracking

### 💬 **Communication**
- WhatsApp integration for customer support
- Direct communication with rental service

## Tech Stack

- **Framework:** Flutter
- **State Management:** BLoC (Business Logic Component)
- **Architecture:** Clean Architecture with Repository Pattern
- **Dependencies:** 
  - `flutter_bloc` - State management
  - `equatable` - Value equality
  - `image_picker` - Image selection
  - `url_launcher` - External URL handling
  - `visibility_detector` - Widget visibility detection
  - `badges` - Badge widgets

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── config/                   # Configuration files
│   ├── color.dart           # App color scheme
│   ├── config_global.dart   # Global configurations
│   └── config_session_manager.dart # Session management
├── data/                     # Data models and filters
├── data_admin/              # Admin management module
├── data_bank/               # Bank account management
├── data_cart/               # Shopping cart functionality
├── data_detail_pemesanan/   # Order details management
├── data_katalog/            # Vehicle catalog
├── data_kategori/           # Category management
├── data_ongkir/             # Shipping cost management
├── data_pelanggan/          # Customer management
├── data_pemesanan/          # Order management
├── data_peserta/            # Participant management
├── data_produk/             # Product management
├── data_satuan/             # Unit management
├── enum/                    # Enumeration definitions
├── frame/                   # App frame/layout
├── home/                    # Home screen components
├── login/                   # Authentication
├── profil/                  # User profile
├── utils/                   # Utility functions
└── widgets/                 # Reusable widgets
```

## Installation

### Prerequisites
- Flutter SDK (>=2.17.0)
- Dart SDK (>=2.17.0)
- Android Studio / VS Code
- Android SDK for Android development
- Xcode for iOS development (macOS only)

### Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd sewoapp
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure the app**
   - Update API endpoints in configuration files
   - Configure Firebase (if used)
   - Set up payment gateway credentials

4. **Run the application**
   ```bash
   # Debug mode
   flutter run

   # Release mode
   flutter run --release
   ```

## Build for Production

### Android
```bash
# Build APK
flutter build apk --release

# Build App Bundle (recommended for Play Store)
flutter build appbundle --release
```

### iOS
```bash
# Build for iOS
flutter build ios --release
```

## Configuration

### API Configuration
Update the API base URL in [`lib/config/config_global.dart`](lib/config/config_global.dart):

```dart
class ConfigGlobal {
  static const String baseUrl = "your-api-base-url";
  // Other configurations...
}
```

### App Signing
For release builds, configure signing keys:
- Android: Update `android/app/build.gradle` and `key.properties`
- iOS: Configure signing in Xcode

## Key Features Implementation

### State Management with BLoC
The app uses BLoC pattern for state management:
- **Event-driven architecture** for handling user interactions
- **Separation of concerns** between UI and business logic
- **Reactive programming** with stream-based state updates

### Repository Pattern
- **Remote repositories** for API communication
- **Local repositories** for offline data (commented out but available)
- **Network connectivity checking** before API calls

### Clean Architecture
- **Data layer** - API services, models, repositories
- **Domain layer** - Business logic, use cases
- **Presentation layer** - UI, BLoC, widgets

## API Integration

The app integrates with various endpoints:
- Vehicle catalog management
- User authentication and management
- Order processing and tracking
- Payment processing
- File upload for payment proofs

## Testing

```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test/
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Developed with ❤️ using Flutter**