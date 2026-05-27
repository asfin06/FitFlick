import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitflick/firebase_options.dart';
import 'package:fitflick/screens/splash_screen.dart';
import 'package:fitflick/screens/home_screen.dart';
import 'package:fitflick/screens/login_screen.dart';
import 'package:fitflick/screens/product_listing_screen.dart';
import 'package:fitflick/screens/cart_screen.dart';
import 'package:fitflick/screens/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitflick/data/app_data.dart';

Future<void> migrateProductsToFirestore() async {
  final firestore = FirebaseFirestore.instance;
  final allProducts = [
    ...AppData.featuredProducts,
    ...AppData.listingProducts,
  ];

  for (var product in allProducts) {
    final String id = product['title'].toString().toLowerCase().replaceAll(' ', '_');
    final Map<String, dynamic> data = Map.from(product);
    
    if (data['color'] != null && data['color'] is Color) {
      data['color'] = (data['color'] as Color).toARGB32().toRadixString(16);
    }
    
    await firestore.collection('products').doc(id).set(data);
  }
  print("Upload complete");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // await migrateProductsToFirestore();
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const AuthGate(),
        routes: {
          '/home': (_) => const HomeScreen(),
          '/login': (_) => const LoginScreen(),
          '/listing': (_) => const ProductListingScreen(),
          '/cart': (_) => const CartScreen(),
          '/profile': (_) => const ProfileScreen(),
        },
      );
  }
}

/// Listens to Firebase auth state and routes accordingly.
/// Shows splash while loading, HomeScreen if logged in, LoginScreen if not.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Show splash while waiting for auth state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }
        // User is logged in
        if (snapshot.hasData) {
          return const HomeScreen();
        }
        // User is not logged in
        return const LoginScreen();
      },
    );
  }
}
