part of widgets;

class RewardWidget extends StatelessWidget {
  final bool isLarge;
  final RewardModel reward;
  const RewardWidget({@required this.reward, this.isLarge = false});

  Future showSheet(BuildContext context, size) {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => openBottomSheet(
            onPressed: () => _redeemRewardPressed(context),
            rewardPoint: reward.point,
            context: context,
            child: RewardDetail(reward: reward)));
  }

  _redeemRewardPressed(BuildContext context) async {
    setLoading(context, loading: true);
    final userProvider = Provider.of<AuthProvider>(context, listen: false);
    final voucherProvider =
        Provider.of<VoucherProvider>(context, listen: false);

    if (userProvider.getUser.point < reward.point) {
      showDialog(
          context: context,
          builder: (context) => PopUpNotify(
                title: LocaleKeys.opps.tr().toUpperCase() + '!!!',
                content: Text(LocaleKeys.dont_have_enough_point.tr()),
                actions: [
                  RoundedButton(
                    title: LocaleKeys.ok.tr(),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ));
      return;
    }
    final bool result = await voucherProvider.redeemReward(reward.id);
    if (result) {
      ApiResponse response = await getUserInformation();
      if (response.error == null) {
        userProvider.setUser(response.data);
        showDialog(
            context: context,
            builder: (context) => PopUpNotify(
                  title: LocaleKeys.success.tr().toUpperCase() + '!!!',
                  content: Text(LocaleKeys.reward_move_to_voucher.tr()),
                  actions: [
                    RoundedButton(
                      title: LocaleKeys.ok.tr(),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ));
      }
    }

    setLoading(context, loading: false);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    if (isLarge) {
      return Container(
        width: 200.0,
        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
        child: InkWell(
          onTap: () {
            showSheet(context, size);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 5.0,
                    offset: Offset(3, 3),
                    spreadRadius: 1.0)
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                        tag: reward.title,
                        child: reward.image != null
                            ? Image(
                                image: base64StringToImage(reward.image),
                                fit: BoxFit.cover,
                                height: 180.0,
                              )
                            : Image.network('https://via.placeholder.com/200')),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                                flex: 7,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        reward.brandName,
                                        style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height: 5.0),
                                      Text(
                                        reward.title,
                                        style: TextStyle(fontSize: 11.0),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ])),
                            Expanded(
                              flex: 3,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                height: 35.0,
                                width: 35.0,
                                decoration: BoxDecoration(
                                    color: userProvider.getUser.point >=
                                            reward.point
                                        ? AppColors.darkColor
                                        : AppColors.mutedColor,
                                    shape: BoxShape.circle),
                                child: Center(
                                    child: Text(
                                  '${reward.point}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13.0),
                                )),
                              ),
                            )
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
        child: InkWell(
          onTap: () => showSheet(context, size),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 2.0,
                      offset: Offset(3, 3),
                      spreadRadius: 2.0)
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                      tag: reward.title,
                      child: Image(
                        image: base64StringToImage(reward.image),
                        fit: BoxFit.cover,
                      )),
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            reward.brandName,
                            style: TextStyle(
                                fontSize: 16.0, color: AppColors.primaryColor),
                          ),
                          Text(
                            reward.title,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: Container(
                        height: 35.0,
                        width: 35.0,
                        decoration: BoxDecoration(
                            color: userProvider.getUser.point >= reward.point
                                ? AppColors.darkColor
                                : AppColors.mutedColor,
                            shape: BoxShape.circle),
                        child: Center(
                          child: Text(
                            '${reward.point}',
                            style:
                                TextStyle(fontSize: 13.0, color: Colors.white),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
