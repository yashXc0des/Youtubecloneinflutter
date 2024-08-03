import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtubeclonenow2/cores/widgets/flat_button.dart';

import '../provider/user_provider.dart';
import '../repository/user_data_service.dart';

final formkey = GlobalKey<FormState>();

class UsernamePage extends ConsumerStatefulWidget {
  final String displayname;
  final String profilePic;
  final String email;

  UsernamePage({
    required this.displayname,
    required this.profilePic,
    required this.email,
  });

  @override
  ConsumerState<UsernamePage> createState() => _UsernamePageState();
}

class _UsernamePageState extends ConsumerState<UsernamePage> {
  final TextEditingController usernameController = TextEditingController();
  bool isValidate = true;

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  void validateusername() async {
    final usersMap = await FirebaseFirestore.instance.collection("users").get();
    final users = usersMap.docs.map((user) => user).toList();
    String? targetedUsername;

    setState(() {
      isValidate = true; // Reset validation state
    });

    for (var user in users) {
      if (usernameController.text == user.data()["username"]) {
        targetedUsername = user.data()["username"];
        setState(() {
          isValidate = false;
        });
        break;
      }
    }

    if (targetedUsername == null) {
      setState(() {
        isValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 25, left: 15),
              child: Text(
                "ENTER USER NAME",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Form(
                key: formkey,
                child: TextFormField(
                  onChanged: (value) {
                    validateusername();
                  },
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    return isValidate ? null : "Username already taken";
                  },
                  obscureText: false, // Not a password field
                  controller: usernameController,
                  decoration: InputDecoration(
                    suffixIcon: isValidate
                        ? Icon(Icons.verified_user,color: Colors.green,)
                        : Icon(Icons.cancel,color: Colors.red,),
                    //iconColor: isValidate ? Colors.green : Colors.redAccent,
                    hintText: "Username",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 4,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide: const BorderSide(
                        color: Colors.green,
                        width: 4,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: FlatButton(
                  text: "Continue",
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      await ref.read(userDataServiceProvider).addUserDataToFireStore(
                        displayName: widget.displayname,
                        username: usernameController.text,
                        email: widget.email,
                        profilePic: widget.profilePic,
                        description: "",
                      );
                    }
                  },
                  colour: isValidate ? Colors.green : Colors.green.shade100,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
