// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:polite/Screens/wiget.dart';

// //ส่วนแก้ไข
// class Editeatsreeen extends StatefulWidget {
//   const Editeatsreeen({super.key});

//   @override
//   State<Editeatsreeen> createState() => _EditeatsreeenState();
// }

// class _EditeatsreeenState extends State<Editeatsreeen> {
//   final formKey = GlobalKey<FormState>();
//   late TextEditingController title1;
//   late TextEditingController title2;
//   @override
//   void initState() {
//     super.initState();
//     title1 = TextEditingController(text: widget.document['title1']);
//     title2 = TextEditingController(text: widget.document['title2']);
//   }

//   @override
//   void dispose() {
//     title1.dispose();
//     title2.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.brown[300],
//         elevation: 0,
//         title: Text(
//           'แก้ไข',
//           style: TextStyle(color: Colors.white, fontSize: 23),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Form(
//             key: formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 textbox(title1, "text", "labal", "hint"),
//                 textbox(title2, "text", "labal", "hint")
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// class FirestoreImageDisplay extends StatefulWidget {
//   const FirestoreImageDisplay({super.key});

//   @override
//   State<FirestoreImageDisplay> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<FirestoreImageDisplay> {
//   late String imageUrl;
//   late String imageUrl1;
//   final storage = FirebaseStorage.instance;
//   @override
//   void initState() {
//     super.initState();
//     // Set the initial value of imageUrl to an empty string
//     imageUrl = '';
//     imageUrl1 = '';
//     //Retrieve the imge grom Firebase Storage
//     getImageUrl();
//   }

//   Future<void> getImageUrl() async {
//     // Get the reference to the image file in Firebase Storage
//     final ref = storage.ref().child('banner.jpg');
//     final ref1 = storage.ref().child('java.jpg');
//     // Get teh imageUrl to download URL
//     final url = await ref.getDownloadURL();
//     final url1 = await ref1.getDownloadURL();
//     setState(() {
//       imageUrl = url;
//       imageUrl1 = url1;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Display image from fiebase "),
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//               height: 300,
//               child: Image(
//                 image: NetworkImage(imageUrl),
//                 fit: BoxFit.cover,
//               )),
//           Card(
//             child: SizedBox(
//                 height: 300,
//                 child: Image(
//                   image: NetworkImage(imageUrl1),
//                   fit: BoxFit.cover,
//                 )),
//           )
//         ],
//       ),
//     );
//   }
// }

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class ImageSliderFirebase extends StatefulWidget {
//   const ImageSliderFirebase({super.key});

//   @override
//   State<ImageSliderFirebase> createState() => _ImageSliderFirebaseState();
// }

// class _ImageSliderFirebaseState extends State<ImageSliderFirebase> {
//   late Stream<QuerySnapshot> imageStream;
//   int currentSlideIndex = 0;
//   CarouselController carouselController = CarouselController();
//   @override
//   void initState() {
//     super.initState();
//     var firebase = FirebaseFirestore.instance;
//     imageStream = firebase.collection("Image_Slider").snapshots();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.amberAccent,
//       body: Column(
//         children: [
//           SizedBox(
//             height: 300,
//             width: double.infinity,
//             child: StreamBuilder<QuerySnapshot>(
//               stream: imageStream,
//               builder: (_, snapshot) {
//                 if (snapshot.hasData && snapshot.data!.docs.length > 1) {
//                   return CarouselSlider.builder(
//                       carouselController: carouselController,
//                       itemCount: snapshot.data!.docs.length,
//                       itemBuilder: (_, index, ___) {
//                         DocumentSnapshot sliderImage =
//                             snapshot.data!.docs[index];
//                         return Image.network(
//                           sliderImage['img'],
//                           fit: BoxFit.contain,
//                         );
//                       },
//                       options: CarouselOptions(
//                         autoPlay: true,
//                         enlargeCenterPage: true,
//                         onPageChanged: (index, _) {
//                           setState(() {
//                             currentSlideIndex = index;
//                           });
//                         },
//                       ));
//                 } else {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//               },
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Text(
//             ' Current Slide Index $currentSlideIndex',
//             style: const TextStyle(fontSize: 20),
//           )
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// pickImage(ImageSource source) async {
//   final ImagePicker _imagePicker = ImagePicker();
//   XFile? _file = await _imagePicker.pickImage(source: source);
//   if(_file != null){
//     return await _file.readAsBytes();
//   }
//   print("ไม่มีรูป");
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:polite/Screens/wiget.dart';

// //ส่วนแก้ไข
// class Editeatsreeen extends StatefulWidget {
//   const Editeatsreeen({super.key});

//   @override
//   State<Editeatsreeen> createState() => _EditeatsreeenState();
// }

// class _EditeatsreeenState extends State<Editeatsreeen> {
//   final formKey = GlobalKey<FormState>();
//   late TextEditingController title1;
//   late TextEditingController title2;
//   @override
//   void initState() {
//     super.initState();
//     title1 = TextEditingController(text: widget.document['title1']);
//     title2 = TextEditingController(text: widget.document['title2']);
//   }

//   @override
//   void dispose() {
//     title1.dispose();
//     title2.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.brown[300],
//         elevation: 0,
//         title: Text(
//           'แก้ไข',
//           style: TextStyle(color: Colors.white, fontSize: 23),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Form(
//             key: formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 textbox(title1, "text", "labal", "hint"),
//                 textbox(title2, "text", "labal", "hint")
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// class FirestoreImageDisplay extends StatefulWidget {
//   const FirestoreImageDisplay({super.key});

//   @override
//   State<FirestoreImageDisplay> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<FirestoreImageDisplay> {
//   late String imageUrl;
//   late String imageUrl1;
//   final storage = FirebaseStorage.instance;
//   @override
//   void initState() {
//     super.initState();
//     // Set the initial value of imageUrl to an empty string
//     imageUrl = '';
//     imageUrl1 = '';
//     //Retrieve the imge grom Firebase Storage
//     getImageUrl();
//   }

//   Future<void> getImageUrl() async {
//     // Get the reference to the image file in Firebase Storage
//     final ref = storage.ref().child('banner.jpg');
//     final ref1 = storage.ref().child('java.jpg');
//     // Get teh imageUrl to download URL
//     final url = await ref.getDownloadURL();
//     final url1 = await ref1.getDownloadURL();
//     setState(() {
//       imageUrl = url;
//       imageUrl1 = url1;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Display image from fiebase "),
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//               height: 300,
//               child: Image(
//                 image: NetworkImage(imageUrl),
//                 fit: BoxFit.cover,
//               )),
//           Card(
//             child: SizedBox(
//                 height: 300,
//                 child: Image(
//                   image: NetworkImage(imageUrl1),
//                   fit: BoxFit.cover,
//                 )),
//           )
//         ],
//       ),
//     );
//   }
// }

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class ImageSliderFirebase extends StatefulWidget {
//   const ImageSliderFirebase({super.key});

//   @override
//   State<ImageSliderFirebase> createState() => _ImageSliderFirebaseState();
// }

// class _ImageSliderFirebaseState extends State<ImageSliderFirebase> {
//   late Stream<QuerySnapshot> imageStream;
//   int currentSlideIndex = 0;
//   CarouselController carouselController = CarouselController();
//   @override
//   void initState() {
//     super.initState();
//     var firebase = FirebaseFirestore.instance;
//     imageStream = firebase.collection("Image_Slider").snapshots();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.amberAccent,
//       body: Column(
//         children: [
//           SizedBox(
//             height: 300,
//             width: double.infinity,
//             child: StreamBuilder<QuerySnapshot>(
//               stream: imageStream,
//               builder: (_, snapshot) {
//                 if (snapshot.hasData && snapshot.data!.docs.length > 1) {
//                   return CarouselSlider.builder(
//                       carouselController: carouselController,
//                       itemCount: snapshot.data!.docs.length,
//                       itemBuilder: (_, index, ___) {
//                         DocumentSnapshot sliderImage =
//                             snapshot.data!.docs[index];
//                         return Image.network(
//                           sliderImage['img'],
//                           fit: BoxFit.contain,
//                         );
//                       },
//                       options: CarouselOptions(
//                         autoPlay: true,
//                         enlargeCenterPage: true,
//                         onPageChanged: (index, _) {
//                           setState(() {
//                             currentSlideIndex = index;
//                           });
//                         },
//                       ));
//                 } else {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//               },
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Text(
//             ' Current Slide Index $currentSlideIndex',
//             style: const TextStyle(fontSize: 20),
//           )
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// pickImage(ImageSource source) async {
//   final ImagePicker _imagePicker = ImagePicker();
//   XFile? _file = await _imagePicker.pickImage(source: source);
//   if(_file != null){
//     return await _file.readAsBytes();
//   }
//   print("ไม่มีรูป");
// }

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImage extends StatefulWidget {
  final DocumentReference documentReference;

  const AddImage({Key? key, required this.documentReference}) : super(key: key);

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  CollectionReference images = FirebaseFirestore.instance.collection('in');

  late CollectionReference imageRef;
  late firebase_storage.Reference ref;
  bool uploading = false;
  double val = 0;

  List<File> image = [];
  ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Image'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                uploading = true;
              });
              uploadFile().whenComplete(() => Navigator.of(context).pop());
            },
            child: const Text(
              'upload',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          GridView.builder(
              itemCount: image.length + 1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                return index == 0
                    ? Center(
                        child: IconButton(
                            onPressed: () => !uploading ? chooseImage() : null,
                            icon: const Icon(Icons.add)),
                      )
                    : Container(
                        margin: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(image[index - 1]),
                                fit: BoxFit.cover)),
                      );
              }),
          uploading
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('uploading....'),
                      const SizedBox(
                        height: 10,
                      ),
                      CircularProgressIndicator(
                        value: val,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.green),
                      )
                    ],
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  Future<void> chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image.add(File(pickedFile.path));
      });
    }
    if (pickedFile?.path == null) {
      // ignore: avoid_print
      print('null');
    }
  }

  Future<void> uploadFile() async {
    int i = 1;
    for (var img in image) {
      setState(() {
        val = i / image.length;
      });
      String fileName = img.path.split('/').last;
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/$fileName');
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          // Add the download URL to the 'image' collection of the specified documentReference
          widget.documentReference.collection('image').add({'url': value});
          i++;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    imageRef = widget.documentReference.collection('image');
  }
}
