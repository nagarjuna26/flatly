import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Import your HomeScreen

void main() async {
  // Ensure Firebase is initialized before the app starts
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(); // Initialize Firebase
    print('Firebase Initialized'); // Debug message to check if Firebase is initialized
  } catch (e) {
    print('Error initializing Firebase: $e'); // Catch initialization errors
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flatly App',
      home: const HomeScreen(), // Directly use HomeScreen after Firebase initialization
    );
  }
}
