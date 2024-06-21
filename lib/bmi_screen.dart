import 'package:flutter/material.dart';

class BmiScreen extends StatelessWidget {
  const BmiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator',style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body:Container(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(color: Colors.grey,),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.male),
                              Text('Male',
                                style: TextStyle(fontSize: 40.0,
                                    fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(color: Colors.grey,),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.female),
                              Text('Female',
                                style: TextStyle(fontSize: 40.0,
                                    fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(color: Colors.grey,),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Height',
                                style: TextStyle(fontSize: 40.0,
                                    fontWeight: FontWeight.bold),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('180',
                                    style: TextStyle(fontSize: 40.0,
                                        fontWeight: FontWeight.bold),),
                                  Text('Cm',
                                    style: TextStyle(fontSize: 20.0,
                                        fontWeight: FontWeight.bold),),
                                ],
                              ),
                              Slider(value: 180, onChanged:
                                  (value) {
                                print(value);
                              },
                              min: 80,
                              max: 220,)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(color: Colors.grey,),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                        
                              Text('Age',
                                style: TextStyle(fontSize: 40.0,
                                    fontWeight: FontWeight.bold),),
                              Text('180',
                                style: TextStyle(fontSize: 40.0,
                                    fontWeight: FontWeight.bold),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add),
                                  SizedBox(width: 20.0),
                                  Icon(Icons.remove),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(color: Colors.grey,),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                        
                              Text('Weight',
                                style: TextStyle(fontSize: 40.0,
                                    fontWeight: FontWeight.bold),),
                              Text('70',
                                style: TextStyle(fontSize: 40.0,
                                    fontWeight: FontWeight.bold),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add),
                                  SizedBox(width: 20.0),
                                  Icon(Icons.remove),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration:BoxDecoration(color: Colors.blue,),
              child:
              MaterialButton(onPressed: (){
                print('180');
              },
                child:  Text('Calculate'),
              ),
            )
          ],
        ),
      ),

    );
  }
}
