import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_guide/widgets/appBarDecoration.dart';

class curd extends StatefulWidget {
  const curd({Key? key}) : super(key: key);

  @override
  _curdState createState() => _curdState();
}

class _curdState extends State<curd> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final CollectionReference _user =
  FirebaseFirestore.instance.collection('user');

  Future<void> _create() async{
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx){
          return Padding(padding: EdgeInsets.all(20),
          child: Column(
              mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name',),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'email'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text('Create'),
                onPressed: () async{
                  final String? name = _nameController.text;
                  final String? email = _emailController.text;
                  if (name != null && email !=null){
                    await _user.add({"name": name, "email":email});

                    _nameController.text = '';
                    _emailController.text = '';
                    Navigator.of(context).pop();

                  }
                },
              )
            ],
          ),
          );
        });
  }
  Future<void> _delete(String userid) async{
    await _user.doc(userid).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDEcoration(context, 'curd'),
      body: Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("user").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasData){
            return ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            primary: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index){
              QueryDocumentSnapshot networkData = snapshot.data!.docs[index];
              return Card(
                child: ListTile(
                  title: Text(networkData['name']),
                  subtitle: Text(networkData['email']),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(onPressed: (){},
                            icon: Icon(Icons.edit),
                        ),
                        IconButton(onPressed: (){
                          _delete(networkData.id);
                        },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
      );
          }
          return Center(child: CircularProgressIndicator());
      }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _create();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
