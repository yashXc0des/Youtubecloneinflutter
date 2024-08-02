import 'package:flutter/material.dart';

import '../../../../cores/widgets/image_button.dart';
class buttonspart extends StatelessWidget {
  const buttonspart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("More about this channel "),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: 41,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.blueGrey.shade50
                  ),
                  child: Center(child: TextButton(onPressed: (){}, child: Text("Manage Videos",style: TextStyle(color: Colors.black,fontSize:16)))),
                ),
              ),
              Expanded(child: ImageButton(onPressed: (){}, image: "pen.png", haveColor: true)),
              Expanded(child: ImageButton(onPressed: (){}, image: "time-watched.png", haveColor:true)),
            ],
          ),
        ),
      ],
    );
  }
}
