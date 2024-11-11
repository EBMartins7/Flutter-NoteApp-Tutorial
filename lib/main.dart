import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/notes_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'package:mynotes/views/verify_email_view.dart';


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
    MaterialApp(
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NotesView(),
        verifyEmailRoute: (context) => const VerifyEmailView()
      },
    )
  );
}


class HomePage extends StatelessWidget {
   const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapsot) {
          switch (snapsot.connectionState) {
            case ConnectionState.done:
              final user = AuthService.firebase().currentUser;
              if (user != null) {
                if (user.isEmailVerified) {
                  return const NotesView();
                } else {
                  return const VerifyEmailView();
                }
              } else {
                return const LoginView();
              }
            default:
              return const CircularProgressIndicator();
          }
        }
    );
  }
}



//Code to take care of sign in/out logic
Future<bool> showLogOutDialog(BuildContext context) {
 return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sign out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
                onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel'),
            ),
            TextButton(
                onPressed: () {
              Navigator.of(context).pop(true);
            },
                child: const Text('Sign out'),
            )
          ],
        );
      }
  ).then((value) => value ?? false);
}









