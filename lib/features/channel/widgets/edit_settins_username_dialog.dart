import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final formkey1 = GlobalKey<FormState>();
class SettingsUsernameDiallogue extends ConsumerStatefulWidget {
  final String identifier;
  final Function(String)? onSave;

  const SettingsUsernameDiallogue({super.key, required this.identifier, this.onSave});

  @override
  ConsumerState<SettingsUsernameDiallogue> createState() => _SettingsUsernameDiallogueState();
}

class _SettingsUsernameDiallogueState extends ConsumerState<SettingsUsernameDiallogue> {
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
  final TextEditingController controller = TextEditingController();
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.only(top: 0),
      title: Padding(
        padding: const EdgeInsets.only(left: 22, top: 8),
        child: Text(
          widget.identifier,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
      content: SizedBox(
        height: 50,
        child: Form(
          key: formkey1,
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
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            // Dismiss dialog on cancel
          },
          child: const Text(
            "CANCEL",
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () {
            if (widget.onSave != null) {
              widget.onSave!(controller.text); // Call onSave with the entered text
            }
            Navigator.of(context).pop(); // Dismiss dialog after saving
          },
          child: const Text(
            "SAVE",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
