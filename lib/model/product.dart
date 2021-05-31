class ProductModel {
  double price;
  String title;
  String subTitle;
  String imgPath;
  int discount;
  double star;
  ProductModel(
      {this.price,
      this.imgPath,
      this.subTitle,
      this.title,
      this.discount = 0,
      this.star});
}

List<ProductModel> newProductList = [
  ProductModel(
      price: 10.0,
      imgPath: 'assets/images/product/americano.png',
      title: 'Americano',
      subTitle: 'lorem isump',
      star: 4.5),
  ProductModel(
      price: 11.0,
      imgPath: 'assets/images/product/bac_siu.png',
      title: 'Milk Coffee',
      subTitle: 'lorem isump',
      star: 3.5),
  ProductModel(
      price: 12.0,
      imgPath: 'assets/images/product/cappuccino.png',
      title: 'Cappuccino',
      subTitle: 'lorem isump',
      star: 5.0),
  ProductModel(
      price: 13.0,
      imgPath: 'assets/images/product/caramel_macchiato.png',
      title: 'Caramel Macchiato',
      subTitle: 'lorem isump',
      star: 3.5),
  ProductModel(
      price: 15.0,
      imgPath: 'assets/images/product/cf_da.png',
      title: 'Ice Coffee',
      subTitle: 'lorem isump',
      star: 4.5),
];
List<ProductModel> saleProductList = [
  ProductModel(
      price: 10.0,
      imgPath: 'assets/images/product/americano.png',
      title: 'Americano',
      subTitle: 'lorem isump',
      discount: 10,
      star: 4.5),
  ProductModel(
      price: 11.0,
      imgPath: 'assets/images/product/bac_siu.png',
      title: 'Milk Coffee',
      subTitle: 'lorem isump',
      star: 3.5,
      discount: 20),
  ProductModel(
      price: 12.0,
      imgPath: 'assets/images/product/cappuccino.png',
      title: 'Cappuccino',
      subTitle: 'lorem isump',
      star: 5.0,
      discount: 15),
  ProductModel(
      price: 13.0,
      imgPath: 'assets/images/product/caramel_macchiato.png',
      title: 'Caramel Macchiato',
      subTitle: 'lorem isump',
      star: 3.5,
      discount: 10),
  ProductModel(
      price: 15.0,
      imgPath: 'assets/images/product/cf_da.png',
      title: 'Ice Coffee',
      subTitle: 'lorem isump',
      star: 4.5,
      discount: 30),
];

List<ProductModel> foodProductList = [
  ProductModel(
      price: 10.0,
      imgPath: 'assets/images/product/banh_mi_que.png',
      title: 'Stick Bread',
      subTitle: 'lorem isump',
      discount: 10,
      star: 4.5),
  ProductModel(
      price: 11.0,
      imgPath: 'assets/images/product/cam_vang_say_deo.png',
      title: 'Dried Lemon',
      subTitle: 'lorem isump',
      star: 3.5,
      discount: 20),
  ProductModel(
      price: 12.0,
      imgPath: 'assets/images/product/chanhday.png',
      title: 'Passion fruit',
      subTitle: 'lorem isump',
      star: 5.0,
      discount: 15),
  ProductModel(
      price: 13.0,
      imgPath: 'assets/images/product/ga_xe_la_chanh.png',
      title: 'Chicken Floss',
      subTitle: 'lorem isump',
      star: 3.5,
      discount: 10),
  ProductModel(
      price: 15.0,
      imgPath: 'assets/images/product/gau.png',
      title: 'Bear Cake',
      subTitle: 'lorem isump',
      star: 4.5,
      discount: 30),
  ProductModel(
      price: 15.0,
      imgPath: 'assets/images/product/hat-dieu-mat-ong.png',
      title: 'Honey cashew',
      subTitle: 'lorem isump',
      star: 4.5,
      discount: 30),
  ProductModel(
      price: 15.0,
      imgPath: 'assets/images/product/heo_xay_xong_khoi.png',
      title: 'Dried smoked pork',
      subTitle: 'lorem isump',
      star: 4.5,
      discount: 30),
];
