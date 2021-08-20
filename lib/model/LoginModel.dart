class LoginModel{
  String? token;
  String? refreshToken;
  DateTime? expireAT;
  LoginModel({this.token,this.refreshToken,this.expireAT});

  factory LoginModel.fromJSON(data){
    return LoginModel(
      token: data["token"],
      refreshToken: data["refreshToken"],
      expireAT: DateTime.parse(data["expiresAt"])
    );
  }
}