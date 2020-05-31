import 'package:GRE_APP/Pages/play_quiz.dart';
import 'package:GRE_APP/Widgets/Widgets.dart';
import 'package:GRE_APP/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'create_quiz.dart';

class Home extends StatefulWidget {
  const Home({Key key, this.user}) : super(key: key);
  final FirebaseUser user;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream quizStream;
  DataBaseService databaseService = new DataBaseService();
  Widget quizList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
        stream: quizStream,
        builder: (context, snapshot) {
          return snapshot.data == null ? Container(): 
          ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index){
            return QuizTile(
              imgURL: snapshot.data.documents[index].data["quizImageURL"],
              title: snapshot.data.documents[index].data["quizTitle"],
              description: snapshot.data.documents[index].data["quizDescription"],
              quizId:snapshot.data.documents[index].data["quizId"]);
          });
        },
      ) 
    );
  }
  @override
  void initState() {
    databaseService.getQuizData().then((val) {
     
      setState(() {
         quizStream = val;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: quizList(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateQuiz(),
              ),
            );
          }),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String imgURL;
  final String title;
  final String description;
  final String quizId;

  QuizTile({@required this.imgURL,@required this.title,@required this.description,@required this.quizId});
  @override
  Widget build(BuildContext context) {
    return
     GestureDetector(
       onTap: () {
         Navigator.push(context, MaterialPageRoute
         (builder: (context) => QuizPlay(
           quizId

         )));
       },
            child: Container(
        height: 150,
        margin: EdgeInsets.only(bottom:8),

        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
                        child: Image.network(imgURL, 
              width: MediaQuery.of(context).size.width-48, fit: BoxFit.cover,),
            ),
            Container(
              decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(8),
                          color: Colors.black26,
              ),

              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),),
                  SizedBox(height: 6),
                  Text(description, style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),),
                ],
              ),
            )
          ],
        )
    ),
     );
  }
}