import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:tweet_app/src/features/tweet/submodules/search/components/search_header.dart';
import 'package:tweet_app/src/features/tweet/submodules/search/components/user_tile_sliver_list.dart';
import 'package:tweet_app/src/features/tweet/submodules/search/store/search_store.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchStore searchStore = Modular.get<SearchStore>();

  @override
  void initState() {
    autorun((_) {
      if (searchStore.searchState == SearchState.error) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Error in search.'),
        ));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SearchHeader(
                onChangeTextFunction: (value) {
                  searchStore.loadSearchedUsers(searchInput: value);
                },
              ),
            ),
            Observer(
              builder: (_) {
                if (searchStore.searchState == SearchState.loading) {
                  return const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: LinearProgressIndicator(),
                    ),
                  );
                } else if (searchStore.searchState == SearchState.success) {
                  return UserTileSliverList(users: searchStore.findedUsers);
                } else if (searchStore.searchState == SearchState.noUserFound) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: Text(
                          'No users found!',
                          style: TextStyle(color: Colors.red, fontSize: 22),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SliverToBoxAdapter();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
