import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jumeoni/model/user.dart';
import 'package:get/get.dart';

import 'register_drink.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
    required this.itemCount,
    required this.onRefresh,
    required this.builder,
  });

  final int itemCount;
  final Future<void> Function() onRefresh;
  final Widget Function(BuildContext context, int index) builder;

  @override
  Widget build(BuildContext context) {
    var curUser = FirebaseAuth.instance.currentUser;
    var name = curUser?.providerData[0].displayName;
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("Hi ${curUser?.email}"),
    //     actions: [
    //       DropdownButton(
    //         icon: const Icon(Icons.more_vert),
    //         items: const [
    //           DropdownMenuItem(value: "1", child: Text("register"))
    //         ],
    //         onChanged: (String? newValue) {
    //           // Get.toNamed("/register_drink");
    //           showModalBottomSheet(
    //               context: context,
    //               isScrollControlled: true,
    //               builder: (BuildContext context) {
    //                 return SizedBox(
    //                     height: MediaQuery.of(context).size.height * 0.7,
    //                     child: const RegisterDrink());
    //               });
    //         },
    //       ),
    //     ],
    //   ),
    //   body: const Center(
    //     child: Column(
    //       children: [],
    //     ),
    //   ),
    // );
    if (Platform.isIOS) {
      return CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          CupertinoSliverRefreshControl(
            refreshIndicatorExtent: 3.0,
            refreshTriggerPullDistance: 100.0,
            onRefresh: onRefresh,
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            builder,
            childCount: itemCount,
          ))
        ],
      );
    } else {
      return RefreshIndicator(
          onRefresh: onRefresh,
          child: ListView.builder(
            itemCount: itemCount,
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            itemBuilder: builder,
          ));
    }
  }
}
