import 'dart:io';
import 'package:coffee_shop/models/api_response.dart';
import 'package:coffee_shop/models/user.dart';
import 'package:coffee_shop/providers/auth_provider.dart';
import 'package:coffee_shop/services/user_service.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/function.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileAvatar extends StatefulWidget {
  final String userImg;
  final Function onImageChange;
  ProfileAvatar({this.userImg, this.onImageChange});

  @override
  _ProfileAvatarState createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  bool _isLoading = false;
  File _imageFile;
  final _imgPicker = ImagePicker();

  Future getImage() async {
    final pickedFile = await _imgPicker.getImage(source: ImageSource.gallery);
    setState(() {
      _isLoading = true;
    });
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      ApiResponse response =
          await updateUser(image: imageToBase64String(_imageFile));
      if (response.error == null) {
        Provider.of<AuthProvider>(context, listen: false)
            .updateUser(UserModel(image: imageToBase64String(_imageFile)));
        showMess(context: context, text: 'Avatar updated');
      } else {
        showMess(context: context, text: response.error);
      }
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
            Container(
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
                            ? widget.userImg == 'default_user.png'
                                ? AssetImage('assets/images/${widget.userImg}')
                                : base64StringToImage(widget.userImg)
                            : _isLoading == true
                                ? AssetImage('assets/images/default_user.png')
                                : FileImage(_imageFile),
                        fit: BoxFit.cover,
                        alignment: Alignment.center)),
                child: _isLoading
                    ? SizedBox(
                        width: 30.0,
                        height: 30.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(primaryColor),
                        ))
                    : null),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor,
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
