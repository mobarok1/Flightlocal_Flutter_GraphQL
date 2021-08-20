import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend_application_test/service/LoginService.dart';
import 'package:frontend_application_test/util/AppConstant.dart';
import 'package:frontend_application_test/view/page/PackageListPage.dart';
import 'package:frontend_application_test/view/widget/bezierContainer.dart';
import 'package:frontend_application_test/view/widget/loader.dart';
import 'package:frontend_application_test/viewModel/LoginController.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _form = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginController loginController = Get.put(LoginController());


  Widget inputField({required String title,required String hints,required Validator validator,required TextEditingController controller,bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              obscureText: isPassword,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validator,
              controller: controller,
              decoration: InputDecoration(
                  hintText: hints,
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        inputField(
          title: "Email",
          hints: "Email",
          controller: emailController,
          validator: (str){
            if(str!.isEmpty)
              return "required valid email address";
            else
              return null;
          }

        ),
        inputField(
            title: "Password",
            hints: "Password",
            controller: passwordController,
            validator: (str){
              if(str!.isEmpty)
                return "required password";
              else
                return null;
            },
            isPassword: true
        ),
      ],
    );
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

  Widget continueButton(){
    return TextButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>PackageList()));
        },
        child: Text("Continue without login",style: TextStyle(fontSize: 16),)
    );
  }

  Widget loginButton(){
    return ElevatedButton(
        onPressed: (){
          if(!_form.currentState!.validate()){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All filed are required !"),backgroundColor: Colors.red[900],));
          }else{
            loginController.loginNow(emailController.text.toString(), passwordController.text.toString(),context);
          }
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) => states.any((element) => MaterialState.pressed == element)?Color(0xFF10329A):Color(0xff00276c)),
            padding: MaterialStateProperty.resolveWith((states) =>EdgeInsets.symmetric(vertical: 15)),
            shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))))
        ),
        child: Text("Login",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.text = "devteam@saimonglobal.com";
    passwordController.text = "12345678";
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Positioned(
                    top: -size.height * .15,
                    right: -MediaQuery.of(context).size.width * .4,
                    child: BezierContainer()),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _form,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: size.height * .2),
                          getTitle(),
                          SizedBox(height: 50),
                          _emailPasswordWidget(),
                          SizedBox(height: 20),
                          loginButton(),
                          SizedBox(height: 20),
                          continueButton()
                        ],
                      ),
                    ),
                  ),
                ),
                Obx((){
                  if(loginInfo != null){
                    Future.delayed(Duration.zero, () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx)=>PackageList()), (route) => false);
                    });

                  }
                  if(loginController.loading.value){
                    return Positioned(
                        child: loaderContainer(size)
                    );
                  }
                  return Container();
                }),

              ],
            )));

  }


}

typedef String? Validator(String? str);