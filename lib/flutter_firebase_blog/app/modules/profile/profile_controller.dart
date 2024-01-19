import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class ProfileController extends GetxController {
  final count = 0.obs;
  final RxString userName = RxString('');

  Future<void> getCurrentUserName() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      DocumentSnapshot doc =
      await firestore.collection('users').doc(auth.currentUser!.uid).get();
      // print('Got it!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
      // print(auth.currentUser!.uid);
      final userData = doc.data() as Map<String, dynamic>;
      // print('reused it!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
      final name = userData['name'];
      userName.value = name;
    }
    catch (e) {
      userName.value = 'Unknown';
    }
  }

  @override
  void onInit() {
    super.onInit();
    getCurrentUserName();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
