import 'package:tweet_app/src/features/tweet/services/get_user_information_service.dart';
import 'package:tweet_app/src/features/tweet/submodules/search/services/user_filter_service.dart';

class SearchStore {
  final UserFilterService filterService;

  final GetUserInformationService getUser;

  SearchStore({required this.filterService, required this.getUser});

  // a({required String whereInput}) async {
  //   List<String> a = await filterService.get(whereInput: whereInput);
  //   print('SearchStore: $a');
  // }
}
