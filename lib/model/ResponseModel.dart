import 'package:frontend_application_test/model/PackageModel.dart';

class ResponseModel{
  int statusCode;
  String message;
  dynamic data;
  ResponseModel({required this.statusCode,required this.message,this.data});
}

class PackageListResponseModel{
  int statusCode;
  int count;
  String message;
  List<PackageModel> packages;
  PackageListResponseModel({required this.statusCode,required this.count,required this.message,required this.packages});
}