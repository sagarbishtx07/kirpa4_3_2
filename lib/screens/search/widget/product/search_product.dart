import 'package:kirpa/constants/currencies.dart';
import 'package:kirpa/models/models.dart';
import 'package:kirpa/screens/screens.dart';
import 'package:kirpa/screens/search/widget/product/recent_product.dart';
import 'package:kirpa/service/helpers/request_helper.dart';
import 'package:kirpa/store/search/search_store.dart';
import 'package:kirpa/store/store.dart';
import 'package:kirpa/utils/debug.dart';
import 'package:dio/dio.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kirpa/mixins/unescape_mixin.dart';

class Search extends StatefulWidget {
  final String? search;
  final ValueChanged<String>? onChange;

  const Search({
    Key? key,
    this.search,
    this.onChange,
  }) : super(key: key);

  @override
  State<Search> createState() => __SearchState();
}

class __SearchState extends State<Search> {
  List<PostSearch> _data = [];
  CancelToken? _token;
  SearchStore? searchStore;

  @override
  void dispose() {
    _token?.cancel('cancelled');
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    SettingStore settingStore = Provider.of<SettingStore>(context);
    searchStore = SearchStore(settingStore.persistHelper);
    super.didChangeDependencies();
  }

  Future<void> search(CancelToken? token) async {
    try {
      SettingStore settingStore = Provider.of<SettingStore>(context);
      PostStore postStore = PostStore(Provider.of<RequestHelper>(context));
      List<PostSearch>? data = await postStore.search(queryParameters: {
        'search': widget.search,
        'type': 'post',
        'subtype': 'product',
        'lang': settingStore.locale,
        CURRENCY_PARAM: settingStore.currency,
        // 'app-builder-search': widget.search,
      }, cancelToken: token);
      setState(() {
        _data = List<PostSearch>.of(data!);
      });
    } catch (e) {
      avoidPrint('Cancel fetch');
    }
  }

  @override
  void didUpdateWidget(oldWidget) {
    if (_token != null) {
      _token?.cancel('cancelled');
    }

    setState(() {
      _token = CancelToken();
    });

    search(_token);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.search == '') {
      return RecentSearch(
        search: widget.search,
        data: _data,
        searchStore: searchStore,
        onChange: widget.onChange,
      );
    }
    return ListView.separated(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          Navigator.pushNamed(context, '${ProductScreen.routeName}/${_data[index].id}');
          searchStore!.addSearch(_data[index].title!);
        },
        leading: const Icon(FeatherIcons.search, size: 22),
        horizontalTitleGap: 0,
        title: Text(unescape(_data[index].title!), style: Theme.of(context).textTheme.titleSmall),
      ),
      itemCount: _data.length,
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
