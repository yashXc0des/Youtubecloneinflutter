import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtubeclonenow2/auth/provider/user_provider.dart';
import 'package:youtubeclonenow2/cores/screens/loader.dart';
import 'package:youtubeclonenow2/features/channel/widgets/edit_setting_dialog.dart';
import '../../../../cores/screens/error_page.dart';
import '../../widgets/edit_settins_username_dialog.dart';
import '../../widgets/setting_field_item.dart';
import '../repository/edit_fields.dart';
import 'dart:io';

class ChannelSettings extends ConsumerStatefulWidget {
  const ChannelSettings({super.key});

  @override
  ConsumerState<ChannelSettings> createState() => _ChannelSettingsState();
}

class _ChannelSettingsState extends ConsumerState<ChannelSettings> {
  bool isSwitch = false;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    final File file = File(image.path);
    await _uploadImage(file);
  }
  Future<void> _pickImageCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    final File file = File(image.path);
    await _uploadImage(file);
  }

  Future<void> _uploadImage(File file) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final storageRef = FirebaseStorage.instance.ref().child('profile_pictures').child('$userId.jpg');

      await storageRef.putFile(file);

      final imageUrl = await storageRef.getDownloadURL();
      await ref.read(editSettingsProvider).updateProfilePicture(imageUrl);
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(currentUserProvider).when(
      data: (currentUser) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Image.asset(
                        "assets/images/flutter background.png",
                        height: 20,
                      ),
                    ),
                    Positioned(
                      left: 155,
                      top: 70,
                      child:GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          backgroundImage: CachedNetworkImageProvider(currentUser.profilePic),
                          radius: 33,
                        ),
                    )),
                    Positioned(
                      right: 16,
                      top: 20,
                      child:GestureDetector(
                        onTap: _pickImageCamera,
                        child: Image.asset(
                          "assets/icons/camera.png",
                          color: Colors.white,
                          height: 40,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
            SettingsItem(
              identifier: 'Name',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => SettingsDialog(
                    identifier: "New Displayname",
                    onSave: (name) {
                      ref.read(editSettingsProvider).editDisplayName(name);
                    },
                  ),
                );
              },
              value: currentUser.displayName,
            ),


                const SizedBox(height: 15),

                SettingsItem(
                  identifier: 'Handle',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => SettingsUsernameDiallogue(
                        identifier: "New Username",
                        onSave: (username) {
                          ref.read(editSettingsProvider).editUserName(username);
                        },
                      ),
                    );
                  },
                  value: currentUser.username,
                ),
                const SizedBox(height: 15),
                SettingsItem(
                  identifier: 'Description',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => SettingsDialog(
                        identifier: " New Description",
                        onSave: (description) {
                          ref.read(editSettingsProvider).editDiscription(description);
                        },
                      ),
                    );
                  },
                  value: currentUser.description,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Keep all subscribers private"),
                      Switch(
                        value: isSwitch,
                        onChanged: (value) {
                          setState(() {
                            isSwitch = value;
                          });
                        },
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "All changes made here are only visible on YouTube and not on other platforms of Google",
                      style: TextStyle(color: Colors.blueGrey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      error: (error, stackTrace) => const ErrorPage(),
      loading: () => const Loader(),
    );
  }
}
