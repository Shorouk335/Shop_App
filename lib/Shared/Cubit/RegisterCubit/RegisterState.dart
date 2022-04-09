import 'package:shop_app/Model/UserDateModel.dart';

abstract class RegisterState {}
class InitialRegisterState extends RegisterState {}
class LoadRegisterState extends RegisterState {}
class SuccessRegisterState extends RegisterState {
 final UserDateModel? userDateModel ;
  SuccessRegisterState({required this.userDateModel});
}
class ErrorRegisterState extends RegisterState {}
