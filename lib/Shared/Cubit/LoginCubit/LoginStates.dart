
import 'package:shop_app/Model/UserDateModel.dart';

abstract class LoginStates {}

class InitialLoginState extends LoginStates {}

class LoadLoginState extends LoginStates {}

class SuccessLoginState extends LoginStates {
  final UserDateModel? userDateModel ;
  SuccessLoginState({required this.userDateModel});
}

class ErrorLoginState extends LoginStates {
  var error;
  ErrorLoginState({required this.error});
}
