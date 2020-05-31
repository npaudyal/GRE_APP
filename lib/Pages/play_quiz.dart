import 'package:GRE_APP/Widgets/Widgets.dart';
import 'package:GRE_APP/Widgets/quiz_play_widgets.dart';
import 'package:GRE_APP/models/question_model.dart';
import 'package:GRE_APP/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlayQuiz extends StatefulWidget {
  final String quizId;
  PlayQuiz(this.quizId);
  @override
  _PlayQuizState createState() => _PlayQuizState();
}

int total = 0;
int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;
class _PlayQuizState extends State<PlayQuiz> {
  DataBaseService databaseService = new DataBaseService();
  QuerySnapshot questionSnapshot;

  QuestionModel getQuestionModelFromDataSnapshot(DocumentSnapshot questionSnapshot) {
        QuestionModel questionModel = new QuestionModel();
        questionModel.question = questionSnapshot.data["question"];

        List<String> options = 
        [
        questionSnapshot.data["Option 1"],
        questionSnapshot.data["Option 2"],
        questionSnapshot.data["Option 3"],
        questionSnapshot.data["Option 4"],



        
        ];

        options.shuffle();

        questionModel.option1 = options[0];
        questionModel.option2 = options[1];
        questionModel.option3 = options[2];
        questionModel.option4 = options[3];

        questionModel.correctOption = questionSnapshot.data["Option 1"];
        questionModel.answered = false;
        return questionModel;

  }
  @override
  void initState() {

    print("${widget.quizId}");
    databaseService.getQuizesData(widget.quizId).then((value) {
      questionSnapshot = value;
      _notAttempted = 0;

      _correct = 0;
      _incorrect = 0;
      total = questionSnapshot.documents.length;
    
      setState(() {
        
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
        iconTheme: IconThemeData(color: Colors.black),
        brightness: Brightness.light,
      ),
      body: Container(
        child: Column(children: [
            questionSnapshot.documents == null ? 
            Container() : 
            ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: questionSnapshot.documents.length,
              itemBuilder: (context, index) {
                return QuizPlayTile(
                    questionModel :getQuestionModelFromDataSnapshot(
                    questionSnapshot.documents[index]),
                    index: index,
                );
              }
            ),
        ],),
      ),
    );
  }
  
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  QuizPlayTile({this.questionModel, this.index});
  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {

  String optionSelected = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(widget.questionModel.question),
          SizedBox(height: 4,),
          GestureDetector(
            onTap: () {
              if(!widget.questionModel.answered){
                if(widget.questionModel.option1 == widget.questionModel.correctOption) {
                    optionSelected = widget.questionModel.option1;
                    widget.questionModel.answered = true;
                    _correct = _correct +1;
                    _notAttempted = _notAttempted - 1;
                    setState(() {
                      
                    });
                }else{
                    optionSelected = widget.questionModel.option1;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect +1;
                     _notAttempted = _notAttempted - 1;
                    setState(() {
                      
                    });
                }
              }

            },
              child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: widget.questionModel.option1,
              option: "A",
              optionSelected: optionSelected,

            ),
          ),
           SizedBox(height: 4,),
          GestureDetector(
             onTap: () {
               if(!widget.questionModel.answered){
                if(widget.questionModel.option2 == widget.questionModel.correctOption) {
                    optionSelected = widget.questionModel.option2;
                    widget.questionModel.answered = true;
                    _correct = _correct +1;
                    _notAttempted = _notAttempted - 1;
                    setState(() {
                      
                    });
                }else{
                    optionSelected = widget.questionModel.option2;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect +1;
                     _notAttempted = _notAttempted - 1;
                    setState(() {
                      
                    });
                }
              }

            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: widget.questionModel.option2,
              option: "B",
              optionSelected: optionSelected,

            ),
          ),
           SizedBox(height: 4,),
          GestureDetector(
             onTap: () {
               if(!widget.questionModel.answered){
                if(widget.questionModel.option3 == widget.questionModel.correctOption) {
                    optionSelected = widget.questionModel.option3;
                    widget.questionModel.answered = true;
                    _correct = _correct +1;
                    _notAttempted = _notAttempted - 1;
                    setState(() {
                      
                    });
                }else{
                    optionSelected = widget.questionModel.option3;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect +1;
                     _notAttempted = _notAttempted - 1;
                    setState(() {
                      
                    });
                }
              }

            },
                      child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: widget.questionModel.option3,
              option: "C",
              optionSelected: optionSelected,

            ),
          ),
           SizedBox(height: 4,),
          GestureDetector(
              onTap: () {
               if(!widget.questionModel.answered){
                if(widget.questionModel.option4 == widget.questionModel.correctOption) {
                    optionSelected = widget.questionModel.option4;
                    widget.questionModel.answered = true;
                    _correct = _correct +1;
                    _notAttempted = _notAttempted - 1;
                    setState(() {
                      
                    });
                }else{
                    optionSelected = widget.questionModel.option4;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect +1;
                     _notAttempted = _notAttempted - 1;
                    setState(() {
                      
                    });
                }
              }

            },
                      child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: widget.questionModel.option4,
              option: "D",
              optionSelected: optionSelected,

            ),
          )
        ],
      ),
    );
  }
}