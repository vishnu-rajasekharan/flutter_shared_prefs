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
  int ddlValue;

  @override
  void initState() {
    _name = TextEditingController();
    _lastName = TextEditingController();
    fetchFormData().whenComplete(() => null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              DropdownButtonFormField<int>(
                  value: ddlValue,
                  onChanged: (value) {
                    setState(() {
                      ddlValue = value;
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Age Group",
                      hintText: "Please choose one"),
                  items: [
                    DropdownMenuItem<int>(
                      child: Text("12-16"),
                      value: 1,
                    ),
                    DropdownMenuItem<int>(
                      child: Text("17-55"),
                      value: 2,
                    ),
                    DropdownMenuItem<int>(
                      child: Text("56+"),
                      value: 3,
                    )
                  ]),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                height: 45,
                child: ElevatedButton(
                    onPressed: () async {
                      await saveFormData();
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Roboto"
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )
                        //Other properties
                        )),
              ),
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
    await prefs.setInt("age_group", ddlValue);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Saved")));
  }

  //Read from disk
  Future fetchFormData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name.text = prefs.getString("name");
    _lastName.text = prefs.getString("last_name");
    ddlValue = prefs.getInt("age_group");
  }
}
