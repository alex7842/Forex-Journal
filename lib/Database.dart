
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authservice{

  final auth=FirebaseAuth.instance;
  Future<User?> createUserWithEmailAndPassword(
    String email,String password) async{
      try{

      final cred= await auth.createUserWithEmailAndPassword(email: email, password: password);
      return cred.user;
      }
      catch(e){
    print("something went wrong");
      }
      return null;
    }

    Future<User?> loginWithEmailAndPassword(
    String email,String password) async{
      try{

      final cred= await auth.signInWithEmailAndPassword(email: email, password: password);
      return cred.user;
      }
      catch(e){
    
    print(e);
    print("something went wrong");

      }
      return null;
    }

    Future<void> signout() async{
      try{
       await auth.signOut();
      }
      catch(e){
    print("something went wrong");
      }
     
    }
 Future<Stream<QuerySnapshot>> getTradeData(String userId) async {
    // Create a reference to the 'data1' collection
    CollectionReference dataCollection =
        FirebaseFirestore.instance.collection('data1');

    // Create a reference to the 'trade' subcollection under the user document
    CollectionReference tradeCollection =
        dataCollection.doc(userId).collection('trade');

    // Return the stream of trade data
    return tradeCollection.snapshots();
  }
Future<void> deleteTradeDocument(String dataId, String tradeDocId) async {
  try {
    await FirebaseFirestore.instance
        .collection('data1') // Parent collection
        .doc(dataId) // Document ID of the parent document
        .collection('trade') // Subcollection
        .doc(tradeDocId) // Document ID of the trade document to be deleted
        .delete();
    print('Trade document deleted successfully');
  } catch (error) {
    print('Failed to delete trade document: $error');
  }
}
 Future<void> updateUserData(String id,String account ) async {
    CollectionReference dataCollection = FirebaseFirestore.instance.collection('data1');

    await dataCollection.doc(id).update({
  
      'balance':account,
    
    });
  }


}