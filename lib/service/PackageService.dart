import 'package:frontend_application_test/model/PackageModel.dart';
import 'package:frontend_application_test/model/ResponseModel.dart';
import 'package:frontend_application_test/service/GraphQlClient.dart';
import 'package:graphql/client.dart';

class PackageService{
  static Future<PackageListResponseModel?> getAvailablePackage(int skip,int limit) async{
    final GraphQLClient _client = getSecureGraphQLClient();
    PackageListResponseModel? responseModel;

    final QueryOptions options = QueryOptions(
      document: gql(
        r'''
        query($skip:Int,$limit : Int){
          getPackages(
            pagination:{
              skip: $skip
              limit: $limit
            }
          )
          {
            statusCode
            message
            result {
              count
              packages {
                uid
                title
                startingPrice
                thumbnail
                amenities {
                  title
                  icon
                }
                discount {
                  title
                  amount
                }
                durationText
                loyaltyPointText
                description
              }
            }
          }
        }
      ''',
      ),
      variables: {
        "skip":skip,
        "limit":limit
      }
    );
    print("skip $skip and limit $limit");
    final QueryResult result = await _client.query(options);
    int responseCode = 500;
    int count = 0;
    String message= "failed to load data";
    if (result.hasException) {
      responseModel = PackageListResponseModel(statusCode: responseCode,count: count, message: message,packages: []);
    }else{
      var response = result.data;
      var _data = response!["getPackages"];
      responseCode = _data["statusCode"];
      message = _data["message"];
      if(responseCode == 200){
        count = _data["result"]["count"];
        List<PackageModel> packList = [];
        _data["result"]["packages"].forEach((element) {
            packList.add(PackageModel.fromJSON(element));
        });
        responseModel = PackageListResponseModel(statusCode: responseCode, message: message,count: count,packages: packList);
      }else{
        responseModel = PackageListResponseModel(statusCode: responseCode, message: message, count: count,packages: []);
      }

    }
    return responseModel;

  }
}