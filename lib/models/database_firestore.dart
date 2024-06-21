class HomeModel
{
  dynamic status;
  HomeDataModel? data;
  HomeModel.fromJson(Map<String , dynamic> json ){
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}
class HomeDataModel
{
  List<MainGallery> mainGallery = [];
  List<RoyalMummiesGallery> royalMummiesGallery= [];
  List<TextileGallery> textileGallery= [];
  HomeDataModel.fromJson(Map<String , dynamic> json){
    json['Main Gallery'].forEach((element){
      mainGallery.add(MainGallery.fromJson(element));
    });
    json['Royal Mummies Gallery'].forEach((element){
      royalMummiesGallery.add(RoyalMummiesGallery.fromJson(element));
    });
    json['Textile Gallery'].forEach((element){
      textileGallery.add(TextileGallery.fromJson(element));
    });
  }
}
class MainGallery
{
  int? id;
  String? image;
  String? name;
  String? ArabicText;
  String? EnglishText;
  MainGallery.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    ArabicText = json['ArabicText'];
    EnglishText = json['EnglishText'];
    image = json['image'];
  }
  Map<String , dynamic> toMap(){
    return{
      'id':id,
      'name':name,
      'image':image,
      'ArabicText':ArabicText,
      'EnglishText': EnglishText,
    };
  }
}
class RoyalMummiesGallery
{
  int? id;
  String? image;
  String? name;
  String? ArabicText;
  String? EnglishText;
  RoyalMummiesGallery.fromJson(Map<String , dynamic> json){
    id = json['id'];
    name = json['name'];
    ArabicText = json['ArabicText'];
    EnglishText = json['EnglishText'];
    image = json['image'];
  }
  Map<String , dynamic> toMap(){
    return{
      'id':id,
      'name':name,
      'image':image,
      'ArabicText':ArabicText,
      'EnglishText': EnglishText,
    };
  }
}
class TextileGallery
{
  int? id;
  String? image;
  String? name;
  String? ArabicText;
  String? EnglishText;
  TextileGallery.fromJson(Map<String , dynamic> json){
    id = json['id'];
    name = json['name'];
    ArabicText = json['ArabicText'];
    EnglishText = json['EnglishText'];
    image = json['image'];
  }
  Map<String , dynamic> toMap(){
    return{
      'id':id,
      'name':name,
      'image':image,
      'ArabicText':ArabicText,
      'EnglishText': EnglishText,
    };
  }
}