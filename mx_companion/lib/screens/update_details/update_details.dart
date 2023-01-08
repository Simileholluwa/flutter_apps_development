import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path/path.dart';
import '../../Services/Authentication/initial_screen_controller.dart';
import '../../Services/upload.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class UpdateDetailsScreen extends StatefulWidget {
  const UpdateDetailsScreen({Key? key}) : super(key: key);

  @override
  State<UpdateDetailsScreen> createState() => _UpdateDetailsScreenState();
}

class _UpdateDetailsScreenState extends State<UpdateDetailsScreen> with AutomaticKeepAliveClientMixin{

  bool _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController phoneNumberController,
      departmentController,
      userNameController;

  var userName = '';
  var phoneNumber = '';
  var department = '';

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    departmentController = TextEditingController();
  }

  @override
  void dispose() {
    userNameController.dispose();
    phoneNumberController.dispose();
    departmentController.dispose();
    super.dispose();
  }

  UploadTask? task;
  File? file;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );
    if (result != null) {
      final path = result.files.single.path!;
      setState(() {
        file = File(path);
      });
    } else {
      return;
    }
  }

  final CollectionReference userDetails = FirebaseFirestore.instance
      .collection('users')
      .doc(AuthController().getCurrentUID())
      .collection('userDetails');

  @override
  Widget build(BuildContext context) {
    super.build(context);
    void _alert(String text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,
          content: SmallText(
            text: text,
            color: Colors.white,
            align: TextAlign.center,
          ),
        ),
      );
    }

    final fileName = file != null ? 'Selected Image: ${basename(file!.path)}' : 'Your current profile image';

    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20,),
        child: const Text(
          'Your request will be denied if you have updated your details in the last 14 days.',
          style: TextStyle(
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: StreamBuilder(
        stream: userDetails.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if (streamSnapshot.hasData){
            departmentController.text = streamSnapshot.data!.docs[0]['department'];
            userNameController.text = streamSnapshot.data!.docs[0]['userName'];
            phoneNumberController.text = streamSnapshot.data!.docs[0]['phoneNumber'];
            return Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      width: double.maxFinite,
                      margin: const EdgeInsets.only(
                        right: 20,
                        left: 20,
                        top: 160,
                      ),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: CupertinoColors.darkBackgroundGray,
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20, right: 20,),
                            width: double.maxFinite,
                            child: Form(
                              key: _formKey,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 150,
                                  ),
                                  Center(child: Text(fileName)),
                                  const SizedBox(height: 30,),
                                  TextFormField(
                                    onSaved: (value) {
                                      department = value!;
                                    },
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Department field is required';
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    controller: departmentController,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Jost',
                                    ),
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.school,
                                        color: Colors.grey.shade500,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white.withAlpha(20),
                                            width: 3.0),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white.withAlpha(20),
                                            width: 3.0),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      hintText: "Enter your department",
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontFamily: "Jost",
                                        fontWeight: FontWeight.bold,
                                      ),
                                      labelText: 'Department',
                                      labelStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontFamily: "Jost",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    onSaved: (value) {
                                      phoneNumber = value!;
                                    },
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Phone number field is required';
                                      } else if (value.length != 11) {
                                        return 'Phone number must be 11 digits long';
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.phone,
                                    controller: phoneNumberController,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Jost',
                                    ),
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.phone_iphone_sharp,
                                        color: Colors.grey.shade500,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white.withAlpha(20),
                                            width: 3.0),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white.withAlpha(20),
                                            width: 3.0),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      hintText: "Enter your phone number",
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontFamily: "Jost",
                                        fontWeight: FontWeight.bold,
                                      ),
                                      labelText: 'Phone Number',
                                      labelStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontFamily: "Jost",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    onSaved: (value) {
                                      userName = value!;
                                    },
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Username field is required';
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    controller: userNameController,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Jost',
                                    ),
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.grey.shade500,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white.withAlpha(20),
                                            width: 3.0),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white.withAlpha(20),
                                            width: 3.0),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      hintText: "Enter a unique username",
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontFamily: "Jost",
                                        fontWeight: FontWeight.bold,
                                      ),
                                      labelText: 'Username',
                                      labelStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontFamily: "Jost",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      selectFile();
                                    },
                                    child: Container(
                                      height: 50,
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blue.shade800,
                                      ),
                                      child: const Center(
                                        child: SmallText(text: 'Select Image'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      setState((){
                                        _isLoading = true;
                                      });
                                      var userName =
                                          userNameController.text.trim().capitalizeFirst;
                                      var department = departmentController.text
                                          .trim()
                                          .capitalizeFirst;
                                      var phoneNumber = phoneNumberController.text.trim();
                                      final isValid = _formKey.currentState!.validate();
                                      if (!isValid) {
                                        return;
                                      } else {
                                        _formKey.currentState!.save();
                                        try {

                                          if (file != null) {
                                            final fileName = basename(file!.path);
                                            final destination = 'images/$fileName';
                                            task = FirebaseApi.uploadFile(destination, file!);
                                            if (task == null) {
                                              return;
                                            } else {
                                              try {
                                                final snapShot = await task!.whenComplete(() {});
                                                final urlDownload = await snapShot.ref.getDownloadURL();
                                                await userDetails.doc(streamSnapshot.data!.docs[0].id).update({'url' : urlDownload});
                                              } on FirebaseException catch (e) {
                                                return;
                                              } catch (e) {
                                                return;
                                              }
                                            }
                                          }

                                          await userDetails
                                              .doc(streamSnapshot.data!.docs[0].id)
                                              .update(
                                            {
                                              'userName': userName,
                                              'department': department,
                                              'phoneNumber': phoneNumber,
                                            },
                                          );
                                          await FirebaseAuth.instance.currentUser!
                                              .updateDisplayName(userName);
                                          _alert('Update successful');
                                          setState((){
                                            _isLoading = false;
                                          });
                                        } catch (e) {
                                          _alert('Update Failed. Please try again.');
                                        }
                                      }
                                      setState((){
                                        _isLoading = false;
                                      });
                                    },
                                    child: Container(
                                      height: 50,
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blue.shade800,
                                      ),
                                      child: Center(
                                        child: _isLoading ? LoadingAnimationWidget.prograssiveDots(
                                            color: Colors.white, size: 50) : const SmallText(text: 'Update Details'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 150,
                          backgroundColor: Colors.white.withAlpha(30),
                          child: ClipOval(
                            child: SizedBox(
                              height: 280,
                              width: 280,
                              child: (file != null) ? Image.file(file!, fit: BoxFit.cover,) : Image.network(
                                '${streamSnapshot.data!.docs[0]['url']}',
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child:
                                    LoadingAnimationWidget.fourRotatingDots(
                                        color: Colors.white, size: 80),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    CupertinoIcons.person_alt_circle,
                                    size: 280,
                                    color: Colors.white,
                                  );
                                },
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const BigText(
                    text: 'MX Companion', color: Colors.white, size: 40),
                const SizedBox(height: 10),
                LoadingAnimationWidget.fourRotatingDots(
                    color: Colors.white, size: 80),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
