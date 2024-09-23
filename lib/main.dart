import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/register_view.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
 /* if(kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBkbe3XD4voO8SNm73FtWiF0WfggFW2phc",
            authDomain: "fir-a63a5.firebaseapp.com",
            databaseURL: "https://fir-a63a5-default-rtdb.firebaseio.com",
            projectId: "fir-a63a5",
            storageBucket: "fir-a63a5.appspot.com",
            messagingSenderId: "75698767193",
            appId: "1:75698767193:web:13c55bcb02164f770f7848",
            measurementId: "G-144Y662S3J"
        ));
  } else {
    await Firebase.initializeApp();
  } */

  runApp(
    const MaterialApp(
      home: HomePage()
    )
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page')
      ),
      body: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapsot) {
            switch (snapsot.connectionState) {
              case ConnectionState.done:
                final user = FirebaseAuth.instance.currentUser;
                final emailVerified = user?.emailVerified ?? false;
                if (emailVerified) {
                  print('You are verified');
                } else {
                  print('You need to verify email first');
                }
                return const Text('Done');
              default:
                return const Text('Loading');
            }
          }
      ),
    );
  }
}


class TestingPage extends StatelessWidget {
  const TestingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testing'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This should please work!!!!')
          ]
        ),
      )
    );
  }
}








