import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsUsernameDiallogue extends ConsumerStatefulWidget {
  final String identifier;
  final Function(String)? onSave;

  const SettingsUsernameDiallogue({
    super.key,
    required this.identifier,
    this.onSave,
  });

  @override
  ConsumerState<SettingsUsernameDiallogue> createState() => _SettingsUsernameDiallogueState();
}

class _SettingsUsernameDiallogueState extends ConsumerState<SettingsUsernameDiallogue> {
  final TextEditingController usernameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isValidate = true;

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  Future<void> validateUsername() async {
    final usersMap = await FirebaseFirestore.instance.collection("users").get();
    final users = usersMap.docs.map((user) => user).toList();

    final username = usernameController.text.trim();
    bool usernameExists = users.any((user) => user.data()["username"] == username);

    setState(() {
      isValidate = !usernameExists;
    });
  }

  @override
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
          key: _formKey,
          child: TextFormField(
            onChanged: (value) {
              validateUsername(); // Validate as user types
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              return isValidate ? null : "Username already taken";
            },
            controller: usernameController,
            decoration: InputDecoration(
              suffixIcon: isValidate
                  ? const Icon(Icons.verified_user, color: Colors.green)
                  : const Icon(Icons.cancel, color: Colors.red),
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
            Navigator.of(context).pop(); // Dismiss dialog on cancel
          },
          child: const Text(
            "CANCEL",
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              if (widget.onSave != null) {
                widget.onSave!(usernameController.text.trim()); // Call onSave with the entered text
              }
              Navigator.of(context).pop(); // Dismiss dialog after saving
            }
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
