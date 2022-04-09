 class ChangeFavoritesModel
 {
   String? message;
   bool? status;

   ChangeFavoritesModel.fromjson(Map<String,dynamic>json)
   {
     message = json['message'];
     status = json['status'];
   }
 }