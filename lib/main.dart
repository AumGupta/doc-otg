import 'package:docotg/provider/user_provider.dart';
import 'package:docotg/screens/login_screen.dart';
import 'package:docotg/screens/mobile_screen_layout.dart';
import 'package:docotg/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Initialialze Firebase App
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DOC-OTG',
        theme: ThemeData(
          fontFamily: 'Montserrat',
          useMaterial3: true,
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 10),
              side: BorderSide(color: greyColor),
              foregroundColor: darkPurple,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 10),
              elevation: 0,
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
        ),
        home: const LoginPage(),
      ),
    );
  }
}

class LogicBuilder extends StatelessWidget {
  const LogicBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            // This means that whenever the connection is active and our snapshot has any data we are going to return a responsive layout
            return MobileScreenLayout(
                isDoctor:
                true); // TRUE hai isiliye DOctor Screen AAti hai bar bar
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error}',
              ),
            );
          }
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
        }
        return const LoginPage();
      },
    );
  }
}
