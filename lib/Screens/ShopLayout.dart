import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/Constants/Constants.dart';
import 'package:shop_app/Shared/Cubit/ShopCubit/ShopCubit.dart';
import 'package:shop_app/Shared/Cubit/ShopCubit/ShopStates.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()
        ..getProdectsData()
        ..getCategoriesData()
        ..getFavData()
        ..getProfileData()
        ..getCartData(),
      child: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            ShopCubit cubit = ShopCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text("ShopApp"),
                actions: [
                  IconButton(
                      onPressed: () {
                        NavigateToSearch(context);
                      },
                      icon: Icon(Icons.search)),
                  IconButton(
                      onPressed: () {
                        NavigateToCartScreen(context);
                      },
                      icon: Icon(Icons.shopping_cart))
                ],
              ),
              body: cubit.Pages[cubit.CurrentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.CurrentIndex,
                onTap: (index) {
                  cubit.ChangeCurrentIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shop), label: "Categories"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: "Favorite"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: "  Settings"),
                  //interests
                ],
              ),
            );
          }),
    );
  }
}
