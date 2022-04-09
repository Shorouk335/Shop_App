
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:shop_app/Model/UserDateModel.dart';
import 'package:shop_app/Shared/Constants/Constants.dart';
import 'package:shop_app/Shared/Cubit/RegisterCubit/RegisterState.dart';
import 'package:shop_app/Shared/DioHelper/DioHelper.dart';

class RegisterCubit extends Cubit<RegisterState>{

  RegisterCubit() : super(InitialRegisterState());

  static RegisterCubit get(context) => BlocProvider.of(context);


 void  UserRegister ({
     required String? name ,
     required String? email ,
     required String? phone ,
     required String? password ,

})async{
    emit(LoadRegisterState());
   await DioHelper.PostDate(path: "register", data: {"name": name ,"email":email ,"phone": phone ,"password":password} ).then((value){
  userDateModel = UserDateModel.fromJson(value.data);
    emit(SuccessRegisterState(userDateModel: userDateModel ));
  }).catchError((){
    emit(ErrorRegisterState());
  });
    
    
    
  }




}