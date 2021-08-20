import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend_application_test/util/AppConstant.dart';

Widget loaderContainer(Size size){
  return Container(
    color: Colors.black.withOpacity(.2),
    constraints: BoxConstraints(
        minWidth: size.width
    ),
    child: SpinKitWave(
      color: MAIN_COLOR,
      size: 50,
    ),
  );
}