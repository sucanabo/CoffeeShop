part of screens;

class NotificationItem extends StatelessWidget {
  final String title;
  final String body;
  final VoidCallback onTap;
  NotificationItem({this.title, this.body, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
          color: AppColors.blackColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10.0)),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Center(
        child: ListTile(
          onTap: onTap,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image(
              image: AssetImage(Res.logo),
            ),
          ),
          title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: Text(body, maxLines: 2, overflow: TextOverflow.ellipsis),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          trailing: Icon(Icons.chevron_right_rounded),
          dense: true,
        ),
      ),
    );
  }
}
