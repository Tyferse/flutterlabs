import 'package:flutterlabs/flutter_firebase_blog/app/data/const.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/data/global_widgets/indicator.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/models/blog_model.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';


class FirebaseFunctions {
  final FirebaseFirestore _firebase_firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _firebase_storage = FirebaseStorage.instanceFor(bucket: "gs://flutter-project-342f8.appspot.com");
  bool _has_more_data = true;
  DocumentSnapshot? _last_document;
  final int _document_limit = 6;
  // int _end_offset = 0;
  var is_loading = false.obs;

  Future<void> createUserCredential(String name, String email, String password) async {
    try {
      await _firebase_firestore
          .collection('users').doc(_auth.currentUser!.uid).set({
        "name": name,
        "email": email,
        "password": password
      }).then((value) {
        Indicator.closeLoading();
        Get.toNamed(Routes.home);
      });
    }
    catch (e) {
      showAlert(e.toString());
    }
  }

  Future<void> uploadBlog(String title, String description) async {
    try {
      Map<String, dynamic> blogDetails = {
        'title': title,
        'description': description,
        'time': DateTime.now(),
      };

      await _firebase_firestore.collection('blogs').add(blogDetails)
          .then((value) {
        saveDataToMyBlogs(value.id);
      });
    }
    catch (e) {
      showAlert("$e");
    }
  }

  Future<List<BlogsModel>> getBlogs() async {
    if (_has_more_data && !is_loading.value) {
      try {
        is_loading.value = true;

        Query query = _firebase_firestore.collection('blogs').orderBy('time');

        if (_last_document != null) {
          query = query.startAfterDocument(_last_document!);
        }

        QuerySnapshot querySnapshot = await query.get(); // .limit(_document_limit)

        if (querySnapshot.docs.isNotEmpty) {
          // _last_document = querySnapshot.docs.last;
          // if (querySnapshot.docs.length < _document_limit) {
          //   _has_more_data = false;
          // }

          is_loading.value = false;
          Indicator.closeLoading();

          return querySnapshot.docs
              .map((doc) => BlogsModel.fromJson(doc.id, doc.data() as Map<String, dynamic>))
              .toList();
        }
        else {
          _has_more_data = false;
          is_loading.value = false;
          return [];
        }
      }
      catch (e) {
        showAlert("$e");
        print(e.toString());
        is_loading.value = false;
        Indicator.closeLoading();
        return [];
      }
    }
    else {
      return [];
    }
  }

  // Future<List<BlogsModel>> getBlogs() async {
  //   if (_has_more_data) {
  //     if (!is_loading.value) {
  //       try {
  //         if (_last_document == null) {
  //           return await _firebase_firestore
  //               .collection('blogs')
  //               .orderBy('time')
  //               .limit(_document_limit)
  //               .get()
  //               .then((value) {
  //             // _last_document = value.docs.last;
  //             if (value.docs.length < _document_limit) {
  //               _has_more_data = false;
  //             }
  //
  //             Indicator.closeLoading();
  //
  //             return value.docs
  //                 .map((e) => BlogsModel.fromJson(e.id, e.data())).toList();
  //           });
  //         }
  //         else {
  //           is_loading.value = true;
  //
  //           return await _firebase_firestore
  //               .collection("blogs")
  //               .orderBy('time')
  //               .startAfterDocument(_last_document!)
  //               .limit(_document_limit)
  //               .get()
  //               .then((value) {
  //             _last_document = value.docs.last;
  //
  //             if (value.docs.length < _document_limit) {
  //               _has_more_data = false;
  //             }
  //
  //             is_loading.value = false;
  //             return value.docs
  //                 .map((e) => BlogsModel.fromJson(e.id, e.data())).toList();
  //           });
  //         }
  //       }
  //       catch (e) {
  //         showAlert("$e");
  //         print(e.toString());
  //         return [];
  //       }
  //     }
  //     else {
  //       return [];
  //     }
  //   }
  //   else {
  //     print("Нет больше данных");
  //     return [];
  //   }
  // }

  Future<void> saveDataToMyBlogs(String id) async {
    try {
      await _firebase_firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('my_blogs')
          .doc(id)
          .set({'id': id});
    }
    catch (e) {
      showAlert("$e");
    }
  }

  Future<List> getMyBlogs() async {
    try {
      var snapshot = await _firebase_firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection("my_blogs")
          .get();

      return snapshot.docs.map((e) => e.data()['id']).toList();
    }
    catch (e) {
      showAlert("$e");
      return [];
    }
  }

  Future<BlogsModel> getBlogsById(String id) async {
    try {
      var documentSnapshot = await _firebase_firestore.collection('blogs').doc(id).get();
      // print(documentSnapshot.data());
      return BlogsModel.fromJson(id, documentSnapshot.data()!);
    }
    catch (e) {
      showAlert("$e");
      return BlogsModel(id: "", title: "", description: "", time: DateTime.now());
    }
  }

  Future<void> deleteBlog(String id) async {
    await Future.wait([
      deleteMyBlog(id),
      deletePublicBlog(id),
    ]);
  }

  Future<void> deletePublicBlog(String id) async {
    try {
      await _firebase_firestore.collection('blogs').doc(id).delete();
    }
    catch (e) {
      showAlert("$e");
    }
  }

  Future<void> deleteMyBlog(String id) async {
    try {
      await _firebase_firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('my_blogs')
          .doc(id)
          .delete();
    }
    catch (e) {
      showAlert("$e");
    }
  }
}
