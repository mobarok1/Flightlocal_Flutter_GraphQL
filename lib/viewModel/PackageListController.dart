import 'package:frontend_application_test/model/PackageModel.dart';
import 'package:frontend_application_test/model/ResponseModel.dart';
import 'package:frontend_application_test/service/PackageService.dart';
import 'package:get/get.dart';

class PackageListController extends GetxController{
  RxList<PackageModel> packageList = <PackageModel>[].obs;
  var count = 0.obs;
  var loading = false.obs;
  var error = false.obs;

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    loadDataFromServer();
  }

  loadDataFromServer() async{
    loading.value = true;
    PackageListResponseModel? response =  await PackageService.getAvailablePackage();    loading.value = false;
    error.value = response==null?true:response.statusCode==200?false:true;
    if(!error.value){
      packageList.value = response!.packages;
      count.value = response.count;
    }else{
      count.value = 0;
      packageList.value = [];
    }
  }
}