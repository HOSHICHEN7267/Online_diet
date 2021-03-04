import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data.dart';

class WeightChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WeightChartState();
}

class WeightChartState extends State<WeightChart> {
  bool isShowingMainData;
  bool chosen = false;
  String chosenYear;
  String chosenMonth;
  String chosenDay;
  List<WeightData> weightData = [];
  final weightTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  void dispose(){
    weightTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: (){
                Navigator.pop(context);
              }
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              const Text(
                '減重曲線',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    //fontWeight: FontWeight.bold,
                    letterSpacing: 2),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                '紀錄您邁向減重成功的每一步',
                style: TextStyle(
                  color: Color(0xffADADAD),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 40,
              ),
              weightData.isNotEmpty? weightChart() : firstTime(),
              SizedBox(height: 10,),
              daliyWeightText(),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  weightField(),
                  SizedBox(width: 30,),
                  submitButton(),
                ],
              ),
              SizedBox(height: 10,),
              clearButton(),
              SizedBox(height: 70,)
            ],
          ),
        )
    );
  }

  Widget daliyWeightText(){
    return Text('每日體重紀錄', style: TextStyle(color: Colors.black, fontSize: 26, letterSpacing: 2));
  }

  Widget firstTime(){
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffD0D0D0), width: 2.0),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('輸入第一筆資料\n開啟減重之旅!', style: TextStyle(fontSize: 35, letterSpacing: 2, color: Color(0xff00DDE0)), textAlign: TextAlign.center,),
            ],
          )
      ),
    );
  }

  Widget weightField(){
    return SizedBox(
      //padding: EdgeInsets.only(left: 110.0, right: 110.0),
      height: 60,
      width: 150,
      child: TextField(
        controller: weightTextController,
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 20.0),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),),
          labelText: '今日體重:',
          labelStyle: TextStyle(fontSize: 20),
          filled: true,
        ),
      ),
    );
  }

  Widget submitButton(){
    return RaisedButton(
      padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0, bottom: 10.0),
      color: Colors.white,
      elevation: 5.0,
      child: Text('確認', style: TextStyle(fontSize: 25.0, color: Color(0xff00DDE0)),),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: Color(0xffD0D0D0)),
      ),
      onPressed: (){
        WeightData nowData = new WeightData();

        nowData.weight = weightTextController.text;
        weightData.add(nowData);

        double nowWeight = double.parse(nowData.weight);
        if(nowWeight >= maxWeight){
          maxWeight = nowWeight.toInt()+1;
        }
        if(nowWeight <= minWeight){
          minWeight = nowWeight.toInt();
        }

        setState(() {

        });
      },
    );
  }

  Widget clearButton(){
    return RaisedButton(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
      color: Colors.white,
      elevation: 5.0,
      child: Text('清除資料', style: TextStyle(fontSize: 20.0, color: Color(0xff00DDE0)),),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: Color(0xffD0D0D0)),
      ),
      onPressed: (){
        weightData.clear();
        setState(() {
          maxWeight = 0;
          minWeight = 300;
        });
      },
    );
  }

  Widget weightChart(){
    return Container(
      color: Colors.white,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.45,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 6.0),
          child: LineChart(
            sampleData1(),
            swapAnimationDuration: const Duration(milliseconds: 250),
          ),
        ),
      ),
    );
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        horizontalInterval: 0.5,
        show: weightData.isNotEmpty ? true : false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
            color: Color(0xffD0D0D0),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            if(value.toInt() <= weightData.length){
              return 'Day${value.toInt()}';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xffD0D0D0),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            if(value.toInt() >= minWeight && value.toInt() <= maxWeight){
              return '${value.toInt()}kg';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xffE0E0E0),
            width: 1.25,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 1,
      maxX: weightData.isNotEmpty? weightData.length.toDouble()+0.05 : 0,
      maxY: weightData.isNotEmpty? maxWeight.toDouble() : 65,
      minY: weightData.isNotEmpty? minWeight.toDouble() : 60,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: weightData.isNotEmpty ? weightData.asMap().entries.map((e){
        return FlSpot(e.key.toDouble()+1, double.parse(e.value.weight));
      }).toList() : [FlSpot(0, 0)],
      isCurved: false,
      colors: [
        const Color(0xff00DDE0),
      ],
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: weightData.isNotEmpty ? true : false,
      ),
      belowBarData: BarAreaData(
          show: false,
          colors: [
            Color(0xff00DDE0),
            Color(0xffBBFFFF),
          ],
          gradientColorStops: [
            0.5, 0.2
          ]
      ),
    );
    return [
      lineChartBarData1,
    ];
  }
}
