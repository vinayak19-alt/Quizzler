import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'QuizBrain.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(const Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Quizzler',
            style: TextStyle(
              color: Colors.white,
            ),
            ),
          ),
          backgroundColor: Colors.grey,
        ),
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
            child:Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
              child: QuizPage(),
            ),
        ),
      ),
    );
  }
}


class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer){
    bool correctAnswer = quizBrain.getQuestionAnswer();
    setState(() {
      if(quizBrain.isFinished()==true){
        Alert(
          context: context,
          type: AlertType.error,
          title: "Finished",
          desc: "You\'ve reached the end of quiz",
          buttons: [
            DialogButton(
              onPressed: () => Navigator.pop(context),
              width: 120,
              child: const Text(
                "Cancel",
                style:
                TextStyle(
                    color:
                    Colors.white,
                    fontSize: 20),
              ),
            )
          ],
        ).show();
        quizBrain.reset();
        scoreKeeper=[];
      }else {
        if(userPickedAnswer == correctAnswer){
          scoreKeeper.add(const Icon(
            Icons.check,
            color: Colors.green,
          ));
        }else {
          scoreKeeper.add(const Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizBrain.nextQuestion();
      }});
    }
  @override
  Widget build(BuildContext context) {
   return Column(
     mainAxisAlignment: MainAxisAlignment.spaceBetween,
     crossAxisAlignment: CrossAxisAlignment.stretch,
     children: [
        Expanded(
         flex: 5,
         child: Padding(
           padding:const EdgeInsets.all(10.0),
           child: Center(
             child: Text(
                 quizBrain.getQuestionText(),
               style: const TextStyle(
                 color: Colors.white,
                 fontSize: 25,
               ),
               textAlign: TextAlign.center,
             ),
           ),
         ),
       ),
       Expanded(
         child: Padding(
           padding: const EdgeInsets.all(15.0),
           child: TextButton(
             style: TextButton.styleFrom(
               backgroundColor: Colors.green,
             ),
             onPressed: (){
              checkAnswer(true);
             },child: const Text(
               'True',
             style: TextStyle(
               fontSize: 20,
               color: Colors.white
             ),
           ),
           ),
         ),
       ),
       Expanded(
         child: Padding(
           padding: const EdgeInsets.all(15.0),
           child: TextButton(
             style: TextButton.styleFrom(
               backgroundColor: Colors.red,
             ),
             onPressed: (){
               checkAnswer(false);
             },child: const Text(
              'False',
             style: TextStyle(
               fontSize: 20,
               color: Colors.white
             ),
            ),
           ),
         ),
       ),
       Row(
         children: scoreKeeper,
       ),
     ],
   );
  }
}

