import 'package:frontend_application_test/util/AppConstant.dart';
import 'package:frontend_application_test/viewModel/LoginController.dart';
import 'package:graphql/client.dart';

GraphQLClient getPublicGraphQLClient() {
  final Link _link = HttpLink(
    BASE_URL+'graphql',
  );
  return GraphQLClient(
    cache: GraphQLCache(),
    link: _link,
  );
}
GraphQLClient getSecureGraphQLClient() {
  final Link _link = HttpLink(
    BASE_URL+'graphql',
    defaultHeaders: {
      'Authorization': loginInfo==null?"":loginInfo!.token!,
    },
  );
  return GraphQLClient(
    cache: GraphQLCache(),
    link: _link,
  );
}

