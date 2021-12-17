
part of screens;

class ProfileAvatar extends StatefulWidget {
  final Function onChanged;

  ProfileAvatar({this.onChanged});

  @override
  _ProfileAvatarState createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  bool _isLoading = false;
  File _imageFile;
  final _imgPicker = ImagePicker();

  Future getImage() async {
    setState(() {
      _isLoading = true;
    });
    final pickedFile = await _imgPicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null && pickedFile.path != '') {
      setState(() {
        _imageFile = File(pickedFile.path);
        widget.onChanged(imageToBase64String(_imageFile.path));
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          getImage();
        },
        child: Stack(
          children: [
            Consumer<AuthProvider>(builder: (context, provider, child) {
              return Container(
                  width: 130.0,
                  height: 130.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 4, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: Offset(0, 10))
                      ],
                      image: DecorationImage(
                          image: _imageFile == null
                              ? provider.getUser.image == null
                                  ? AssetImage(Res.img_default_user)
                                  : base64StringToImage(provider.getUser.image)
                              : _isLoading == true
                                  ? AssetImage(Res.img_default_user)
                                  : FileImage(_imageFile),
                          fit: BoxFit.cover,
                          alignment: Alignment.center)),
                  child: _isLoading
                      ? SizedBox(
                          width: 30.0,
                          height: 30.0,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation(AppColors.primaryColor),
                          ))
                      : null);
            }),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor,
                    border: Border.all(color: Colors.white, width: 4.0)),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
