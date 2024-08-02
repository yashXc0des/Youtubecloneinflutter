import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/auth_service.dart';


class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/images/youtube-signin.jpg",
                  height: 150,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "WELCOME TO YOUTUBE",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 31,
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(height: 180),
              ClipRRect(
                borderRadius: BorderRadius.circular(21),
                child: InkWell(
                  onTap: () async {
                    // Show loading indicator while signing in
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => Center(
                        //child: CircularProgressIndicator(),
                      ),
                    );

                    try {
                      await ref.read(authServiceProvider).signInWithGoogle();
                    } catch (e) {
                      // Show error message if sign-in fails
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to sign in: $e'),
                        ),
                      );
                    } finally {
                      // Remove loading indicator
                      Navigator.of(context).pop();
                    }
                  },
                  child: Image.asset(
                    "assets/images/signinwithgoogle.png",
                    height: 65,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
