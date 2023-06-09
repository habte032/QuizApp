import 'package:flutter/material.dart';
import 'Quiz.dart';
import 'dart:math';


Quiz quiz=new Quiz();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  List<Widget> score=[];

  int result=0;
 int questionNumber=0;
 int back=1;
  @override
  Widget build(BuildContext context) {
    bool hideButtons = score.length > 9;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        backgroundColor: Colors.black87,
        body:SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: IconButton(onPressed: (){
                setState(() {
                  score.clear();
                  result=0;
                  back=1;
                });
                setState(() {
                  questionNumber=0;
                });
              },icon: Icon(Icons.refresh,color: Colors.white,),)),
              Expanded(
                  flex: 5,
                  child:
              Center(
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  child: score.length<10?Text( quiz.questions[questionNumber].question,style: TextStyle(color: Colors.white),):
                  Column(
                    children: [
                      Text('You have finished this round',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),
                      Text('Score',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 20),),
                      result>=5?Text('$result',style: TextStyle(color: Colors.green,fontWeight: FontWeight.w800,fontSize: 22),):
                      Text('$result',style: TextStyle(color: Colors.red,fontWeight: FontWeight.w800,fontSize: 22),),
                       result>=5?Text('Passed',style: TextStyle(color: Colors.green),):Text('Failed',style: TextStyle(color: Colors.red),)
                    ],
                  )
                ),
              )
              ),
              hideButtons?Expanded(child: Container(
                height: 5,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey
                ),
                child: TextButton(onPressed: (){
                  setState(() {
                    score.clear();
                    result=0;
                  });

                },child: Text('Next Round',style: TextStyle(color: Colors.white),),),
              )):

              Expanded(child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(onPressed: (){
                   setState(() {
                     if(questionNumber>0  ) {
                       back--;
                       questionNumber--;
                     }
                     else
                       questionNumber=0;
                   });

                  }, icon: Icon(Icons.arrow_back,color: Colors.white,)),

                  IconButton(onPressed: (){
                    setState(() {
                      if(questionNumber<quiz.questions.length-1 ){
                        questionNumber++;
                        back=1;
                        }
                      else
                        questionNumber=quiz.questions.length-1;
                    });
                  }, icon: Icon(Icons.arrow_forward,color: Colors.white,)),
                ],
              )),
             hideButtons||back!=1 ?Expanded(child: Text('')): Expanded(
                child: Container(

                  height: 5,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.teal
                  ),
                  margin: const EdgeInsets.all(8.0),
                  child: TextButton(onPressed: (){
                    bool correctAnswer=quiz.questions[questionNumber].Answer;
                    setState(() {
                      if(correctAnswer==true){
                        score.add(Icon(Icons.check,color: Colors.green,));
                      result++;}
                      else
                        score.add(Icon(Icons.close,color: Colors.red,));
                    });
                    setState(() {
                      if(questionNumber<quiz.questions.length-1  )
                      questionNumber++;
                      else
                        questionNumber=0;
                    });
                    setState(() {
                      if(score.length>11)
                        score.clear();
                      else
                        score;
                    });
                  }, child: Text('True',style:TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                  ),
                ),
              ),
              hideButtons ||back!=1 ?Expanded(child: Text('')):Expanded(
                child:Container(
                  height: 5,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                      color: Colors.deepOrange.shade400
                  ),
                  margin: const EdgeInsets.all(8.0),
                  child: TextButton(onPressed: (){
                    bool correctAnswer=quiz.questions[questionNumber].Answer;
                    setState(() {
                      if(correctAnswer==false){
                        score.add(Icon(Icons.check,color: Colors.green,));
                      result++;}
                      else
                        score.add(Icon(Icons.close,color: Colors.red,));
                    });
                    setState(() {
                      if(score.length>11)
                        score.clear();
                      else
                        score;
                    });
                    setState(() {
                      if(questionNumber<quiz.questions.length-1)
                        questionNumber++;
                      else
                        questionNumber=0;
                    });
                  }, child: Text('Fasle',style:TextStyle(color: Colors.white),textAlign: TextAlign.center,),

                  ),
                ),
              ),
               Container(
                 width: MediaQuery.of(context).size.width*0.9,
                 child: Row(
                   //crossAxisAlignment: CrossAxisAlignment.center,
                   children: score,
                  ),
               ),
            ],
          ),
        ) ,
      ) ,
    );
  }
}
