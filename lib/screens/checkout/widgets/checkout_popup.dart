part of screens;
class CheckOutPopUp {
  static addressNull(BuildContext context, Function changeAddress) {
    showDialog(
        context: context,
        builder: (popupContext) => PopUpNotify(
              title: LocaleKeys.opps.tr(),
              content: Text(LocaleKeys.not_address_yet.tr()),
              actions: [
                PillButton(
                  child: Text(LocaleKeys.add.tr()),
                  onPressed: () async {
                    Navigator.of(popupContext).pop();
                    final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                AddressDetail(isEdit: false)));
                    changeAddress(result);
                  },
                )
              ],
            ));
  }
}
