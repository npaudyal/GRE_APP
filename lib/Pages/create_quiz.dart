import 'package:GRE_APP/Widgets/Widgets.dart';
import 'package:GRE_APP/services/database.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

import 'add_question.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  String quizImageURL, quizTitle, quizDescription, quizId;
  DataBaseService dataBaseService = new DataBaseService();
  bool _isLoading = false;
  CreateQuizOnline() async {
    if (_formKey.currentState.validate()) {
      _isLoading = true;
      quizId = randomAlphaNumeric(16);
      Map<String, String> quizMap = {
        "quizId": quizId,
        "quizImageURL": quizImageURL,
        "quizTitle": quizTitle,
        "quizDescription": quizDescription,
      };

      await dataBaseService.addQuizData(quizMap, quizId).then((value) {
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => AddQuestion(quizId)));
        });
      });
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
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) => val.isEmpty ? "Enter an URL" : null,
                        decoration: InputDecoration(
                          hintText: "Quiz Image URL",
                        ),
                        onChanged: (val) {
                          quizImageURL=
                          val;
                        },
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? "Enter a quiz title" : null,
                        decoration: InputDecoration(
                          hintText: "Quiz Title",
                        ),
                        onChanged: (val) {
                          quizTitle=
                          val;
                        },
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? "Enter a quiz description" : null,
                        decoration: InputDecoration(
                          hintText: "Quiz Description",
                        ),
                        onChanged: (val) {
                          quizDescription=
                          val;
                        },
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            CreateQuizOnline();
                          },
                          child: blueButton(
                            context: context,
                            label:"Create Quiz"

                  )),
                    ],
                  )),
            ),
    );
  }
}
