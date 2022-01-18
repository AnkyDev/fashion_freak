class OrderModelLondry {
  String title;
  String price;
  String date;
  String payment;
  String dateBuy;
  String city;
  String timeBuy;
  OrderModelLondry(
      {required this.date,
      required this.payment,
      required this.price,
      required this.title,
      required this.dateBuy,
      required this.timeBuy,required this.city});
}
