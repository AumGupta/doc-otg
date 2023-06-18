import 'package:docotg/provider/user_provider.dart';
// import 'package:docotg/screens/SpeechScreen.dart';
import 'package:docotg/screens/homescreen.dart';
import 'package:docotg/screens/login_screen.dart';
import 'package:docotg/screens/mobile_screen_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
//Initialialze Firebase App


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
        ),
        home: const LogicBuilder(),
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
            return  const MobileScreenLayout(true);
             
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, });
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<FirebaseApp> _initializeFirebase () async {
FirebaseApp firebaseApp = await Firebase.initializeApp();
return firebaseApp;
}
 

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
       body: FutureBuilder(
future: _initializeFirebase(),
builder: (context, snapshot) {
if (snapshot.connectionState == ConnectionState.done) {
return const HomePage();
}
return const Center(
child: CircularProgressIndicator (),
       );}
)
    );
  }
}
