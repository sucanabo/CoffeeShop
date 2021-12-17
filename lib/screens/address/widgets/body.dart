part of screens;

class AddressBody extends StatelessWidget {
  final bool isChooseAddress;
  const AddressBody({this.isChooseAddress});
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
        builder: (context, provider, child) => ScreenBody(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildAddNew(context),
                  Divider(
                    thickness: 1.5,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Expanded(child: _buildAddressItems(provider)),
                ],
              ),
            ));
  }

  InkWell _buildAddNew(context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddressDetail(isEdit: false)));
        },
        splashColor: AppColors.primaryColor,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            LocaleKeys.add.tr(),
            style: TextStyle(
                fontSize: 20.0,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold),
          ),
          LineIcon.plus(),
        ]));
  }

  ListView _buildAddressItems(provider) {
    return ListView.separated(
      itemCount: provider.addresses.length,
      itemBuilder: (context, index) => AddressItem(
        address: provider.addresses[index],
        isChooseAddress: isChooseAddress,
      ),
      separatorBuilder: (context, index) => Divider(
        height: 25,
        thickness: 1.5,
      ),
    );
  }
}
