import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:workampus/models/user.dart';
import 'package:workampus/screens/profile/profile_view.dart';
import 'package:workampus/screens/profile/profile_viewmodel.dart';
import 'package:workampus/shared/appBar.dart';
import 'package:workampus/shared/textField.dart';
import 'package:workampus/shared/buttons.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:workampus/shared/colors.dart';
import 'package:workampus/shared/divider.dart';
import 'package:workampus/shared/toastAndDialog.dart';

class UpdateProfileView extends StatefulWidget {
  const UpdateProfileView({this.user});
  final User user;

  @override
  _UpdateProfileViewState createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  TextEditingController displayNameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    PickedFile selected = await ImagePicker().getImage(source: source);

    setState(() {
      _imageFile = File(selected.path);
    });
  }

  void _clear() {
    setState(() {
      _imageFile = null;
    });
  }

  Future<void> _cropImage() async {
    if (_imageFile == null) {
      awesomeToast('Tap the + button to upload an image!');
    } else {
      File cropped = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        maxWidth: 1080,
        maxHeight: 1080,
      );
      setState(() {
        _imageFile = cropped ?? _imageFile;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    displayNameController =
        TextEditingController(text: widget.user.displayName);
    descController = TextEditingController(text: widget.user.desc);
    locationController = TextEditingController(text: widget.user.address);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ViewModelBuilder<ProfileViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: bgColor,
        appBar: buildSectionBar(context, 'Update Profile'),
        body: Stack(
          children: [
            Container(
              height: screenHeight,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: _imageFile != null ? 14 : 30),
                      InkWell(
                        onTap: () {
                          awesomeDoubleButtonDialog(
                              context,
                              'Snap it or Pick it?',
                              'A decent profile picture works best',
                              'Camera',
                              () {
                                _pickImage(ImageSource.camera);
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              },
                              'Gallery',
                              () {
                                _pickImage(ImageSource.gallery);
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              });
                        },
                        child: ClipOval(
                          child: Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.width / 3,
                              color: Colors.grey,
                              child: _imageFile == null &&
                                      widget.user.photoUrl == ''
                                  ? Icon(FontAwesomeIcons.plus,
                                      size: 50, color: Colors.white)
                                  : _imageFile != null &&
                                          widget.user.photoUrl == ''
                                      ? Image.file(
                                          _imageFile,
                                          fit: BoxFit.cover,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: widget.user.photoUrl,
                                          fit: BoxFit.fill,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        )),
                        ),
                      ),
                      _imageFile != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FlatButton(
                                  child: Text(
                                    'Crop Image',
                                    style: TextStyle(
                                        color: accentColor,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  onPressed: _cropImage,
                                ),
                                IconButton(
                                    icon: Icon(Icons.cancel_outlined),
                                    onPressed: _clear)
                              ],
                            )
                          : SizedBox(height: 31),
                      awesomeDivider(0.8, dividerColor),
                      Container(
                        padding: EdgeInsets.only(
                            top: 15, bottom: 20, left: 15, right: 15),
                        color: bgColor,
                        width: screenWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'How people call you:',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
                            SizedBox(height: 5),
                            awesomeTextField(
                              displayNameController,
                              'Tap to enter display name...',
                              1,
                              10,
                              screenWidth,
                              TextInputType.multiline,
                              'Nickname',
                            ),
                          ],
                        ),
                      ),
                      awesomeDivider(0.8, dividerColor),
                      Container(
                        padding: EdgeInsets.only(
                            top: 15, bottom: 15, left: 15, right: 15),
                        color: bgColor,
                        width: screenWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Where are you located:',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
                            SizedBox(height: 5),
                            awesomeTextField(
                              locationController,
                              'Tap to enter location...',
                              1,
                              9,
                              screenWidth,
                              TextInputType.multiline,
                              'locatiion',
                            ),
                          ],
                        ),
                      ),
                      awesomeDivider(0.8, dividerColor),
                      Container(
                        padding: EdgeInsets.only(
                            top: 15, bottom: 0, left: 15, right: 15),
                        color: bgColor,
                        width: screenWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your profile description:',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
                            SizedBox(height: 5),
                            awesomeTextFieldNoError(
                              descController,
                              'Tap to enter profile description...\n\n\npro tip: User with good profile description has higher chances of getting hired!',
                              6,
                              10,
                              screenWidth,
                              TextInputType.multiline,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: transparentButton("Update", () async {
                          print(displayNameController.text);
                          print(descController.text);
                          print(locationController.text);
                          if (_formKey.currentState.validate()) {
                            if (_imageFile == null &&
                                model.currentUser.photoUrl == '') {
                              awesomeDialog(context, 'Image is empty',
                                  'You have not upload your profile picture. Would you like to proceed without it?',
                                  () async {
                                model.updateProfile(
                                  displayName: displayNameController.text,
                                  desc: descController.text,
                                  location: locationController.text,
                                );
                                await Future.delayed(Duration(seconds: 1));
                                awesomeToast('Information Updated!');
                                Navigator.of(context, rootNavigator: false)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (context) => ProfileView()));
                              });
                            } else if (model.currentUser.photoUrl != '') {
                              model.updateProfile(
                                  displayName: displayNameController.text,
                                  desc: descController.text,
                                  location: locationController.text);
                              await Future.delayed(Duration(seconds: 1));
                              awesomeToast('Information Updated!');
                              Navigator.of(context, rootNavigator: false)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (context) => ProfileView()));
                            } else {
                              model.updateProfile(
                                displayName: displayNameController.text,
                                desc: descController.text,
                                location: locationController.text,
                                imageFile: _imageFile,
                              );
                              await Future.delayed(Duration(seconds: 1));
                              awesomeToast('Information Updated!');
                              Navigator.of(context, rootNavigator: false)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (context) => ProfileView()));
                            }
                          }
                        }, Color.fromRGBO(57, 57, 57, 25),
                            Color.fromRGBO(57, 57, 57, 25), screenWidth - 30,
                            textColor: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
