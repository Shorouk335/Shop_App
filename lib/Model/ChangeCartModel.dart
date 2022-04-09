class ChangeCartModel
{
  String? message;
  bool? status;

  ChangeCartModel.fromjson(Map<String,dynamic>json)
  {
    message = json['message'];
    status = json['status'];
  }
}