import 'package:frontend_application_test/model/AmenityModel.dart';
import 'package:frontend_application_test/model/DiscountModel.dart';

class PackageModel{
  String uid;
  String title;
  int? startingPrice;
  String? thumbnail;
  List<AmenityModel>? amenities;
  DiscountModel? discount;
  String? loyaltyPointText;
  String? durationText;
  String? description;

  PackageModel({required this.uid, required this.title, this.startingPrice, this.thumbnail,
      this.amenities, this.discount, this.loyaltyPointText,this.durationText, this.description});
  
  factory PackageModel.fromJSON(data){
    return PackageModel(
        uid: data["uid"],
        title: data["title"],
        startingPrice: data["startingPrice"],
        loyaltyPointText: data["loyaltyPointText"],
        thumbnail: data["thumbnail"],
        durationText: data["durationText"],
        description: data["description"],
        discount: data["discount"]==null?null:DiscountModel.fromJSON(data["discount"]),
        amenities: data["amenities"]==null?[]:data["amenities"].map<AmenityModel>((e)=>AmenityModel.fromJSON(e)).toList()
    );
  }
}