import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  TextEditingController _name;
  TextEditingController _lastName;

  @override
  void initState() {
    _name = TextEditingController();
    _lastName = TextEditingController();
    fetchFormData().whenComplete(() => null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return Scaffold(
      appBar: AppBar(
        title: Text("Form"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "First name"),
                controller: _name,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Last name"),
                controller: _lastName,
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(onPressed: () async{
                await saveFormData();
              }, child: Text("Save"))
            ],
          ),
        ),
      ),
    );
  }

  //Write to disk
  Future saveFormData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("name", _name.text);
    await prefs.setString("last_name", _lastName.text);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Saved")));
  }

  //Read from disk
  Future fetchFormData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name.text = prefs.getString("name");
    _lastName.text = prefs.getString("last_name");
  }
}
