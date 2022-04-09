
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Model/UserDateModel.dart';
import 'package:shop_app/Shared/Constants/Constants.dart';
import 'package:shop_app/Shared/Cubit/LoginCubit/LoginStates.dart';
import 'package:shop_app/Shared/DioHelper/DioHelper.dart';

class LoginCubit extends Cubit<LoginStates> {

  LoginCubit() : super(InitialLoginState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoadLoginState());
    DioHelper.PostDate(
        path: "login", data: {"email": email, "password": password} ).then((value){
      userDateModel = UserDateModel.fromJson(value.data);
          emit(SuccessLoginState(userDateModel: userDateModel));
    }).catchError((error){
      emit(ErrorLoginState(error: error));
    });
  }
}
