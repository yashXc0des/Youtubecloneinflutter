import 'package:flutter/material.dart';

TextFormField CustomTextField(Key formkey,String hinttext,Icon icon,TextEditingController controller,bool visibility, Color iconcolor){
  return TextFormField(

    key: formkey,
    obscureText: visibility,                 //visibility
    controller: controller, //  controller
    decoration:InputDecoration(
      suffixIcon: icon,
      iconColor: Colors.green,
      hintText: hinttext,                    // hint text
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(21),
        borderSide: const BorderSide(
          color: Colors.blue,
          width: 4
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(21),
        borderSide: const BorderSide(
            color: Colors.green,
            width: 4
        ),
      ),
    ),

  );
}