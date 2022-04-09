import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Screens/ShopLayout.dart';
import 'package:shop_app/Screens/LoginScreen.dart';
import 'package:shop_app/Screens/OnBoarding.dart';
import 'package:shop_app/Shared/CashHelper/CashHelper.dart';
import 'package:shop_app/Shared/Constants/Constants.dart';
import 'package:shop_app/Shared/DioHelper/DioHelper.dart';
import 'package:shop_app/Shared/Style/Theme.dart';
main() async{
   WidgetsFlutterBinding.ensureInitialized();
   DioHelper.inti();
   await CashHelper.init();
   Widget RightScreen;
   if (onBoarding != null){
     if (tokenShop != null ){
       RightScreen = ShopLayout();
     }
     else {
       RightScreen = LoginScreen();
     }
   }else
     RightScreen = OnBoarding();

  runApp(ShopApp(RightScreen:RightScreen));
}
class ShopApp extends StatelessWidget {
  Widget RightScreen ;
  ShopApp({required this.RightScreen});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        // use RightScreen in home
        home:OnBoarding(),

    );
  }
}
