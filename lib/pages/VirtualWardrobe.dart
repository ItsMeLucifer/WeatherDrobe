import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weatherdrobe/main.dart';
import 'package:weatherdrobe/widgets/Virtual Wardrobe Widgets/virtual_wardrobe_main_view.dart';

class VirtualWardrobe extends StatefulWidget {
  @override
  _VirtualWardrobe createState() => _VirtualWardrobe();
}

class _VirtualWardrobe extends State<VirtualWardrobe> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    context.read(virtualWardrobe).userCollections = null;
    await Future.delayed(Duration(milliseconds: 1000));

    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  Widget build(BuildContext context) {
    const Color primaryColor = Color.fromRGBO(0, 0, 0, 0.5);
    return SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: WaterDropHeader(waterDropColor: primaryColor),
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        controller: _refreshController,
        child: VirtualWardrobeMainView());
  }
}
