import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class BerandaService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> streamUsers() {
    CollectionReference data = firestore.collection("users");
    return data.snapshots();
  }

  Future<DocumentSnapshot<Object?>> getByIDUsers(String id) async {
    DocumentReference docRef = firestore.collection("users").doc(id);
    return docRef.get();
  }

  Stream<QuerySnapshot<Object?>> streamProduk() {
    CollectionReference data = firestore.collection("produk");
    return data.snapshots();
  }

  Future<DocumentSnapshot<Object?>> getByIDProduk(String id) async {
    DocumentReference docRef = firestore.collection("produk").doc(id);
    return docRef.get();
  }

  Stream<QuerySnapshot<Object?>> streamTips() {
    CollectionReference data = firestore.collection("tips");
    return data.snapshots();
  }

  Future<DocumentSnapshot<Object?>> getByIDTips(String id) async {
    DocumentReference docRef = firestore.collection("tips").doc(id);
    return docRef.get();
  }
}