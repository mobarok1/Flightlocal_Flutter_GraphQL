import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend_application_test/view/widget/customerClipper.dart';



class BezierContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Transform.rotate(
          angle: -pi / 3.5,
          child: ClipPath(
            clipper: ClipPainter(),
            child: Container(
              height: MediaQuery.of(context).size.height *.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xff1c3f9e),Color(0xff001d6c)]
                  )
              ),
            ),
          ),
        )
    );
  }
}