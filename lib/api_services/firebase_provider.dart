// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class FirebaseProvider {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<UserCredential> signIn(String email, String password) {
//     return _auth.signInWithEmailAndPassword(email: email, password: password);
//   }

//   Future<UserCredential> signUp(String email, String password) {
//     return _auth.createUserWithEmailAndPassword(
//         email: email, password: password);
//   }

//   Future<void> signOut() {
//     return _auth.signOut();
//   }

//   Future<DocumentSnapshot> getUserData(String uid) {
//     return _firestore.collection('users').doc(uid).get();
//   }

//   Future<void> updateUserData(String uid, Map<String, dynamic> data) {
//     return _firestore.collection('users').doc(uid).update(data);
//   }

//   Stream<QuerySnapshot> getCollectionStream(String collectionPath) {
//     return _firestore.collection(collectionPath).snapshots();
//   }

//   Future<DocumentReference> addDocument(
//       String collectionPath, Map<String, dynamic> data) {
//     return _firestore.collection(collectionPath).add(data);
//   }

//   Future<void> updateDocument(
//       String collectionPath, String docId, Map<String, dynamic> data) {
//     return _firestore.collection(collectionPath).doc(docId).update(data);
//   }

//   Future<void> deleteDocument(String collectionPath, String docId) {
//     return _firestore.collection(collectionPath).doc(docId).delete();
//   }
// }
