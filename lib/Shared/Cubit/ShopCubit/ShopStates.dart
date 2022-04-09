import 'package:shop_app/Model/ChangeCartModel.dart';
import 'package:shop_app/Model/ProfileModel.dart';
import 'package:shop_app/Model/UserDateModel.dart';
import 'package:shop_app/Model/change_favorites_model.dart';

abstract class ShopStates {}

class InitialShopState extends ShopStates {}

class ChangeCurrentIndexState extends ShopStates {}

class ChangeIndexCarouselSliderState extends ShopStates {}

class LoadShopState extends ShopStates {}

class SuccessShopState extends ShopStates {}

class ErrorShopState extends ShopStates {}

class LoadCategoriesState extends ShopStates {}

class SuccessCategoriesState extends ShopStates {}

class ErrorCategoriesState extends ShopStates {}

class SuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel? changeFavoritesModel ;
  SuccessChangeFavoritesState({required this.changeFavoritesModel});
}

class ErrorChangeFavoritesState extends ShopStates {}

class SuccessGetFavoritesDataState extends ShopStates {}

class ErrorGetFavoritesDataState extends ShopStates {}

class SuccessGetProfileDataState extends ShopStates {
}

class ErrorGetProfileDataState extends ShopStates {}

class SuccessUPDateProfileDataState extends ShopStates {
   UserDateModel? userDateModel ;
   SuccessUPDateProfileDataState({required this.userDateModel});
}

class ErrorUpdateProfileDataState extends ShopStates {}
class SucessChangeCartStates extends ShopStates {
  ChangeCartModel? changeCartModel ;
  SucessChangeCartStates({required this.changeCartModel});
}

class ErrorChangeCartStates extends ShopStates {}
class SucessCartStates extends ShopStates {}
class ErrorCartStates extends ShopStates {}
class SucessGetDetailsProductStates extends ShopStates {}
class ErrorGetDetailsProductStates extends ShopStates {}


