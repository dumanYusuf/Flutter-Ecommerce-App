import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_gelismis_eticaret/model/Users.dart';
import 'package:firebase_gelismis_eticaret/model/productModel.dart';
import 'package:firebase_gelismis_eticaret/servis/base/firestoreServis/database_servis.dart';


class FirestoreServis implements DatabaseServis {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future urunleriYukle() async {
    List<ProductModel> _products = [];
    try {
      return _firestore.collection("Products").snapshots().map((snapshots) =>
          snapshots.docs.map((e) => ProductModel.fromMap(e.data())).toList());
    } catch (e) {
      print("hata olustu");
    }
    return _products;
  }

  @override
  Future urunAra(String aramaKelimesi) async {
    List<ProductModel> arananUrunler = [];
    try {
      QuerySnapshot snapshot = await _firestore.collection("Products").get();

      List<ProductModel> aramaSonucu = snapshot.docs
          .map(
              (doc) => ProductModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      for (var elemnet in aramaSonucu) {
        if (elemnet.productTitle
            .toLowerCase()
            .contains(aramaKelimesi.toLowerCase())) {
          arananUrunler.add(elemnet);
        }
      }
      return arananUrunler;
    } catch (e) {
      print("Arama yapılırken hata oluştu: $e");
      return [];
    }
  }

  Future sepeteEkle(ProductModel productModel) async {
    User? curentUser = FirebaseAuth.instance.currentUser;

    var sepetIdAl =
        await _firestore.collection("Users").doc(curentUser!.uid).id;
    try {
      return _firestore
          .collection("Users")
          .doc(curentUser.uid)
          .collection("Sepet")
          .doc(sepetIdAl)
          .collection("Products")
          .doc(productModel.productId)
          .set(productModel.toMap(key: productModel.productId,));
    } catch (e) {
      print("urun sepete eklenirken hata olustu");
    }
  }

  @override
  Stream<List<ProductModel>>sepetiGetir() async* {

    User? curentUser = FirebaseAuth.instance.currentUser;
   /* var sepetRef = await _firestore
        .collection("Users")
        .doc(curentUser!.uid)
        .collection("Sepet")
        .get();

    print(sepetRef);
// bu kodda gerek yok zaten model sınıfa ceviriyoruz gelen urunleri ve liste olarak alıyoruz
    var maps = sepetRef.docs;
    var basketList =
        maps.map((e) => Sepet.fromMap(key: e.id, e.data())).toList();

    print(basketList[0].basketId.toString());*/

    yield* _firestore
        .doc("Users/${curentUser!.uid}")
        .collection("Sepet")
        .doc(curentUser.uid)
        .collection("Products").snapshots().map((event) =>
        event.docs.map((e) => ProductModel.fromMap(e.data(),key: e.id)).toList());
        
  }


  @override
  Future favoriEkle(ProductModel productModel)async {
    User? userCredantial=FirebaseAuth.instance.currentUser;
    
    var favoriIdAl= await _firestore.collection("Users").doc(userCredantial!.uid).id;
    
    try{
     return _firestore.collection("Users").doc(userCredantial.uid)
          .collection("favoriler").doc(favoriIdAl)
          .collection("Products").doc(productModel.productId)
          .set(productModel.toMap(key: productModel.productId));
    }
    catch(e){
      print("favori eklse serviste hata cıktı $e");
    }
    
  }

  @override
  Stream<List<ProductModel>> favoriGetir()async* {
    User? userCredential=FirebaseAuth.instance.currentUser;

    try{
      yield* _firestore
          .doc("Users/${userCredential!.uid}")
          .collection("favoriler")
          .doc(userCredential.uid)
          .collection("Products").snapshots().map((event) =>
          event.docs.map((e) => ProductModel.fromMap(e.data(),key: e.id)).toList());

    }
    catch(e){
      print("hata cıktı favorigetirde $e");
    }
  }

    @override
    Future favoriSil(ProductModel productModel)async {
      User? userCredential=FirebaseAuth.instance.currentUser;

      try{
        await _firestore
            .doc("Users/${userCredential!.uid}")
            .collection("favoriler")
            .doc(userCredential.uid)
            .collection("Products")
            .doc("${productModel.productId}")
            .delete();
      }
      catch(e){
        print("silme favori serviste hata cıktı");
      }
    }

  @override
  Future sepetSil(ProductModel productModel) async{
    User? curentUser=FirebaseAuth.instance.currentUser;
    try{
      await _firestore.collection("Users").doc(curentUser!.uid)
          .collection("Sepet").doc(curentUser.uid)
          .collection("Products").doc(productModel.productId).delete();
    }
    catch(e){
      print("sepet silme işleminde ha hata cıktı servir ");
    }
  }

  @override
  Stream<List<Users>> kullaniciGetir() async* {
    List<Users> users = [];

    User? curentUser=FirebaseAuth.instance.currentUser;
    try {
     yield* _firestore.collection("Users").where('id',isEqualTo: curentUser!.uid).snapshots().map((snapshot) =>
     snapshot.docs.map((e) => Users.frommap(key:e.id,e.data())).toList());
    } catch (e) {
      print("Hata oluştu: $e");
   print(users);
    }
    yield users;

  }

}
