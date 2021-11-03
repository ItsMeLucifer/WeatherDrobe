import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weatherdrobe/main.dart';
import 'package:weatherdrobe/widgets/Virtual Wardrobe Widgets/virtual_wardrobe_main_view.dart';
import 'package:weatherdrobe/widgets/Virtual%20Wardrobe%20Widgets/cloth_creator_page_view.dart';

class VirtualWardrobe extends StatefulWidget {
  @override
  _VirtualWardrobe createState() => _VirtualWardrobe();
}

class _VirtualWardrobe extends State<VirtualWardrobe> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    context.read(virtualWardrobe).userCollections = null;
    context.read(virtualWardrobe).getGarments(context.read(firebaseAuth).auth);
    await Future.delayed(Duration(milliseconds: 1000));

    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  void _navigateToClothCreator(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ClothCreatorPV()));
  }

  Widget build(BuildContext context) {
    const Color primaryColor = Color.fromRGBO(0, 0, 0, 0.5);
    return Scaffold(
      floatingActionButton: Container(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          onPressed: () {
            _navigateToClothCreator(context);
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.black,
        ),
      ),
      backgroundColor: Color.fromRGBO(0, 0, 0, 0),
      body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: WaterDropHeader(waterDropColor: primaryColor),
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          controller: _refreshController,
          child: VirtualWardrobeMainView()),
    );
  }
}
