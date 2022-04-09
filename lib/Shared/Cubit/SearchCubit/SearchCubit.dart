import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Model/SearchModel.dart';
import 'package:shop_app/Shared/Constants/Constants.dart';
import 'package:shop_app/Shared/Cubit/SearchCubit/SearchStates.dart';
import 'package:shop_app/Shared/DioHelper/DioHelper.dart';

import '../../CashHelper/end_points.dart';

class SearchCubit extends Cubit <SearchStates>{

  SearchCubit() : super(InitialSearchState());

 static SearchCubit get (context)=>BlocProvider.of(context);

 SearchModel? searchModel ;

 void GetSearch (String? txt){
   emit(LoadSearchState());
   DioHelper.PostDate(
       path: SEARCH,
       data: { "text": txt } ,
       token: TOKEN
   ).then((value){
     searchModel =SearchModel.fromJson(value.data);
     emit(SucessSearchState());
   }).catchError((onError){
     emit(ErrorSearchState());
   });



 }




}