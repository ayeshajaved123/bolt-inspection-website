import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/about_screen.dart';
import 'screens/services_screen.dart';
import 'screens/inspection_service_screen.dart';
import 'screens/training_service_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/admin/admin_login_screen.dart';
import 'screens/admin/admin_dashboard_screen.dart';
import 'screens/admin/admin_messages_screen.dart';
import 'screens/admin/admin_content_screen.dart';
import 'screens/admin/admin_media_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    // Expected until you run `flutterfire configure` with your real project.
    // The public site still renders — only the contact form / admin panel
    // need a real Firebase connection to function.
    debugPrint('Firebase not configured yet: $e');
  }
  runApp(const BoltInspectionApp());
}

class BoltInspectionApp extends StatelessWidget {
  const BoltInspectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bolt Inspection & Training',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/about': (context) => const AboutScreen(),
        '/services': (context) => const ServicesScreen(),
        '/services/inspection': (context) => const InspectionServiceScreen(),
        '/services/training': (context) => const TrainingServiceScreen(),
        '/contact': (context) => const ContactScreen(),
        '/admin/login': (context) => const AdminLoginScreen(),
        '/admin/dashboard': (context) => const AdminDashboardScreen(),
        '/admin/messages': (context) => const AdminMessagesScreen(),
        '/admin/content': (context) => const AdminContentScreen(),
        '/admin/media': (context) => const AdminMediaScreen(),
      },
    );
  }
}
