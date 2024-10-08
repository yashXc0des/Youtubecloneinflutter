import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtubeclonenow2/auth/provider/user_provider.dart';
import"package:cached_network_image/cached_network_image.dart";
import 'package:youtubeclonenow2/cores/screens/error_page.dart';
import 'package:youtubeclonenow2/cores/screens/loader.dart';
import 'package:youtubeclonenow2/features/upload/upload_bottom_sheet.dart';
import 'package:youtubeclonenow2/page_list.dart';
import 'cores/widgets/image_button.dart';
import 'features/account/account_page.dart';
import 'features/content/bottom_navigation.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentindex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/images/youtube.jpg",
                  height: 36,
                ),
                const SizedBox(width: 4),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: SizedBox(
                    height: 42,
                    child: ImageButton(
                      image: "cast.png",
                      onPressed: () {},
                      haveColor: false,
                    ),
                  ),
                ),
                SizedBox(
                  height: 38,
                  child: ImageButton(
                    image: "notification.png",
                    onPressed: () {},
                    haveColor: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 15),
                  child: SizedBox(
                    height: 41.5,
                    child: ImageButton(
                      image: "search.png",
                      onPressed: () {},
                      haveColor: false,
                    ),
                  ),
                ),
                Consumer(builder: (context , ref ,child){
                  return ref.watch(currentUserProvider).when(
                      data: (currentUser)=>Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: InkWell(
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.green,
                            backgroundImage:CachedNetworkImageProvider(currentUser.profilePic),
                          ),
                          onTap: () {
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context) => Account_Page(),
                              ),
                            );
                          },),
                      ),
                      error: (error ,stackTree)=> const ErrorPage(),
                      loading: ()=>const Loader());
                })
              ],
            ),
            Expanded(child: page[currentindex])
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(onPressed: (int index) {
        if(index!=2){
          currentindex=index;
          setState(() {
          });
        }
        else{
          showModalBottomSheet(context: context , builder: (context)=> CreateBottomSheet());
        }
      },),
    );
  }
}
