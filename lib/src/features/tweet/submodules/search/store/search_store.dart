import 'package:mobx/mobx.dart';
import 'package:tweet_app/src/features/tweet/models/user_request_model.dart';
import 'package:tweet_app/src/features/tweet/submodules/search/services/user_filter_service.dart';

part 'search_store.g.dart';

enum SearchState { idle, success, loading, error, noUserFound }

class SearchStore = _SearchStore with _$SearchStore;

abstract class _SearchStore with Store {
  final UserFilterService filterService;

  _SearchStore({required this.filterService});

  @observable
  SearchState searchState = SearchState.idle;

  List<UserRequestModel> findedUsers = [];

  @action
  void setScreenState({required SearchState newState}) {
    searchState = newState;
  }

  loadSearchedUsers({required String searchInput}) async {
    setScreenState(newState: SearchState.loading);
    try {
      if (searchInput == '') {
        setScreenState(newState: SearchState.idle);
      } else {
        findedUsers = await filterService.findedUsersWithProfileNetworkUrl(
          searchInput: searchInput,
        );
        findedUsers.isNotEmpty
            ? setScreenState(newState: SearchState.success)
            : setScreenState(newState: SearchState.noUserFound);
      }
    } on Exception {
      setScreenState(newState: SearchState.error);
    }
  }
}
