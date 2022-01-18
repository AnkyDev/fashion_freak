class productmodel{
  String title;
  String price;
  String productid;
  String imgUrl;
  bool isFavourite;
  productmodel({
    required this.title,
    required this.price,
    required this.productid,
    this.isFavourite = false,
    required this.imgUrl,
});
}