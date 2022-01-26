import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class imgUpload extends StatefulWidget {
  const imgUpload({Key? key}) : super(key: key);

  @override
  _imgUploadState createState() => _imgUploadState();
}

class _imgUploadState extends State<imgUpload> {

  ImagePicker image = ImagePicker();
  File? file;
  String uri ="";

  Future CameraImage() async{
    var img = await image.pickImage(source: ImageSource.camera);
    setState(() {
      file = File(img!.path);
    });
  }

  Future GalaryImage() async{
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
    });
  }

  Future <void> uploadFile() async {
    String imageName = DateTime.now().microsecondsSinceEpoch.toString();
    String id=imageName;
    var imagefile = FirebaseStorage.instance.ref().child(imageName).child("$imageName");
    UploadTask task = imagefile.putFile(file!);
    TaskSnapshot snapshot = await task;

    //for Download the image
    uri = await snapshot.ref.getDownloadURL();

    /// store the image url the firestore database
    await FirebaseFirestore.instance
    .collection('images')
    .doc(id)
    .set({"img": uri});
    print(uri);
  }

  Future<void> deleteImage(String id,BuildContext context)async{
    await FirebaseFirestore.instance.collection('images').doc(id).delete().then((value) {
      FirebaseStorage.instance.ref().child('imageName').child(id).delete();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Delete Successfully',
          )));
      // Navigator.pop(context);
    },onError: (error){
      Navigator.pop(context);
    });
  }Future <void> UpdateImg(String id) async {
    var imagefile = FirebaseStorage.instance.ref().child('imageName').child(id);
    TaskSnapshot snapshot = await imagefile.putFile(file!);
    /// for download the image
    imageUri = await snapshot.ref.getDownloadURL();
    /// store the image url into the firestore database
    await FirebaseFirestore.instance
        .collection("images")
        .doc(id)
        .set({"img": imageUri});
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Successfully Updated',
        )));
    // print(uri);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Image'),centerTitle: true,),
      body: ListView(
          children: [
            SizedBox(height: 15,),
            Center(
              child: CircleAvatar(
                radius: 80,
                backgroundImage: file == null
                  ? AssetImage("img/1.png")
                  : FileImage(File(file!.path)) as ImageProvider,
              ),
            ),
            // ClipRRect(
            //   child: file ==,
            // ),
            SizedBox(height: 10,),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: (){
                        CameraImage();
                      },
                      child: Text('Camera'),),
                  SizedBox(width: 5,),

                  ElevatedButton(
                    onPressed: (){
                      GalaryImage();
                    },
                    child: Text('Galery'),),

                  SizedBox(width: 5,),
                  ElevatedButton(
                    onPressed: (){
                      uploadFile();
                    },
                    child: Text('Upload'),),
                  SizedBox(width: 5,),

                ],
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("images")
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return
                      GridView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          // primary: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 5,
                          ),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index){
                            QueryDocumentSnapshot querysnapshot = snapshot.data!.docs[index];

                            return InkWell(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            View(
                                              url: querysnapshot['img'],
                                            )));
                              },
                              child: Hero(
                                tag: querysnapshot['img'],
                                child: Card(
                                  child: Image.network(
                                    querysnapshot['img'],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),

                            );
                          }
                      );
                  }
                  return Center(
                      child: CircularProgressIndicator());
                }
            ),
          ],
        ),
    );
  }
}

class View extends StatelessWidget {
  final url;

  View({this.url});

  @override
  Widget build(BuildContext context) {
    return Hero(tag: url, child: Image.network(url));
  }
}

