import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Login/Forgotpass.dart';
import 'package:flutter_application_3/Login/HomeScreen.dart';
import 'package:flutter_application_3/Login/user_Signup.dart';
import 'package:flutter_application_3/firebase/profile.dart';
import 'package:flutter_application_3/global_variables.dart';
import 'package:flutter_application_3/user/reset.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  bool _isObscure2 = true;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final _auth = FirebaseAuth.instance;
  Profile profile = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(seconds: 120));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: Stack(children: [
                CachedNetworkImage(
                  imageUrl: loginUrlImage3,
                  placeholder: (context, url) => Image.asset(
                    'images/food2.jpg',
                    fit: BoxFit.cover,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  alignment: FractionalOffset(_animation.value, 0),
                ),
                Container(
                  color: Colors.black54,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 50),
                    child: ListView(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                        child: Image.asset(
                          "images/RFLOGO.png",
                          height: 200,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Form(
                          key: _formkey,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'อีเมล์',
                                    enabled: true,
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 8.0, top: 8.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: Colors.white),
                                      borderRadius:
                                          new BorderRadius.circular(10),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: Colors.white),
                                      borderRadius:
                                          new BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: "กรุณาป้อนอีเมลด้วยครับ"),
                                    EmailValidator(
                                        errorText: "รูปแบบอีเมล์ไม่ถูกต้อง")
                                  ]),
                                  onSaved: (value) {
                                    emailController.text = value!;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: passwordController,
                                  obscureText: _isObscure2,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        icon: Icon(_isObscure2
                                            ? Icons.visibility_off
                                            : Icons.visibility),
                                        onPressed: () {
                                          setState(() {
                                            _isObscure2 = !_isObscure2;
                                          });
                                        }),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'รหัสผ่าน',
                                    enabled: true,
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 8.0, top: 15.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: Colors.white),
                                      borderRadius:
                                          new BorderRadius.circular(10),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: Colors.white),
                                      borderRadius:
                                          new BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: RequiredValidator(
                                      errorText: "กรุณาป้อนรหัสผ่านด้วยครับ"),
                                  onSaved: (value) {
                                    passwordController.text = value!;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                Container(
                                  alignment: Alignment(1, 0),
                                  padding: EdgeInsets.only(top: 15, right: 15),
                                  child: InkWell(
                                    child: Text(
                                      "สมัครสมาชิก",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Montserrat",
                                          decoration: TextDecoration.underline),
                                    ),
                                    onTap: () {
                                      print('');

                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: (_) {
                                          return Register();
                                        }),
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  alignment: Alignment(1, 0),
                                  padding: EdgeInsets.only(top: 15, right: 15),
                                  child: InkWell(
                                    child: Text(
                                      "ลืมรหัสผ่าน",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Montserrat",
                                          decoration: TextDecoration.underline),
                                    ),
                                    onTap: () {
                                      print('');
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: (_) {
                                          return Forgotpass();
                                        }),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: SizedBox(
                                    height: 45,
                                    width: 400,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white.withOpacity(0.5)),
                                        fixedSize: MaterialStateProperty.all(
                                            Size(120, 50)),
                                      ),
                                      child: Text("เข้าสู่ระบบ",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255))),
                                      onPressed: () {
                                        setState(() {
                                          visible = true;
                                        });
                                        signIn(emailController.text,
                                            passwordController.text);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ]),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Fluttertoast.showToast(
              msg: "ไม่มีอีเมล์นี้อยู่ในระบบครับ",
              gravity: ToastGravity.CENTER);
        } else if (e.code == 'wrong-password') {
          Fluttertoast.showToast(
              msg: "รหัสผ่านผิดโปรดป้อนใหม่ครับ", gravity: ToastGravity.CENTER);
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
