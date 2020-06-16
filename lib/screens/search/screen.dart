import 'package:eh_redux/screens/search/args.dart';
import 'package:eh_redux/screens/search/body.dart';
import 'package:eh_redux/screens/search/filter.dart';
import 'package:eh_redux/screens/search/store.dart';
import 'package:eh_redux/screens/search/text_field.dart';
import 'package:eh_redux/stores/gallery.dart';
import 'package:eh_redux/widgets/stateful_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key key}) : super(key: key);

  static String routeName = '/search';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as SearchScreenArguments;
    final galleryStore = Provider.of<GalleryStore>(context);

    return Provider(
      create: (_) {
        final searchStore = SearchStore(galleryStore: galleryStore);

        if (args.query != null && args.query.isNotEmpty) {
          searchStore.setQuery(args.query);
          searchStore.updatePaginationKey();
        }

        return searchStore;
      },
      child: const _SearchScreenContent(),
    );
  }
}

class _SearchScreenContent extends StatefulWidget {
  const _SearchScreenContent({Key key}) : super(key: key);

  @override
  __SearchScreenContentState createState() => __SearchScreenContentState();
}

class __SearchScreenContentState extends State<_SearchScreenContent> {
  @override
  Widget build(BuildContext context) {
    final searchStore = Provider.of<SearchStore>(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final iconTheme =
        isDark ? theme.iconTheme : const IconThemeData(color: Colors.black);

    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: isDark ? theme.appBarTheme.color : Colors.white,
          iconTheme: iconTheme,
          title: const SearchTextField(),
          actions: <Widget>[
            const _SearchFilterButton(),
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search',
              onPressed: () {
                searchStore.updatePaginationKey();
                FocusScope.of(context).unfocus();
              },
            )
          ],
        ),
        body: const SearchBody(),
        endDrawer: StatefulWrapper(
          onDispose: () {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              searchStore.updatePaginationKey();
            });
          },
          builder: (_) => const SearchFilter(),
        ),
      ),
    );
  }
}

class _SearchFilterButton extends StatelessWidget {
  const _SearchFilterButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.filter_list),
      tooltip: 'Filter',
      onPressed: () {
        Scaffold.of(context).openEndDrawer();
      },
    );
  }
}
