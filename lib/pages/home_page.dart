import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_task/models/contacts_model.dart';
import 'package:home_task/pages/login_page.dart';
import 'package:home_task/services/language_translate.dart';
import 'package:home_task/setup.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/language_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<String> list = [];

TextEditingController nameController = TextEditingController();
TextEditingController numberController = TextEditingController();

TextEditingController nameUpdate = TextEditingController();
TextEditingController numberUpdate = TextEditingController();

class _HomePageState extends State<HomePage> {
  String? til = service.read("til");

  Future<void> dropCall(String? selectValue) async {
    if (selectValue is String) {
      setState(() {
        til = selectValue;
        service.store("til", selectValue);
      });
    }
    LanguageService.switchLanguage(til!);
  }

  File? file;
  bool isImageSelected = false;
  bool isLoading = false;
  bool isCamera = false;

  Future<void> getImage() async {
    isImageSelected = false;
    final ImagePicker picker = ImagePicker();
    XFile? xFile = await picker.pickImage(
        source: isCamera ? ImageSource.gallery : ImageSource.camera);
    if (xFile != null) {
      file = File(xFile.path);
      final directory = await getApplicationDocumentsDirectory();
      await file!.copy("${directory.path}/image.png");
      isImageSelected = true;
      setState(() {});
    }
  }

  Future<void> read() async {
    isLoading = false;
    setState(() {});
    final directory = await getApplicationDocumentsDirectory();
    await for (var event in directory.list()) {
      if (event.path.contains('image.png')) {
        isImageSelected = true;
      }
    }
    if (isImageSelected) {
      file = File("${directory.path}/image.png");
      isLoading = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: ListTile(
            leading: Text(
              "logout".tr,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: IconButton(
              onPressed: () {
                token.put("token", false);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              icon: const Icon(Icons.logout),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.grey.shade400,
        title: Text(
          "contacts".tr,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          DropdownButton(
            value: til,
            items: const [
              DropdownMenuItem(
                value: "1",
                child: Row(
                  children: [
                    Text("🇺🇿 O'zbek"),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: "2",
                child: Row(
                  children: [
                    Text(" 🇬🇧 England"),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: "3",
                child: Row(
                  children: [
                    Text(" 🇷🇺 Rus"),
                  ],
                ),
              ),
            ],
            onChanged: dropCall,
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Form(
                      child: Column(
                        children: [
                          MaterialButton(
                            onPressed: () async {
                              await getImage();
                            },
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.transparent,
                              backgroundImage: profileImage(file: file),
                            ),
                          ),
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(labelText: 'name'.tr),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            maxLength: 9,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            controller: numberController,
                            decoration: InputDecoration(labelText: 'number'.tr),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("cancel".tr),
                      ),
                      TextButton(
                        onPressed: () {
                          if (nameController.text.isNotEmpty &&
                              numberController.text.isNotEmpty) {
                            setState(
                              () {
                                ContactsModel contactsModel = ContactsModel(
                                    name: nameController.text,
                                    number: numberController.text);
                                box2.add(contactsModel);
                                nameController.clear();
                                numberController.clear();
                              },
                            );
                            list.clear();
                            Navigator.pop(context);
                          }
                        },
                        child: Text('done'.tr),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: box2.values.toList().length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.grey.shade200,
            elevation: 0,
            child: ListTile(
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("delete Contact".tr),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("cancel".tr),
                        ),
                        TextButton(
                          onPressed: () {
                            box2.deleteAt(index);
                            setState(() {});
                            Navigator.pop(context);
                          },
                          child: Text("delete".tr),
                        ),
                      ],
                    );
                  },
                );
              },
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey,
                backgroundImage: profileImage(file: file),
                // child: const Icon(
                //   Icons.person,
                //   size: 55,
                //   color: Colors.white,
                // ),
              ),
              title: Text(
                box2.values.toList()[index].name,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              subtitle: Text(
                box2.values.toList()[index].number,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () async {
                      // await getImage();
                      // setState(() {});
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Form(
                              child: Column(
                                children: [
                                  MaterialButton(
                                    onPressed: () async {
                                      await getImage();
                                    },
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: profileImage(file: file),
                                    ),
                                  ),
                                  TextFormField(
                                    controller: nameUpdate,
                                    decoration:
                                        InputDecoration(labelText: 'name'.tr),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    maxLength: 9,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    controller: numberUpdate,
                                    decoration:
                                        InputDecoration(labelText: 'number'.tr),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("cancel".tr),
                              ),
                              TextButton(
                                onPressed: () {
                                  if (nameUpdate.text.isNotEmpty &&
                                      numberUpdate.text.isNotEmpty) {
                                    setState(
                                      () {
                                        ContactsModel contactsModel =
                                            ContactsModel(
                                                name: nameUpdate.text,
                                                number: numberUpdate.text);
                                        box2.putAt(
                                          index,
                                          ContactsModel(
                                              name: nameUpdate.text,
                                              number: numberUpdate.text),
                                        );
                                        // box2.add(contactsModel);
                                        // nameController.clear();
                                        // numberController.clear();
                                        nameUpdate.clear();
                                        numberUpdate.clear();
                                      },
                                    );
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text('done'.tr),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () async {
                      final call = Uri.parse(
                          'tel: ${box2.values.toList()[index].number}');
                      if (await canLaunchUrl(call)) {
                        launchUrl(call);
                      } else {
                        throw 'Could not launch $call';
                      }
                    },
                    icon: const Icon(
                      Icons.call,
                      color: Color(0xff08AE2D),
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

ImageProvider<Object>? profileImage({File? file, int index = 0}) {
  if (file != null) {
    if (index >= 0 && index < list.length) {
      list[index] = Image.file(file).image.toString();
    } else {
      list.add(Image.file(file).image.toString());
      index = list.length - 1;
    }
    return Image.file(file).image;
  } else {
    return const AssetImage("assets/images/person-4.png");
  }
}

// ImageProvider<Object>? profileImage({File? file}) {
//   return file != null
//       ? Image.file(file).image
//       : const AssetImage("assets/images/img.png");
// }
