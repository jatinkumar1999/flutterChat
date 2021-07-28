import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final bool _isLoading;
  final void Function(
    String email,
    String password,
    String userName,
    bool isLogin,
    BuildContext context,
  ) submit;
  AuthForm(this.submit, this._isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _form = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userName = "";
  String _userEmail = "";
  String _userPassword = "";

  void _submit() {
    if (_form.currentState!.validate()) {
      _form.currentState!.save();
      FocusScope.of(context).unfocus();
      widget.submit(
        _userEmail,
        _userPassword,
        _userName,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Form(
              key: _form,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey("userName"),
                      decoration: InputDecoration(
                        hintText: "userName",
                        labelText: "userName",
                      ),
                      keyboardType: TextInputType.name,
                      validator: (value) => (value!.isEmpty || value.length < 4)
                          ? "Please enter 4+ chars "
                          : null,
                      onSaved: (value) {
                        _userName = value!;
                      },
                    ),
                  TextFormField(
                    key: ValueKey("email"),
                    decoration: InputDecoration(
                      hintText: "email",
                      labelText: "email",
                    ),
                    validator: (value) =>
                        (value!.isEmpty || !value.contains("@"))
                            ? "Please enter a valid email  "
                            : null,
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) {
                      _userEmail = value!;
                    },
                  ),
                  TextFormField(
                    key: ValueKey("Password"),
                    decoration: InputDecoration(
                      hintText: "password",
                      labelText: "password",
                    ),
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) => (value!.isEmpty || value.length < 6)
                        ? "Please enter 6+ chars password "
                        : null,
                    onSaved: (value) {
                      _userPassword = value!;
                    },
                  ),
                  SizedBox(height: 10),
                  if(widget._isLoading)
                  CircularProgressIndicator(),
                  if(!widget._isLoading)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).buttonColor,
                      elevation: 0.0,
                    ),
                    onPressed: _submit,
                    child: Text(_isLogin ? "Login" : "SignUp"),
                  ),
                  SizedBox(height: 15),
                  if(!widget._isLoading)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_isLogin
                          ? "wanna to be member ?"
                          : "Already a mamber"),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(
                          _isLogin ? "SignUp Here" : "SignIn Here ",
                          style: TextStyle(
                            color: Theme.of(context).canvasColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
