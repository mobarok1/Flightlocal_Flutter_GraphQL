import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend_application_test/model/PackageModel.dart';
import 'package:frontend_application_test/util/AppConstant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PackageCardView extends StatelessWidget {
  final PackageModel package;
  PackageCardView(this.package);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
              Radius.circular(10)
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 1,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10)
                    ),
                    child: Image.network(package.thumbnail!,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,

                      errorBuilder: (ctx,obj,error){
                        return Image.asset("assets/no_image.png",
                          width: 150,
                          height: 150,
                        );
                      },
                    ),
                  ),

                  Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5,left: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(package.title,
                              maxLines: 2,
                              style: GoogleFonts.roboto (
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: MAIN_COLOR,
                                  height: 1.2
                              ),),
                            Text(package.description!,
                              style: GoogleFonts.roboto (
                                fontSize: 14,

                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset("assets/calendar.png",
                                  height: 10,
                                  width: 10,
                                  fit: BoxFit.cover,
                                  color: MAIN_COLOR,
                                ),
                                SizedBox(width: 7,height: 20,),
                                Text(package.durationText!,
                                  style: GoogleFonts.roboto (
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: MAIN_COLOR
                                  ),),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset("assets/path_icon.png",
                                  height: 10,
                                  width: 10,
                                  fit: BoxFit.cover,
                                  color: MAIN_COLOR,
                                ),
                                SizedBox(width: 7,height: 20,),
                                Text(package.loyaltyPointText??"",
                                  style: GoogleFonts.roboto (
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: MAIN_COLOR
                                  ),),
                              ],
                            )
                          ],
                        ),
                      )
                  )
                ],
              ),
              package.discount == null?Container():
              Positioned(
                  child: Container(
                    width: 120,
                    padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(7),
                            topLeft: Radius.circular(10)
                        )
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.star,color:MAIN_COLOR,size: 18,),
                        SizedBox(width: 3,),
                        Text(package.discount!.title!,
                            style: GoogleFonts.raleway (
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: MAIN_COLOR
                            )
                        )
                      ],
                    ),
                  )
              )
            ],
          ),
          Container(
            height: 55,
            padding: EdgeInsets.only(right: 12,left: 12),
            decoration: BoxDecoration(
                color: MAIN_COLOR,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Includes:",
                              style: GoogleFonts.raleway (
                                  fontSize: 14,
                                  color: Colors.amber,
                                  height: 1
                              ),
                            ),
                            Row(
                              children: package.amenities!.map((e) => Padding(
                                padding: const EdgeInsets.only(right: 10,top: 5,bottom: 5),
                                child: SvgPicture.network(e.icon!,color: Colors.amber,height: 15,width: 15,),
                              )).toList(),
                            )
                          ],
                        )
                      ],
                    )),
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Starts from",
                        style: GoogleFonts.raleway (
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      Text("৳ "+NumberFormat("#,##,000").format(package.startingPrice),
                        style: GoogleFonts.raleway (
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            height: 1
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
