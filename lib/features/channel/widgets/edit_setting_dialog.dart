import 'package:flutter/material.dart';

class SettingsDialog extends StatefulWidget {
  final String identifier;
  final Function(String)? onSave;

  const SettingsDialog({
    Key? key,
    required this.identifier,
    this.onSave,
  }) : super(key: key);

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  final TextEditingController controller = TextEditingController();

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
        child: TextField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue,
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
