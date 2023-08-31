import 'package:flutter_application_11/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_application_11/models/config.dart';
import 'package:flutter_application_11/models/user.dart';

class Login extends StatefulWidget {
  static const routeName = "/login";
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

//Login
class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  User user = User();

  Future<void> login(User user) async {
    var params = {"email": user.email, "password": user.password};
    var url = Uri.http(Configure.server, "user", params);
    var resp = await http.get(url);
    print(resp.body);
    List<User> login_result = userFromJson(resp.body);
    print(login_result.length);
    if (login_result.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("username or password invalid")));
    } else {
      Configure.login = login_result[0];
      Navigator.pushNamed(context, Home.routeName);
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                emailInputField(),
                passwordInputField(),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    SubmitButton(),
                    SizedBox(
                      width: 10.0,
                    ),
                    BackButton(),
                    SizedBox(
                      width: 10.0,
                    ),
                    registerLink()
                  ],
                )
              ],
            )),
      ),
    );
  }

  Widget emailInputField() {
    return TextFormField(
      initialValue: "weenus.zonn@gmail.com",
      decoration: InputDecoration(labelText: "Email:", icon: Icon(Icons.email)),
      validator: (value) {
        if (value!.isEmpty) {
          return "this field required";
        }
        if (!EmailValidator.validate(value)) {
          return "It is not email format";
        }
        return null;
      },
      onSaved: (newValue) => user.email = newValue,
    );
  }

  Widget passwordInputField() {
    return TextFormField(
      initialValue: "171245",
      obscureText: true,
      decoration:
          InputDecoration(labelText: "Password:", icon: Icon(Icons.lock)),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      onSaved: (newValue) => user.password = newValue,
    );
  }

  Widget TextHeader() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        child: Text(
          'Login',
          style: TextStyle(
            fontSize: 28,
          ),
        ),
      ),
    );
  }

  Widget SubmitButton() {
    return ElevatedButton(
        onPressed: () {
          if (_formkey.currentState!.validate()) {
            _formkey.currentState!.save();
            print(user.toJson().toString());
            login(user);
          }
        },
        child: Text("Login"));
  }

  Widget BackButton() {
    return ElevatedButton(onPressed: () {}, child: Text("Back"));
  }

  Widget registerLink() {
    return InkWell(child: Text("Sign Up"), onTap: () {});
  }

}

