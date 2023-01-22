import 'package:flutter/material.dart';
import 'package:graduation/presentation/screens/register/register.dart';
import 'package:graduation/shared/constants.dart';
import 'package:graduation/shared/styles/colors.dart';

class LoginScreen extends StatefulWidget {
  static String tag = 'login-page';

  @override
  State<StatefulWidget> createState() {
    return new _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  bool _obscureText = true;
  bool? check1 = false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity,150),
        child: ClipPath(
          clipper: CustomAppBarShape(),
          child: Container(
            color: kPrimaryColor,
          ),
        ),
      ),
      body:  Center(
        child:  SingleChildScrollView(
          child:  Container(
            margin:  EdgeInsets.all(20.0),
            child: Center(
              child:  Form(
                key: _key,

                child: _getFormUI(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getFormUI() {
    return Column(
      children: <Widget>[

        //SizedBox(height: 50.0),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          decoration: InputDecoration(

            enabledBorder: UnderlineInputBorder(

              borderSide: BorderSide(
                  width: 3, color: Colors.black12),
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black12)),
            hintText: 'Email',
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),

          ),

        ),
        SizedBox(height: 20.0),
        TextFormField(
          keyboardType: TextInputType.text,
          autofocus: false,
          obscureText: _obscureText,

          decoration: InputDecoration(
            hintText: 'Password',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 3, color: Colors.black12),
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black12)),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: Icon(
                color: Colors.black12,
                _obscureText ? Icons.visibility : Icons.visibility_off,
                semanticLabel:
                _obscureText ? 'show password' : 'hide password',
              ),
            ),
          ),
        ),
        SizedBox(height: 15.0),
        Row(
          children:<Widget> [
            Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                activeColor: kPrimaryColor,
                value: check1,
                onChanged: (bool? value){
                  setState(() {
                    check1 = value;
                  });
                }
            ),
            Text("Remember me",
              style: TextStyle(color: Colors.black54,fontSize: 15),
            )
          ],
        ),
        SizedBox(height: 10.0),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: ButtonTheme(
              buttonColor: kPrimaryColor,
              minWidth: 250.0,
              height: 50.0,

                child: MaterialButton(
                  color: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                onPressed: () {},
                child: Text("Sign in",
                  style:TextStyle(color: Colors.white,fontSize: 21),
                ),
              ),
            )
        ),
        TextButton(
          child: Text(
            'Forgot password?',
            style: TextStyle(color: Colors.black54),
          ),
          onPressed: _showForgotPasswordDialog,
        ),




        TextButton(
            onPressed: ()
            {
              navigateAndFinish(context, RegisterScreen());
            },
            child: Text('Not a member? Sign up now',
            style: TextStyle(color: Colors.black54))),

      ],
    );
  }

  Future<Null> _showForgotPasswordDialog() async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: const Text('Please enter your Email'),
            contentPadding: EdgeInsets.all(5.0),
            content: new TextField(
              decoration: new InputDecoration(hintText: "Email"),

            ),
            actions: <Widget>[
              new TextButton(
                child: new Text("Ok"),
                onPressed: () async {

                  Navigator.pop(context);
                },
              ),

            ],
          );
        });
  }
}
class CustomAppBarShape extends CustomClipper<Path> {


  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height*0.5);
    path.quadraticBezierTo(size.width*0.005, size.height*0.8, size.width*0.3, size.height*0.8);
    path.lineTo(size.width*0.8, size.height*0.8);
    path.quadraticBezierTo(size.width, size.height*0.8, size.width,size.height);
    path.lineTo(size.width, 0);
    // path.lineTo(0, size.height*0.5);
    // path.quadraticBezierTo(size.width*0.05, size.height, size.width*0.9, size.height*0.8);
    // path.quadraticBezierTo(size.width+5, size.height*0.8, size.width, size.height);
    // path.lineTo(size.width, 0);

    return path;
  }

  @override

  bool shouldReclip (CustomClipper<Path> oldClipper)
  {
    return false;
  }
}