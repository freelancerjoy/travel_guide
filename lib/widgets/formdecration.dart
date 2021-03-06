import 'package:flutter/material.dart';

final FormDecoration = InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.green,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.green,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    focusColor: Colors.white70,
    focusedBorder: OutlineInputBorder(

      borderSide: BorderSide(
        color: Colors.greenAccent,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    fillColor: Colors.white38,
    filled: true
);