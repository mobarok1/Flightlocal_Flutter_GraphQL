import 'package:flutter/material.dart';
import 'package:frontend_application_test/model/LoginModel.dart';
import 'package:frontend_application_test/model/ResponseModel.dart';
import 'package:frontend_application_test/service/LoginService.dart';
import 'package:get/get.dart';

LoginModel? loginInfo;

class LoginController extends GetxController{
  var loading = false.obs;
  var error = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  loginNow(final email,final password,final context) async{
    loading.value = true;
    ResponseModel? response = await LoginService.loginNow(email, password);
    loading.value = false;
    error.value = response==null?true:response.statusCode==200?false:true;
    if(!error.value){
      loginInfo = response!.data;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Success"),backgroundColor: Colors.green[900],));

    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response!.message),backgroundColor: Colors.red[900],));
    }

  }

}