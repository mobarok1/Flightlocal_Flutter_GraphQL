import 'package:frontend_application_test/model/LoginModel.dart';
import 'package:frontend_application_test/model/ResponseModel.dart';
import 'package:frontend_application_test/service/GraphQlClient.dart';
import 'package:graphql/client.dart';

class LoginService{

  static Future<ResponseModel?> loginNow(final email,final password) async{
    final GraphQLClient _client = getPublicGraphQLClient();
    ResponseModel? responseModel;

    final QueryOptions options = QueryOptions(
      document: gql(
        r'''
        mutation ($email : String!,$pass :String!){
          loginClient (
            auth: {
              email: $email
              deviceUuid: "7026a238-d078-48b5-862b-c3c7d21d8712"
            }
            password: $pass
          )
          {
            message
            statusCode
            result {
              token
              refreshToken
              expiresAt
            }
          }
        }
      ''',
      ),
      variables: {
        "email": email,
        "pass": password,
      },
    );
    final QueryResult result = await _client.query(options);
    int responseCode = 500;
    String message= "failed to login";
    if (result.hasException) {
      responseModel = ResponseModel(statusCode: responseCode, message: message);
    }else{
      print(result.data);
      var response = result.data;
      var _data = response!["loginClient"];
      responseCode = _data["statusCode"];
      message = _data["message"];
      if(responseCode == 200){
        LoginModel _loginInfo = LoginModel.fromJSON(_data["result"]);
        responseModel = ResponseModel(statusCode: responseCode, message: message,data: _loginInfo);
      }else{
        responseModel = ResponseModel(statusCode: responseCode, message: message);
      }

    }
    return responseModel;

  }
}