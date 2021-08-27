class NotificationModel {
  final String imgPath;
  final String title;
  final String subTitle;
  final String date;
  final String content;

  NotificationModel(
      {this.imgPath, this.title, this.content, this.date, this.subTitle});
}

List<NotificationModel> notifications = [
  NotificationModel(
      imgPath: 'assets/images/logo.jpg',
      title: 'Hello new friend !!',
      date: '19/6/2021',
      subTitle: 'Big disscount for you :)',
      content:
          'Lorem imLorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas eget nisi iaculis, cursus sem et, mollis nulla. Nulla maximus condimentum enim, non lacinia ex semper at. Nam et aliquet velit. Vivamus felis ex, hendrerit quis odio a, ultricies pretium arcu. Suspendisse quis enim ac urna euismod sagittis.'),
  NotificationModel(
      imgPath: 'assets/images/logo.jpg',
      title: 'Discount of month !!',
      date: '20/6/2021',
      subTitle: 'Discount 10% for milk tea. Receive now',
      content:
          'Lorem imLorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas eget nisi iaculis, cursus sem et, mollis nulla. Nulla maximus condimentum enim, non lacinia ex semper at. Nam et aliquet velit. Vivamus felis ex, hendrerit quis odio a, ultricies pretium arcu. Suspendisse quis enim ac urna euismod sagittis.'),
  NotificationModel(
      imgPath: 'assets/images/logo.jpg',
      title: 'Hurry up. Free Delivery Voucher is Comming',
      date: '13/6/2021',
      subTitle: 'Free deliver voucher for 100 the people fastest',
      content:
          'Lorem imLorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas eget nisi iaculis, cursus sem et, mollis nulla. Nulla maximus condimentum enim, non lacinia ex semper at. Nam et aliquet velit. Vivamus felis ex, hendrerit quis odio a, ultricies pretium arcu. Suspendisse quis enim ac urna euismod sagittis.'),
];
