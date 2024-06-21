import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuiro_quest_app/components/components.dart';

class Comment {
  final String id;
  final String uId;
  final String name;
  final int rating;
  final String comment;

  Comment({
    required this.id,
    required this.uId,
    required this.name,
    required this.rating,
    required this.comment,
  });

  factory Comment.fromDocumentSnapshot(DocumentSnapshot doc) {
    return Comment(
      id: doc.id,
      uId: doc['uId'],
      name: doc['name'],
      rating: doc['rating'],
      comment: doc['comment'],
    );
  }
}

class CommentCard extends StatelessWidget {
  final Comment comment;
  final bool canEditOrDelete;

  CommentCard({required this.comment, required this.canEditOrDelete});

  void _showEditCommentDialog(BuildContext context) {
    final _editCommentController = TextEditingController(text: comment.comment);
    int _editRating = comment.rating;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Comment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RatingBar.builder(
                initialRating: comment.rating.toDouble(),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 30,
                itemPadding: EdgeInsets.symmetric(horizontal: 4),
                itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
                onRatingUpdate: (rating) {
                  _editRating = rating.round();
                },
              ),
              TextField(
                controller: _editCommentController,
                decoration: InputDecoration(labelText: 'Comment'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('comments')
                    .doc(comment.id)
                    .update({
                  'rating': _editRating,
                  'comment': _editCommentController.text,
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: Icon(Icons.star, color: Colors.yellow),
        title: Text(comment.name),
        subtitle: Text('Rating: ${comment.rating} \nComment: ${comment.comment}'),
        trailing: canEditOrDelete
            ? Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _showEditCommentDialog(context),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('comments')
                    .doc(comment.id)
                    .delete();
              },
            ),
          ],
        )
            : null,
      ),
    );
  }
}

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  List<Comment> _comments = [];
  int _rating = 0;
  late TextEditingController _commentController;
  bool isAdmin = false;
  final List<String> adminUIds = [
    '3it1thywBvS1hdw339WMQj2rxko1', // Replace with actual admin uId
    'e7Hayj9mfNeQFYNUCHcxpwhOevC2' // Replace with actual admin uId
    // Add more admin user IDs as needed
  ];

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
    checkAdminStatus();
  }

  Future<void> checkAdminStatus() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      String uid = currentUser.uid;
      setState(() {
        isAdmin = adminUIds.contains(uid);
      });
    }
  }

  void _showCommentBox() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: 550,
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 30,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4),
                  itemBuilder: (context, _) {
                    return Icon(
                      Icons.star,
                      color: Colors.amber,
                    );
                  },
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating.round();
                    });
                  },
                ),
                SizedBox(height: 10),
                defaultFormField(
                  controller: _commentController,
                  label: 'Comment',
                  validate: null,
                  type: TextInputType.text,
                  prefix: Icons.comment,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    User? currentUser = FirebaseAuth.instance.currentUser;
                    String name = currentUser?.displayName ?? 'Anonymous';
                    String uId = currentUser?.uid ?? 'anonymous';

                    await FirebaseFirestore.instance
                        .collection('comments')
                        .add({
                      'uId': uId,
                      'name': name,
                      'rating': _rating,
                      'comment': _commentController.text,
                    });
                    _commentController.clear();
                    Navigator.pop(context);
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    String currentUserId = currentUser?.uid ?? '';

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Review Page', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('comments').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            _comments = snapshot.data!.docs.map((doc) {
              return Comment.fromDocumentSnapshot(doc);
            }).toList();
            return ListView.builder(
              itemCount: _comments.length,
              itemBuilder: (context, index) {
                bool canEditOrDelete = _comments[index].uId == currentUserId || isAdmin;
                return CommentCard(comment: _comments[index], canEditOrDelete: canEditOrDelete);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCommentBox,
        child: Icon(Icons.add),
      ),
    );
  }
}
