class AmenityModel{
  String? title;
  String? icon;
  AmenityModel(this.title,this.icon);
  factory AmenityModel.fromJSON(data){
    return AmenityModel(data["title"],data["icon"]);
  }
}