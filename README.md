# NekoFind

A Flutter application that helps connect people with stray and adoptable cats in their area.

## Features

### 🐱 Cat Map
- Interactive map showing locations of stray cats
- Add new cat spots with details (location, number of cats, photos)
- Dark mode themed map with custom cat paw markers
- Location-based features with real-time updates

### 🏠 Adoption System
- Browse cats available for adoption
- Create adoption listings with multiple photos
- Detailed information about each cat (age, description, contact info)
- Grid view of adoptable cats with filtering options

### 👤 User Profile
- Custom cat-themed profile UI with cat ear design
- Profile photo management
- Track spotted cats and favorite posts
- Pet ownership status and count

### 🔐 Authentication
- Email/password authentication using Supabase
- Protected routes with middleware
- User session management

### 💾 Data Management
- Supabase backend integration
- Image upload and compression
- Real-time data synchronization
- Location services integration

## Technical Details

### Dependencies
- Flutter 3.2.0+
- GetX for state management
- Supabase Flutter SDK
- Google Maps Flutter
- Image processing libraries
- Cached network image handling

### Architecture
- Clean architecture with separation of concerns
- Repository pattern for data management
- GetX controllers for state management
- Freezed models for immutable data classes

### Setup
1. Clone the repository
2. Install dependencies: `flutter pub get`
3. Configure your Supabase credentials in `main.dart`
4. Add Google Maps API key in `AndroidManifest.xml`
5. Run the app: `flutter run`

### Environment Variables
Required environment variables in `.env`:
- SUPABASE_URL
- SUPABASE_ANON_KEY
- GOOGLE_MAPS_API_KEY

## Contributing
Contributions are welcome! Please read our contributing guidelines before submitting pull requests.

## License
This project is licensed under the MIT License - see the LICENSE file for details.