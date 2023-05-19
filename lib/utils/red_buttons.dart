import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ButtonStyle MyRedButtonStyle(){
  return ButtonStyle(
      backgroundColor: MaterialStateProperty.all( const Color(0xffFF004F)),
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)
          )
      )
  );
}