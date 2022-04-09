import 'package:flutter/material.dart';
import 'package:shop_app/Model/UserDateModel.dart';
import 'package:shop_app/Screens/CartScreen.dart';
import 'package:shop_app/Screens/ProductsDetails.dart';
import 'package:shop_app/Screens/SearchScreen.dart';
import 'package:shop_app/Screens/ShopLayout.dart';
import 'package:shop_app/Screens/LoginScreen.dart';
import 'package:shop_app/Screens/RegisterScreen.dart';
import 'package:shop_app/Shared/CashHelper/CashHelper.dart';
import 'package:shop_app/Shared/Components/FlutterToAstItem.dart';

// use shared preverance to open app in right screen only
dynamic onBoarding = CashHelper.getDate(key: "onBoarding");

dynamic tokenShop = CashHelper.getDate(key: "token");
// save token when user log in and use it in all app not token in shared preferance
String TOKEN = "QONjJKM48NX0uaRGXcn4R61qsDNhiC0dlrDcFlMs0b7g8HfV1FFhretFHGH3FpY2iNzynt";

UserDateModel? userDateModel;

void NavigateToSearch(context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return SearchScreen();
  }));
}

void NavigateToLogin(context) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    return LoginScreen();
  }));
}

void NavigateToRegister(context) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    return RegisterScreen();
  }));
}

void NavigateToShopLayout(context) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    return ShopLayout();
  }));
}

void OnBoardingTrue(context) {
  CashHelper.savebool(key: "OnBoarding", value: true).then((value) {
    if (value) NavigateToLogin(context);
  });
}

void SignOut(context) {
  CashHelper.removeDate(key: "token").then((value) {
    if (value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return LoginScreen();
      }));
    }
  });
}

void LoginInShopApp(context, {required message, required token}) {
  FlutterToAstItem(txt: message, state: ToastStates.SUCCESS);
  CashHelper.saveString(key: "token", value: token);
  TOKEN = token;
  print(token);
  NavigateToShopLayout(context);
}

NavigateToProductsDetails(context, productsId) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return ProductsDetails(productsId: productsId,);
  }));
}

NavigateToCartScreen(context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) {
        return CartScreen();
      },
    ),
  );
}
