import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollection {
  users,
  messages;

  CollectionReference get reference => FirebaseFirestore.instance.collection(name);
}
