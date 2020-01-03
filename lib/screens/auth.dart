import 'package:flutter/material.dart';
import 'package:idea_chat/models/auth.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

// final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

String _passwordValidator(String value) {
  if (value.isEmpty) {
    return 'Please enter some text';
  }
  return null;
}

class LoginFormWidget extends StatefulWidget {
  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  TextEditingController _teControllerEmail = TextEditingController();
  TextEditingController _teControllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthModel model = Provider.of<AuthModel>(context);

    if (model.success) {
      // Navigator.of(context).pushReplacementNamed("/chat");
      // return null;
    }

    // final _formKey = GlobalKey<FormState>();
    final teEmail = TextField(
      controller: _teControllerEmail,
      onChanged: (String value) => model.email = value,
      decoration: const InputDecoration(
        icon: Icon(Icons.email),
        labelText: 'Email',
      ),
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return 'Please enter some text';
      //   }
      //   return null;
      // },
    );

    final tePassword = TextField(
      controller: _teControllerPassword,
      onChanged: (String value)=> model.password = value,
      decoration: const InputDecoration(
        icon: Icon(Icons.vpn_key),
        labelText: 'Password',
      ),
      // validator: _passwordValidator,
      obscureText: true,
    );

    _teControllerEmail.text = model.email;
    _teControllerPassword.text = model.password;

    final btnLogin = RaisedButton(
      onPressed: () {
        model.email = _teControllerEmail.text;
        model.password = _teControllerPassword.text;

        // if (_formKey.currentState.validate()) {
          model.login();
        // }
      },

      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: double.infinity,
          maxHeight: 50,
        ),
        child: Align(
          alignment: Alignment.center,
          // child: Text("Log in"),
          child: (model.loading) ? CircularProgressIndicator() : Text("Log in"),
        ),
      ),
    );

    return Container(
      // key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          teEmail,
          tePassword,
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Align(
                alignment: Alignment.center,
                child: btnLogin,
              )
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _teControllerEmail.dispose();
    _teControllerPassword.dispose();
    super.dispose();
  }
}

class AuthForm extends StatelessWidget {
  final DefaultApi _api;

  AuthForm(this._api);

  @override
  Widget build(BuildContext context) {
    final formProvider = ChangeNotifierProvider<AuthModel>(
      builder: (context) => AuthModel(_api),
      child: LoginFormWidget(),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Log in'),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: formProvider,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
