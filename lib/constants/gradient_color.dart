import 'package:flutter/material.dart';

const LinearGradient mygradient = LinearGradient(
  begin: Alignment(1.23, 0.18),
  end: Alignment(-1.35, -1.09),
  colors: [
    Color(0xff0078ff),
    Color(0xff0a6199), //2 //orange//   const Color(0xff642121),
    const Color(0xffe12160) //3 //orange//   const Color(0xffe12160)
  ],
  stops: [0.0, 0.939, 1.0],
);

const LinearGradient mygraygradient = LinearGradient(
  begin: Alignment(1.23, 0.18),
  end: Alignment(-1.35, -1.09),
  colors: [Color(0xffc3c4c4), Color(0xffe0e0e0), const Color(0xffe12160)],
  stops: [0.0, 0.939, 1.0],
);
