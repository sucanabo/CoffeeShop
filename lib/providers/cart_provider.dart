part of providers;

class CartProvider with ChangeNotifier {
  Map<String, CartItemModel> _items = {};

  //get items in cart
  Map<String, CartItemModel> get items {
    return {..._items};
  }

  //get amount of item
  int get itemCount {
    return _items.length;
  }

  //get total amount
  double get totalAmount {
    return _items.values
        .fold(0.0, (previousValue, element) => previousValue + element.price);
  }

  CartItemModel findCartItemByKey({@required String key}) {
    return _items.containsKey(key) ? _items[key] : null;
  }

  void editItem(CartItemModel cartItem) {
    if (_items.containsKey(cartItem.key)) {
      //check is productExtend existed in cart
      String existingItemKey = _items.keys.firstWhere(
          (element) =>
              _items[element].productExtend == cartItem.productExtend &&
              _items[element].product.id == cartItem.product.id,
          orElse: () => null);
      //if not existed => update it
      if (existingItemKey != null) {
        _items.update(
            cartItem.key,
            (cartValue) => CartItemModel(
                key: cartValue.key,
                product: cartValue.product,
                productExtend: cartItem.productExtend,
                message: cartItem.message,
                quantity: cartItem.quantity,
                price: cartItem.price));
        print(_items[cartItem.key].quantity);
      }
      //item existed => remove current item and update quantity of found item
      else {
        _items.remove(cartItem.key);
        _items.update(
          existingItemKey,
          (existingValue) => CartItemModel(
              key: existingValue.key,
              product: existingValue.product,
              quantity: existingValue.quantity + cartItem.quantity,
              price: existingValue.price + cartItem.price,
              message: cartItem.message,
              productExtend: existingValue.productExtend),
        );
        print(_items[existingItemKey].quantity);
      }
    } else {
      print('khong tim thay');
    }
    notifyListeners();
  }

  void addItem(ProductModel product,
      {String message,
      double price,
      Map productExtend,
      int quantity,
      bool quickAdd}) {
    int productId = product.id;
    String targetKey;
    targetKey = _items.keys.firstWhere(
        (element) =>
            _items[element].product.id == productId &&
            DeepCollectionEquality()
                .equals(_items[element].productExtend, productExtend),
        orElse: () => null);
    if (targetKey != null) {
      if (quickAdd == true) {
        print(_items[targetKey].price);
        _items.update(
            targetKey,
            (existingValue) => CartItemModel(
                key: targetKey,
                product: existingValue.product,
                quantity: existingValue.quantity + 1,
                price: existingValue.price +
                    caculatePrice(
                        price: existingValue.product.price,
                        discount: existingValue.product.discount),
                productExtend: existingValue.productExtend));
        print('sua nhanh: ${_items[targetKey].toString()}');
      } else {
        _items.update(
            targetKey,
            (existingValue) => CartItemModel(
                key: targetKey,
                product: existingValue.product,
                quantity: existingValue.quantity + quantity,
                price: existingValue.price + price,
                productExtend: existingValue.productExtend,
                message: message));
        print('sua chi tiet: ${_items[targetKey].price}');
      }
    } else {
      String newCartKey =
          '${product.id}_${DateTime.now().millisecondsSinceEpoch}';

      if (quickAdd == true) {
        _items.putIfAbsent(
            newCartKey,
            () => CartItemModel(
                key: newCartKey,
                product: product,
                quantity: 1,
                price: caculatePrice(
                    price: product.price, discount: product.discount),
                productExtend: productExtend));
        print(newCartKey);
        print('them nhanh: ${_items[newCartKey].productExtend}');
      } else {
        _items.putIfAbsent(
            newCartKey,
            () => CartItemModel(
                key: newCartKey,
                product: product,
                quantity: quantity,
                price: price,
                productExtend: productExtend,
                message: message));
        print('them chi tiet: ${_items[newCartKey].productExtend}');
      }
    }
    notifyListeners();
  }

  //remove item
  void removeItem(String key) {
    _items.remove(key);
    notifyListeners();
  }

  //remove single item
  void removeSingleItem(String key) {
    if (!_items.containsKey(key)) {
      return;
    }
    if (_items[key].quantity > 1) {
      _items.update(
          key,
          (existingValue) => CartItemModel(
              key: key,
              product: existingValue.product,
              quantity: existingValue.quantity - 1,
              price: existingValue.price,
              productExtend: existingValue.productExtend));
    } else {
      _items.remove(key);
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    _items = {};
    notifyListeners();
  }

  //Option is requied to order. If user click order then Option Deafault will applied.
  Map<String, dynamic> setOptionDefault(ProductModel product) {
    Map<String, dynamic> defaultOptions = {};
    Map<String, dynamic> options = product.options;

    options.forEach((key, value) {
      Map<String, dynamic> defaultValue = {};
      //search which is option default
      value.forEach((element) {
        if (element['default'] == 1) {
          defaultValue = element;
        }
      });
      //if admin not set default for option, then get first value
      if (defaultValue == null || defaultValue.isEmpty) defaultValue = value[0];

      defaultOptions[key] = defaultValue;
    });

    return defaultOptions;
  }
}
