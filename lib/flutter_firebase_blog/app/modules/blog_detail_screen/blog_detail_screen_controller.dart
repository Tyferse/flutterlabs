import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/data/firebase/firebase_functions.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/modules/home/home_controller.dart';
import '../../data/const.dart';
import '../../data/global_widgets/indicator.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


class BlogDetailScreenController extends GetxController {
  final controller = Get.find<HomeController>();
  final FirebaseFunctions _firebase_functions = FirebaseFunctions();
  var isAdded = false.obs;
}


class CommentController extends GetxController {
  final Rx<List<List<String>>> _comments = Rx<List<List<String>>>([]);
  // List<List<String>> get comments => _comments.value;

  Future<String> getAuthorName(String user_id) async {
    return await FirebaseFirestore.instance.collection('users').doc(user_id).get()
        .then((DocumentSnapshot doc) {
          final userData = doc.data() as Map<String, dynamic>;
          return userData['name'];
        }
    );
  }

  Future<void> loadComments(String blogId) async {
    // Indicator.showLoading();
    final commentsSnapshot = await FirebaseFirestore.instance
        .collection('blogs').doc(blogId).collection('comments')
        .orderBy('time', descending: false).get();

    print(_comments.value);
    _comments.value.assignAll(commentsSnapshot.docs.map((comment) =>
      [comment.data()['user_id'], comment.data()['text']]));

    // Indicator.closeLoading();

    print(_comments.value);
  }

  void addComment(String blogId, String userId, String newComment) {
    if (newComment.isNotEmpty) {
      Indicator.showLoading();
      FirebaseFirestore.instance.collection('blogs').doc(blogId).collection('comments').add({
        'user_id': userId,
        'text': newComment,
        'time': DateTime.now()
      }).then((_) {
        loadComments(blogId);
        Indicator.closeLoading();
        showAlert("Комментарий успещно добавлено");
        });
      _comments.value.add([userId, newComment]);
    }
  }
}

class CommentList extends StatefulWidget {
  final String blog_id;

  CommentList({required this.blog_id});

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  late final CommentController commentController;
  late bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    commentController = Get.find();
    loadComments();
  }

  Future<void> loadComments() async {
    setState(() {
      _isLoading = true;
    });
    await commentController.loadComments(widget.blog_id);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : commentController._comments.value.isEmpty
        ? const Center(child: Text('Комментарии пока отсутствуют'))
        : ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: commentController._comments.value.length,
      itemBuilder: (context, index) {
        var currentComment = commentController._comments.value[index];
        return CommentItem(
          currentComment: currentComment,
          key: Key(currentComment[0]),
        );
      },
    );
  }
}


// class CommentList extends StatelessWidget {
//   final String blog_id;
//   final CommentController commentController = Get.find();
//   CommentList({required this.blog_id});
//
//   @override
//   Widget build(BuildContext context) {
//     commentController.loadComments(blog_id);
//     // Future.delayed(Duration(seconds: 1));
//     print('@@@@@@@@@@@@@@@@@@@@');
//     print(commentController._comments.value);
//
//     return Obx(() {
//       // var comments = commentController.comments;
//         if (commentController._comments.value.isEmpty) {
//           return Center(child: Text('Комментарии пока отсутствуют'));
//         }
//         else {
//           return ListView.builder(
//             shrinkWrap: true,
//             itemCount: commentController._comments.value.length,
//             itemBuilder: (context, index) {
//               var currentComment = commentController._comments.value[index];
//               return CommentItem(currentComment: currentComment,
//                   key: Key(currentComment[0]));
//             },
//           );
//         }
//       },
//     );
//   }
// }


class CommentItem extends StatelessWidget {
  final List<String> currentComment;
  final Key key;

  const CommentItem({
    required this.currentComment,
    required this.key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    CommentController commentController = CommentController();
    return ListTile(
      title:
      FutureBuilder<String>(
        future: commentController.getAuthorName(currentComment[0]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Загрузка...');
          }
          else {
            if (snapshot.hasError) {
              return const Text('Unknown');
            }
            else {
              print('All is good');
              var authorName = snapshot.data ?? 'Unknown';
              print(snapshot.hasData);
              return Text(authorName);
            }
          }
        },
      ),
      subtitle: Text(currentComment[1]),
    );
  }
}

// class AddComment extends StatefulWidget {
//   final String blog_id;
//   final String user_id;
//   final String comment;
//
//   AddComment({required this.blog_id, required this.user_id, required this.comment});
//
//   @override
//   _AddCommentState createState() => _AddCommentState();
// }


// class _AddCommentState extends State<AddComment> {
//   late final CommentController commentController;
//   late bool _isLoading = false; // Определение _isLoading
//
//   @override
//   void initState() {
//     super.initState();
//     commentController = Get.find();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       CommentList(blog_id: widget.blog_id),
//       SizedBox(height: 22,),
//       ElevatedButton(
//         onPressed: () async {
//           setState(() {
//             _isLoading = true;
//           });
//           commentController.addComment(widget.blog_id, widget.user_id, widget.comment)
//           setState(() {
//             _isLoading = false;
//           });
//           },
//     child: const Text('Добавить комментарий'),
//     ),
//     ];
//   }
// }
