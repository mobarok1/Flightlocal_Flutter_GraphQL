class DiscountModel{
  String? title;
  double? amount;
  DiscountModel(this.title,this.amount);
  factory DiscountModel.fromJSON(data){
    return DiscountModel(data["title"],data["icon"]);
  }
}