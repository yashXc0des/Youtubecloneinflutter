  import 'dart:ffi';

  import 'package:flutter/material.dart';
  printtextcontroller(x){
    print(x);
  }

  TextFormField CustomTextField(String hinttext,Icon? Suffixicon,bool issuffixiconpresent,bool isprefixiconpresent,Icon? Prefixicon ,TextEditingController controller,bool? isprivate,int? lines,int? length){
    return TextFormField(
      //obscureText: visibility
      obscureText: isprivate ?? false,
      controller: controller,
     maxLines: lines ?? 1,
      maxLength: length ??20,
      //  controller
      decoration:InputDecoration(
        suffixIcon: issuffixiconpresent ? Suffixicon : null,
          prefixIcon: isprefixiconpresent ? Prefixicon :null,
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