import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtubeclonenow2/features/account/items.dart';

import '../../auth/provider/user_provider.dart';
import '../../cores/screens/error_page.dart';
import '../../cores/screens/loader.dart';
class Account_Page extends StatelessWidget {
  const Account_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15,bottom: 15),
              child: Consumer(builder: (context , ref ,child){
                return ref.watch(currentUserProvider).when(
                    data: (currentUser)=>Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.green,
                        backgroundImage:CachedNetworkImageProvider(currentUser.profilePic),
                      ),
                    ),
                    error: (error ,stackTree)=> const ErrorPage(),
                    loading: ()=>const Loader());
              }),
            ),
            Consumer(builder: (context , ref ,child){
              return ref.watch(currentUserProvider).when(
                  data: (currentUser)=>Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(currentUser.displayName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  ),
                  error: (error ,stackTree)=> const ErrorPage(),
                  loading: ()=>const Loader());
            }),
            Consumer(builder: (context,ref,child){
              return ref.watch(currentUserProvider).when(
                  data:(currentUser)=>Text(currentUser.username),
                  error: (error ,stackTree)=> const ErrorPage(),
                  loading: ()=>const Loader());
            }),

            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Items(),
            ),
          ],
        ),
      ),
    );
  }
}
