import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtubeclonenow2/auth/model/user_model.dart';
import 'package:youtubeclonenow2/auth/provider/user_provider.dart';
import 'package:youtubeclonenow2/cores/screens/error_page.dart';
import 'package:youtubeclonenow2/cores/screens/loader.dart';
import 'package:youtubeclonenow2/features/channel/my_channel/parts/tabpartwidget.dart';
import '../parts/buttons.dart';
import '../parts/tabbarview.dart';
import '../parts/toppartwidget.dart';

class MyChannelScreen extends ConsumerWidget {
  const MyChannelScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(currentUserProvider).when(
      data: (UserModel user) => DefaultTabController(
        length: 7, // Ensure this matches the number of tabs you have
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5),
              child: Column(
                children: [
                  Toppart(user: user), // Use the 'user' variable here
                  buttonspart(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: tabpart(),
                  ),
                  Expanded(child: Tabbarview()), // Wrap Tabbarview in Expanded to fill available space
                ],
              ),
            ),
          ),
        ),
      ),
      error: (error, stackTrace) => ErrorPage(),
      loading: () => const Loader(),
    );
  }
}
