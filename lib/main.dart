import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:my_app/service/authentication_service.dart';
import 'package:my_app/screens/login_screen.dart';
import 'package:my_app/screens/register_screen.dart';
import 'package:my_app/screens/dashboard_screen.dart';
import 'package:my_app/screens/add_faculty_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
    options: const FirebaseOptions(
    apiKey: 'AIzaSyBvCLIpmgPH7ptZhjUJwYjrldCT87xteCY',
    appId: '1:439098278822:android:66fb4e22abb2d60eb10567',
    messagingSenderId: '439098278822',
    projectId: 'u-faculty-m-system',
  ),);
    runApp(const MyApp());
  } catch (e) {
    runApp(MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Failed to initialize Firebase: $e'),
        ),
      ),
    ));
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        // Add additional providers for other services
      ],
      child: MaterialApp(
        title: 'My App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/dashboard': (context) => const DashboardScreen(),
          '/addFaculty': (context) => const AddFacultyScreen(),
          // Add more routes as needed
          // Add other routes here
        },
      ),
    );
  }
}

