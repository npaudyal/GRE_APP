import 'package:GRE_APP/Widgets/Widgets.dart';
import 'package:GRE_APP/services/database.dart';
import 'package:flutter/material.dart';

class AddQuestion extends StatefulWidget {
 final  String quizId;
 AddQuestion(this.quizId);
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
    final _formKey = GlobalKey<FormState>();
    String question, option1, option2, option3, option4;
    bool _isLoading =false;
    DataBaseService databaseService = new DataBaseService();

    uploadQuestionData() async{
      if(_formKey.currentState.validate()) {

        setState(() {
          _isLoading = true;
        });

        Map<String, String> questionMap = {
          "question": question,
          "Option 1": option1,
          "Option 2": option2,
          "Option 3": option3,
          "Option 4": option4,

        };
        databaseService.addQuestionData(questionMap, widget.quizId)
        .then((value){
           question = "";
        option1 = "";
        option2 = "";
        option3 = "";
        option4 = "";
        setState(() {
          _isLoading = false;
        });

      }).catchError((e){
        print(e);
      });


    }else{
      print("error is happening ");
    }
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

      body:_isLoading ? Container(
            child: Center(child: CircularProgressIndicator(),),
      ) :Form ( 
        key: _formKey,
        child : Container(
        padding: EdgeInsets.symmetric(horizontal:24),
        child: Column( children: [
          TextFormField(
                        validator: (val) => val.isEmpty ? "Enter the question" : null,
                        decoration: InputDecoration(
                          hintText: "Whats the question?",
                        ),
                        onChanged: (val) {
                          question=
                          val;
                        },
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? "Enter an option" : null,
                        decoration: InputDecoration(
                          hintText: "Option 1",
                        ),
                        onChanged: (val) {
                          option1=
                          val;
                        },
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? "Enter an option" : null,
                        decoration: InputDecoration(
                          hintText: "Option 2",
                        ),
                        onChanged: (val) {
                          option2=
                          val;
                        },
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? "Enter an option" : null,
                        decoration: InputDecoration(
                          hintText: "Option 3",
                        ),
                        onChanged: (val) {
                          option3=
                          val;
                        },
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? "Enter an option" : null,
                        decoration: InputDecoration(
                          hintText: "Option 4",
                        ),
                        onChanged: (val) {
                          option4=
                          val;
                        },
                      ),
              Spacer(),
              Row(
                children: [
                                    GestureDetector(
                                      onTap: () {
                                            Navigator.pop(context);
                                      },

                             child: blueButton(
                            context: context,
                            label:"Submit",
                            buttonWidth: MediaQuery.of(context).size.width/2 - 36,

                  ),
                                    ),
                  SizedBox(width: 24),
                  GestureDetector(
                  onTap: () {
                      uploadQuestionData();
                  } ,
                   child: blueButton(
                            context: context,
                            label:"Add Question",
                            buttonWidth: MediaQuery.of(context).size.width/2 - 36,

                  ))
                ],
              ),
              SizedBox(height: 60),

        ])
        
      ),
      ),

    );
  }
}
