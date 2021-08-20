import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend_application_test/model/PackageModel.dart';
import 'package:frontend_application_test/util/AppConstant.dart';
import 'package:frontend_application_test/view/widget/package_card_view.dart';
import 'package:frontend_application_test/viewModel/PackageListController.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PackageList extends StatefulWidget {

  @override
  _PackageListState createState() => _PackageListState();
}

class _PackageListState extends State<PackageList> {

  PackageListController packageListController = Get.put(PackageListController());
  late ScrollController controller;
  bool loadCalled = false;


  @override
  void initState() {
    super.initState();
    controller = new ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }
  void _scrollListener() async{
    if (controller.position.extentAfter < 500) {
      if(!packageListController.loading.value && packageListController.count > packageListController.packageList.length && !loadCalled){
        loadCalled = true;
        await packageListController.loadDataFromServer();
        loadCalled = false;
      }
    }
  }

  Widget getTitle(){
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'FLIGHT',
          style: GoogleFonts.raleway (
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: Color(0xff00276c)
          ),
          children: [
            TextSpan(
              text: 'LOCAL',
              style: GoogleFonts.aBeeZee (
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff00276c)
              ),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: MAIN_COLOR
        ),
        title: getTitle(),
      ),
      body: Column(
        children: [
          Obx(()=>packageListController.loading.value?Container():Container(
            margin: EdgeInsets.only(top: 20,bottom: 15,left: 17,right: 17),
            alignment: Alignment.centerLeft,
            child: Text("${packageListController.count} Available Holidays",
              style: GoogleFonts.raleway (
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Color(0xff00276c)
            ),)
          )),
          Flexible(
              child: Obx(()=>
                    Column(
                    children: [
                      Flexible(
                        child: ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          controller: controller,
                          itemBuilder: (ctx,i){
                            return PackageCardView(packageListController.packageList[i]);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 15,);
                          },
                          itemCount: packageListController.packageList.length,
                        ),
                      ),
                      packageListController.loading.value?
                      SpinKitCircle(
                        color: MAIN_COLOR,
                        size: 70,
                      ):Container()
                    ],
                  ),

              )
          )
        ],
      ),
    );
  }
}
