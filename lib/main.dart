import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtubeclonenow2/cores/firebase_options.dart';
import 'auth/pages/login_page.dart';
import 'auth/pages/username_page.dart';
import 'features/content/Long_video/parts/post.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Youtube',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AuthWidget(),
    );
  }
}

class AuthWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong!'));
        } else if (!snapshot.hasData) {
          return LoginPage();
        } else {
          return StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (userSnapshot.hasError) {
                return Center(child: Text('Something went wrong!'));
              } else if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                final user = FirebaseAuth.instance.currentUser;
                return UsernamePage(
                  displayname: user!.displayName ?? '',
                  profilePic: user.photoURL ?? '',
                  email: user.email ?? '',
                );
              } else {
                return HomePage();
              }
            },
          );
        }
      },
    );
  }
}
