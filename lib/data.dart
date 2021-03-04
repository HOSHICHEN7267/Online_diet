import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'formPersonal.dart';
import 'weightChart.dart';

//----------Navigation--------------------------------------------------------

List questionPageNavs = [
  PersonalForm(),
  WeightChart(),
];

//----------class-------------------------------------------------------------

class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key));
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}

class QuestionItem{
  IconData icon;
  Color iconColor;
  String title;
  String subtitle;

  QuestionItem({this.icon, this.iconColor, this.title, this.subtitle});
}

class PersonalInfo{
  String username = '';
  String age = '';
  String gender = '';
  String phone = '';
  String lineid = '';
  String wrist = '';
  String weight = '';
  String eighteenweight = '';
  String bodytype = '';
  String fattime = '';
  String problems = '';
  List<dynamic> ifHaveProblems = [];
  String pregnant = '';
  String poo = '';
  String water = '';
  String exercise = '';
  String work = '';
  String unsatisfyPart = '';
  String expectWeight = '';

  PersonalInfo();

  PersonalInfo.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        age = json['age'],
        gender = json['gender'],
        phone = json['phone'],
        lineid = json['lineid'],
        wrist = json['wrist'],
        weight = json['weight'],
        eighteenweight = json['eighteenweight'],
        bodytype = json['bodytype'],
        fattime = json['fattime'],
        problems = json['problems'],
        ifHaveProblems = json['ifHaveProblems'],
        pregnant = json['pregnant'],
        poo = json['poo'],
        water = json['water'],
        exercise = json['exercise'],
        work = json['work'],
        unsatisfyPart = json['unsatisfyPart'],
        expectWeight = json['expectWeight'];

  Map<String, dynamic> toJson() => {
    'username': username,
    'age': age,
    'gender': gender,
    'phone': phone,
    'lineid': lineid,
    'wrist': wrist,
    'weight': weight,
    'eighteenweight': eighteenweight,
    'bodytype': bodytype,
    'fattime': fattime,
    'problems': problems,
    'ifHaveProblems': ifHaveProblems,
    'pregnant': pregnant,
    'poo': poo,
    'water': water,
    'exercise': exercise,
    'work': work,
    'unsatisfyPart': unsatisfyPart,
    'expectWeight': expectWeight,
  };
}

class WeightData{
  String weight = '';
}

//----------Variable-----------------------------------------------------------

int maxWeight = 0;
int minWeight = 300;

const String Storage_personalInfo = 'personalInfo';
const String Storage_weightData = 'weightData';

//----------List---------------------------------------------------------------

List<QuestionItem> getQuestionList(){
  List<QuestionItem> questionList = new List<QuestionItem>();
  QuestionItem questionItem = new QuestionItem();

  // Question1
  questionItem.icon = Icons.info;
  questionItem.iconColor = Color(0xff00DDE0);
  questionItem.title = "基本資料";
  questionItem.subtitle = "讓我們能更加認識您!";
  questionList.add(questionItem);

  questionItem = new QuestionItem();

  // Question2
  questionItem.icon = Icons.tag_faces;
  questionItem.iconColor = Color(0xffFF00FF);
  questionItem.title = "健康分析";
  questionItem.subtitle = "分享您的健康狀況!";
  questionList.add(questionItem);

  questionItem = new QuestionItem();

  // Question3
  questionItem.icon = Icons.lightbulb_outline;
  questionItem.iconColor = Color(0xffFF8040);
  questionItem.title = "肥胖因素分析";
  questionItem.subtitle = "一起揪出肥胖背後的操盤手!";
  questionList.add(questionItem);

  questionItem = new QuestionItem();

  // Question4
  questionItem.icon = Icons.fastfood;
  questionItem.iconColor = Color(0xff66B3FF);
  questionItem.title = "飲食盤點";
  questionItem.subtitle = "吃吃喝喝也是有學問的!";
  questionList.add(questionItem);

  questionItem = new QuestionItem();

  // Question5
  questionItem.icon = Icons.whatshot;
  questionItem.iconColor = Color(0xff00DDE0);
  questionItem.title = "影響減重調查";
  questionItem.subtitle = "抓出拖慢減重步調的戰犯!";
  questionList.add(questionItem);

  questionItem = new QuestionItem();

  return questionList;
}