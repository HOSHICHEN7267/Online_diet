import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'data.dart';

class QuestionPage extends StatefulWidget {
  @override
  QuestionPageState createState() => QuestionPageState();
}

class QuestionPageState extends State<QuestionPage> {

  Color themeColor = Color(0xff00DDE0);
  List<QuestionItem> questionItems;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    questionItems = getQuestionList();
  }

  Widget questionList(int index){
    return Card(
      elevation: 8.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: ListTile(
        leading: Icon(questionItems[index].icon, color: questionItems[index].iconColor, size: 38,),
        title: Text(questionItems[index].title, style: TextStyle(fontSize: 22, color: themeColor),),
        subtitle: Text(questionItems[index].subtitle, style: TextStyle(fontSize: 15, color: Colors.black),),
        onTap: (){
          if(index == 0 || index == 1){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => questionPageNavs[index],
            ));
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(
            color: Colors.black87
        ),
        toolbarHeight: height * 0.06,
      ),
      drawer: Drawer(
          child: Container()// Populate the Drawer in the next step.
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 24),
          child: Column(
            children: [
              Image.asset("assets/question.png", height: height * 0.25, fit: BoxFit.fitHeight,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Text("問卷資料", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, fontStyle: FontStyle.normal),),
                  SizedBox(height: 10,),
                  questionList(0),
                  SizedBox(height: 10,),
                  questionList(1),
                  SizedBox(height: 10,),
                  questionList(2),
                  SizedBox(height: 10,),
                  questionList(3),
                  SizedBox(height: 10,),
                  questionList(4),
                  SizedBox(height: 30,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
