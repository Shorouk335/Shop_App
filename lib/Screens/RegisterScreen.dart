import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/Components/FlutterToAstItem.dart';
import 'package:shop_app/Shared/Components/TextFormItem.dart';
import 'package:shop_app/Shared/Cubit/RegisterCubit/RegisterCubit.dart';
import 'package:shop_app/Shared/Cubit/RegisterCubit/RegisterState.dart';
import '../Shared/Constants/Constants.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var PhoneController = TextEditingController();
  var nameController = TextEditingController();
  bool hidePassword = true;
  IconData PasswordIcon = Icons.visibility_off;
  var FormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterState>(
        listener: (context, state) {
          if (state is SuccessRegisterState){
            if (state.userDateModel!.status!){
              LoginInShopApp(context ,message: state.userDateModel!.message!,token: state.userDateModel!.data!.token!);
            }else {
              FlutterToAstItem(txt:"${state.userDateModel!.message!}",state: ToastStates.ERROR );
            }
          }
        } ,
       builder: (context,state){
          return SafeArea(
            child: Scaffold(
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: FormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "REGISTER",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(fontSize: 30),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Register now to browse our hot offers",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormWidget(
                            context: context,
                            txt: "name",
                            preficon: Icons.account_circle,
                            Control: nameController,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormWidget(
                            context: context,
                            txt: "Email",
                            preficon: Icons.email,
                            Control: emailController,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormWidget(
                            context: context,
                            txt: "Password",
                            preficon: Icons.lock,
                            Control: passwordController,
                            type: TextInputType.visiblePassword,
                            ispass: hidePassword,
                            sufficon: PasswordIcon,
                            onTap: () {
                              setState(() {
                                hidePassword = !hidePassword;
                                (hidePassword)
                                    ? (PasswordIcon = Icons.visibility_off)
                                    : (PasswordIcon = Icons.remove_red_eye_outlined);
                              });
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormWidget(
                            context: context,
                            txt: "Phone",
                            preficon: Icons.phone,
                            Control: PhoneController,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoadRegisterState,
                            fallback: (context)=>Center(child: CircularProgressIndicator(color: Colors.grey,)),
                            builder: (context)=>
                                MaterialButton(
                              minWidth: double.infinity,
                              height: 50,
                              onPressed: () {
                                if (FormKey.currentState!.validate()) {
                                  RegisterCubit.get(context).UserRegister(name: nameController.text, email: emailController.text, phone: PhoneController.text, password: passwordController.text);
                                }
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have any account?"),
                              TextButton(
                                  onPressed: () {
                                    NavigateToLogin(context);
                                  },
                                  child: Text(
                                    "LOGIN",
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
       }
      ),
    );
  }
}
