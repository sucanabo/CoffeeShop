part of screens;

class ProductDetailBody extends StatefulWidget {
  final ProductModel product;
  final bool cartEdit;
  final CartItemModel cartItem;
  const ProductDetailBody({@required this.product, this.cartEdit, this.cartItem});

  @override
  _ProductDetailBodyState createState() => _ProductDetailBodyState();
}

class _ProductDetailBodyState extends State<ProductDetailBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map _productExtend;
  ProductModel _product;
  TextEditingController _txtMessage = new TextEditingController();
  double _totalPrice;
  int _quantity;
  //Topping is not requied. It can be null
  void chooseTopping(Map item) {
    List toppingList = _productExtend['toppings'];
    //Check is exist in list
    if (toppingList.contains(item)) {
      toppingList.remove(item);
    } else {
      toppingList.add(item);
    }
  }

  //Custom can change option instead default value
  void changeOption(String key, Map item) {
    Map optionList = _productExtend['options'];
    optionList[key] = item;
  }

  //total price in bottom bar
  double caculateTotalPrice() {
    double total = 0.0;
    //price of product (including discount)
    double productPrice =
        caculatePrice(price: _product.price, discount: _product.discount);
    //caculate product option and topping price
    double productExtendPrice = 0.0;
    _productExtend.forEach((key, value) {
      if (value.isNotEmpty && value != null) {
        if (value is Map) {
          value.forEach((optionKey, optionValue) {
            productExtendPrice += double.parse(optionValue['price']);
          });
        } else if (value is List) {
          value.forEach((toppingValue) {
            productExtendPrice += toppingValue['price'];
          });
        }
      }
    });
    //subtotal
    total += (productPrice + productExtendPrice) * _quantity;
    setState(() {
      _totalPrice = total;
    });
    return total;
  }

  void addToCart() {
    Provider.of<CartProvider>(context, listen: false).addItem(_product,
        quickAdd: false,
        message: _txtMessage.text,
        quantity: _quantity,
        price: _totalPrice,
        productExtend: _productExtend);
  }

  void editCart() {
    CartItemModel instance = CartItemModel(
        key: widget.cartItem.key,
        product: widget.product,
        quantity: _quantity,
        price: _totalPrice,
        productExtend: _productExtend);
    Provider.of<CartProvider>(context, listen: false).editItem(instance);
    showMess(context: context, text: 'Edit item success.');
  }

  @override
  void initState() {
    super.initState();
    _product = widget.product;
    if (widget.cartEdit != true) {
      _productExtend = {
        'options': _product.options.isNotEmpty
            ? Provider.of<CartProvider>(context, listen: false)
                .setOptionDefault(_product)
            : {},
        'toppings': [],
      };
      _quantity = 1;
      _totalPrice = caculateTotalPrice();
    } else {
      _productExtend = widget.cartItem.productExtend;
      _quantity = widget.cartItem.quantity;
      _totalPrice = widget.cartItem.price;
      _txtMessage.text = widget.cartItem.message;
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> options =
        _product.options.isNotEmpty ? _product.options : {};
    List<dynamic> toppings = _product.toppings;
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: size.height * .5,
          width: size.width,
          child: Hero(
            tag: widget.product.title,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4), BlendMode.srcATop),
              child: Image(
                gaplessPlayback: true,
                image: base64StringToImage(widget.product.imgPath),
                fit: BoxFit.fill,
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 175.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 40.0, bottom: 50.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ListView(
                            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 30.0),
                            children: [
                              Text(
                                widget.product.title,
                                style: TextStyle(
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.w700),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    LocaleKeys.price.tr(),
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.grey[500]),
                                  ),
                                  SizedBox(width: 5.0),
                                  widget.product.discount != 0 &&
                                          widget.product.discount != null
                                      ? Text(
                                          convertVND(widget.product.price),
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: AppColors.mutedColor,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        )
                                      : Text(
                                          convertVND(caculatePrice(
                                              price: widget.product.price,
                                              discount:
                                                  widget.product.discount)),
                                          style: TextStyle(
                                              color: AppColors.primaryColor,
                                              fontSize: 26.0,
                                              fontWeight: FontWeight.w500)),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                    width: 20.0,
                                    child: Icon(
                                      LineIcons.star,
                                      size: 18.0,
                                      color: Colors.yellow[700],
                                    ),
                                  ),
                                  SizedBox(width: 2.0),
                                  Text(widget.product.star.toString())
                                ],
                              ),
                              if (_product.discount != 0)
                                Text(
                                    convertVND(caculatePrice(
                                        price: widget.product.price,
                                        discount: widget.product.discount)),
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 26.0,
                                        fontWeight: FontWeight.w500)),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: Text(
                                  widget.product.content ?? '',
                                  style: TextStyle(fontSize: 15.0),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 6,
                                            child: Heading(
                                                title:
                                                    LocaleKeys.quantity.tr()),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Quantity(
                                              initValue: _quantity,
                                              onChange: (value) {
                                                _quantity = value;
                                                caculateTotalPrice();
                                              },
                                            ),
                                          )
                                        ]),
                                    Heading(
                                        title: LocaleKeys.product_option.tr()),
                                    options.isNotEmpty
                                        ? Column(
                                            children: options.entries
                                                .map((e) => ProductExtend(
                                                    title: e.key
                                                        .toString()
                                                        .capitalize(),
                                                    child: ProductDropDown(
                                                      initValue: widget.cartEdit
                                                          ? widget.cartItem
                                                                  .productExtend[
                                                              'options'][e.key]
                                                          : null,
                                                      data: e.value,
                                                      handleSelect: (value) {
                                                        changeOption(
                                                            e.key, value);
                                                        caculateTotalPrice();
                                                      },
                                                    )))
                                                .toList(),
                                          )
                                        : Text(LocaleKeys.no_option.tr()),
                                    Heading(title: 'Topping'),
                                    toppings.isNotEmpty
                                        ? Column(
                                            children: toppings
                                                .map((e) => ProductExtend(
                                                      title: e['title']
                                                          .toString()
                                                          .capitalize(),
                                                      child: ProductCheckBox(
                                                        initValue: widget
                                                                .cartEdit
                                                            ? widget
                                                                .cartItem
                                                                .productExtend[
                                                                    'toppings']
                                                                .contains(e)
                                                            : false,
                                                        title: e['description'],
                                                        handleCheck: () {
                                                          chooseTopping(e);
                                                          caculateTotalPrice();
                                                        },
                                                      ),
                                                    ))
                                                .toList())
                                        : Text(LocaleKeys.no_topping.tr()),
                                    SizedBox(height: 10.0),
                                    Heading(title: LocaleKeys.note.tr()),
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey[500]
                                                    .withOpacity(0.5),
                                                offset: Offset(3, 5),
                                                spreadRadius: 2.0,
                                                blurRadius: 5.0)
                                          ],
                                          color: Colors.white,
                                        ),
                                        child: MessageBox(
                                            formKey: _formKey,
                                            controller: _txtMessage)),
                                  ],
                                ),
                              )
                            ]),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
            top: 150.0,
            right: 50.0,
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              ActionButton(
                  icon: Icon(Icons.favorite),
                  isActive: widget.product.selfFavourited,
                  activeColor: Colors.red[300],
                  type: 'favourite',
                  productId: widget.product.id),
              SizedBox(
                width: 15.0,
              ),
              ActionButton(
                  icon: Icon(
                    Icons.star_rounded,
                    size: 30.0,
                  ),
                  isActive: widget.product.selfRating.star != 0,
                  activeColor: Colors.orange[300],
                  type: 'rating',
                  productId: widget.product.id),
            ])),
        BottomBar(
          price: _totalPrice,
          buttonText: widget.cartEdit
              ? LocaleKeys.edit_product.tr()
              : LocaleKeys.add_to_cart.tr(),
          buttonPress: () {
            if (_formKey.currentState.validate()) {
              widget.cartEdit ? editCart() : addToCart();
              Navigator.of(context).pop();
            }
          },
        )
      ],
    );
  }
}
