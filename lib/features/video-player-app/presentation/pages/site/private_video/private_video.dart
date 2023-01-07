import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../Utils/dimenstion.dart';
import '../../../widgets/big_custom_appbar.dart';
import 'keyboard/num_pad.dart';
import 'open_private_videos.dart';

class PrivateVideos extends StatefulWidget {
  const PrivateVideos({Key? key}) : super(key: key);

  @override
  State<PrivateVideos> createState() => _PrivateVideosState();
}

class _PrivateVideosState extends State<PrivateVideos> {

  int requiredNumber = 1234;
  final TextEditingController _myController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BigCustomAppBar(
        title: "Private Videos",
        firstIcon: Icons.abc,
        secondIcon: Icons.abc,
        color: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xffF6F8FD),
          child: Column(
            children: [
              SizedBox(
                height: Dimensions.height25,
              ),
              SizedBox(
                height: 90,
                  child: Center(
                      child: Image.asset("assets/images/lock.png",
                      ),
                  ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Set Pin',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,

                  ),
                ),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // display the entered numbers
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      height: 40,
                      child: Center(
                          child: TextField(
                            controller: _myController,
                            textAlign: TextAlign.center,
                            showCursor: false,
                            obscureText: true,
                            obscuringCharacter: "*",
                            style: const TextStyle(fontSize: 40,),
                            // Disable the default soft keybaord
                            keyboardType: TextInputType.none,
                          )),
                    ),
                  ),
                  // implement the custom NumPad
                  NumPad(
                    buttonSize: 75,
                    buttonColor: Colors.white,
                    iconColor: Colors.deepOrange,
                    controller: _myController,
                    delete: () {
                      _myController.text = _myController.text
                          .substring(0, _myController.text.length - 1);
                    },
                    // do something with the input numbers
                    onSubmit: () {
                      //To Show entered value in textview

                     /* debugPrint('Your code: ${_myController.text}');
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            content: Text(
                              "You code is ${_myController.text}",
                              style: const TextStyle(fontSize: 30),
                            ),
                          ));*/

                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                            return OpenPrivateVideos();
                          }));

                    },
                  ),
                ],
              ),

            /*  Padding(
                padding: const EdgeInsets.only(top: 8,bottom: 8,left: 80,right: 80),
                child: PinCodeTextField(
                  obscureText: true,
                  obscuringCharacter: '*',
                  appContext: context,
                  length: 4,

                  onChanged: (value){
                    print("Val is: $value");
                  },
                  pinTheme: PinTheme(
                    inactiveColor: Colors.black,
                    activeColor: Colors.black,
                    selectedColor: Colors.red,
                  ),
                  onCompleted: (value){
                    if(value == requiredNumber){
                      print('Valid Pin');
                    }else{
                      print("Invalid Pin");
                    }
                  },
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 75,child: Image.asset("assets/images/one.png")),

                  SizedBox(height: 75,child: Image.asset("assets/images/two.png")),

                  SizedBox(height: 75,child: Image.asset("assets/images/three.png")),

                ],
              ),
              SizedBox(height: 7,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 75,child: Image.asset("assets/images/four.png")),

                  SizedBox(height: 75,child: Image.asset("assets/images/five.png")),

                  SizedBox(height: 75,child: Image.asset("assets/images/six.png")),

                ],
              ),



              SizedBox(height: 7,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 75,child: Image.asset("assets/images/seven.png")),

                  SizedBox(height: 75,child: Image.asset("assets/images/eight.png")),

                  SizedBox(height: 75,child: Image.asset("assets/images/nine.png")),

                ],
              ),


              SizedBox(height: 7,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 75,child: Image.asset("assets/images/zero.png")),


                ],
              ),
*/


             /* Padding(
                padding: const EdgeInsets.only(left: 50,right: 50,top: 20,bottom: 10),
                child: SizedBox(
                  height: 62,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xff678BFF),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Next',style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                      ],
                    ),
                  ),
                ),
              )*/
              

            ],
          ),
        ),
      ),
    );
  }
}
