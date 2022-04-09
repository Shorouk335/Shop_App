
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Model/CartModel.dart';
import 'package:shop_app/Model/CategoriesDataModel.dart';
import 'package:shop_app/Model/ChangeCartModel.dart';
import 'package:shop_app/Model/ProductDetailsModel.dart';
import 'package:shop_app/Model/ProfileModel.dart';
import 'package:shop_app/Model/ShopDataModel.dart';
import 'package:shop_app/Model/UserDateModel.dart';
import 'package:shop_app/Model/change_favorites_model.dart';
import 'package:shop_app/Model/favorite_model.dart';
import 'package:shop_app/Screens/FavoriteScreen.dart';
import 'package:shop_app/Screens/HomeScreen.dart';
import 'package:shop_app/Screens/CategoriesScreen.dart';
import 'package:shop_app/Screens/SettingScreen.dart';
import 'package:shop_app/Shared/CashHelper/end_points.dart';
import 'package:shop_app/Shared/Constants/Constants.dart';
import 'package:shop_app/Shared/Cubit/ShopCubit/ShopStates.dart';
import 'package:shop_app/Shared/DioHelper/DioHelper.dart';

class ShopCubit extends Cubit<ShopStates> {

  ShopCubit() : super(InitialShopState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int CurrentIndex = 0;

  void ChangeCurrentIndex(index) {
    CurrentIndex = index;
    emit(ChangeCurrentIndexState());
  }

  List Pages = [
    HomeScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingScreen(),
  ];

  int indexCarouselSider = 0;

  void ChangeindexCarouselSider(index) {
    indexCarouselSider = index;
    emit(ChangeIndexCarouselSliderState());
  }

  ShopDataModel? shopDataModel;
  void getProdectsData() async {
    emit(LoadShopState());
    await DioHelper.GetDate(
        path: HOME,
      token: TOKEN
    ).then((value) {
      shopDataModel = ShopDataModel.fromJson(value.data);
      shopDataModel!.data!.products.forEach((element) {
        FavoriteList.addAll({element.id: element.in_favorites});
      });
      emit(SuccessShopState());
    }).catchError((error) {
      emit(ErrorShopState());
    });
  }


  CategoriesDataModel? categoriesDataModel;

  void getCategoriesData() async {
    emit(LoadCategoriesState());
    await DioHelper.GetDate(path:CATEGORIES ,token: TOKEN).then((value) {
      categoriesDataModel = CategoriesDataModel.fromJson(value.data);
      emit(SuccessCategoriesState());
    }).catchError((error) {
      emit(ErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  // this list to change favorite icon only
  Map<int, dynamic> FavoriteList = {};

  void changeFavorites(int? productId)
  {
    FavoriteList[productId!] = !FavoriteList[productId];
    DioHelper.PostDate(
      path: FAVORITES,
      data: {
        "product_id":productId,
      },
      token: TOKEN,
    ).then((value)
    {
      changeFavoritesModel = ChangeFavoritesModel.fromjson(value.data);
      if(!changeFavoritesModel!.status!)
      {
        FavoriteList[productId] = !FavoriteList[productId]!;
      }
      else {
        getFavData();
      }
      emit(SuccessChangeFavoritesState(changeFavoritesModel: changeFavoritesModel));
    }).catchError((error)
    {
      FavoriteList[productId] = !FavoriteList[productId];
      print("error in changeFavorites ${error.toString()}");
      emit(ErrorChangeFavoritesState());
    });
  }

  FavoritesModel?  favoritesModel;
  void getFavData()
  {
    DioHelper.GetDate(
      path: FAVORITES,
      token:  TOKEN,
    ).then((value)
    {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(SuccessGetFavoritesDataState());
    }).catchError((error){
      print("error in getFavoritesData ${error.toString()}");
      emit(ErrorGetFavoritesDataState());
    });
  }
  ProfileModel? profileModel ;

  void getProfileData ()async{
   await DioHelper.GetDate(path: PROFILE ,token: TOKEN).then((value){
     profileModel = ProfileModel.fromJson(value.data);
      emit(SuccessGetProfileDataState());
    }).catchError((error){
      emit(ErrorGetProfileDataState());
    });
  }

  void UpdateProfile({
    required String? name,
    required String? email,
    required String? phone,
  })async{
    await DioHelper.PutDate(path: UPDATE_PROFILE, data: {
      "name": name ,
      "email": email ,
      "phone" : phone
    } ,
    token: TOKEN
    ).then((value){
      userDateModel =UserDateModel.fromJson(value.data);
     emit(SuccessUPDateProfileDataState(userDateModel: userDateModel));
    }).catchError((error){
      emit(ErrorUpdateProfileDataState());
    });

  }


  ChangeCartModel? changeCartModel ;

  void ChangeCart(int? productId)async
  {
    DioHelper.PostDate(
      path: CART,
      data: {
        "product_id":productId,
      },
      token: TOKEN,
    ).then((value)
    {
      changeCartModel =ChangeCartModel.fromjson(value.data);
        getCartData();
        getProductsDetails(id: productId);

      emit(SucessChangeCartStates(changeCartModel: changeCartModel));
    }).catchError((error)
    {
      emit(ErrorChangeCartStates());
    }); }

  CartModel?  cartModel;
  void getCartData()async
  {
    await DioHelper.GetDate(
      path: CART,
      token:  TOKEN,
    ).then((value)
    {
      cartModel =CartModel.fromJson(value.data);
      emit(SucessCartStates());
    }).catchError((error){
      print("error in getFavoritesData ${error.toString()}");
      emit(ErrorCartStates());
    });
  }

  ProductDetailsmodel? productDetailsmodel  ;
  void getProductsDetails ({
     required int? id
       })async{
       await DioHelper.GetDate(path: "products/$id" ,token: TOKEN).then((value){
         productDetailsmodel =ProductDetailsmodel.fromJson(value.data);
         emit(SucessGetDetailsProductStates());
       }).catchError((erroe){
         emit(ErrorGetDetailsProductStates());
       });
 }


}
