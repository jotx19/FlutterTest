import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'DataRepository.dart';

class OtherPage extends StatefulWidget {
  @override
  State<OtherPage> createState() => OtherPageState();
}

class OtherPageState extends State<OtherPage>
{
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController phone;
  late TextEditingController email;
  var message;

  @override
  void initState()
  {
    super.initState();
    DataRepository.loadData();
    setState(() {
      firstName = TextEditingController(text: DataRepository.firstName);
      lastName = TextEditingController(text: DataRepository.lastName);
      phone = TextEditingController(text: DataRepository.phone);
      email = TextEditingController(text: DataRepository.email);
    });
  }

  @override
  void dispose()
  {
    updateRepository();
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    phone.dispose();
    super.dispose();
  }

  void updateRepository()
  {
    DataRepository.firstName = firstName.text;
    DataRepository.lastName = lastName.text;
    DataRepository.phone = phone.text;
    DataRepository.email = email.text;
    DataRepository.saveData();
    message = 'Data has been Saved';
    snackBar();
  }

  void snackBar()
  {
    final snackBar = SnackBar
      (
        content: Text(message)
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void launchURL(String url) async
  {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      message = 'Could not launch $url';
      snackBar();
    }
  }
  void launchPhone(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      message = 'Could not launch $url';
      snackBar();
    }
  }
  void launchSMS(String phoneNumber) async {
    final url = 'sms:$phoneNumber';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      message = 'Could not launch $url';
      snackBar();
    }
  }
  void launchEmail(String emailAddress) async {
    final url = 'mailto:$emailAddress';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      message = 'Could not launch $url';
      snackBar();
    }
  }

  void goBack()
  {
    Navigator.pushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: Text('Welcome ${DataRepository.loginID}'),
          actions: [FloatingActionButton(onPressed: () {Navigator.pop(context);},
              child: Text('Go Back'), backgroundColor: Colors.redAccent)],
        ),
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  OutlinedButton(
                    onPressed: () { goBack(); },
                    child: const Text("Go Home"),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                const SizedBox(height: 16.0),
                TextField(
                  controller: firstName,
                  obscureText: false,
                  decoration: const InputDecoration(
                    hintText: "Enter your First Name",
                    border: OutlineInputBorder(),
                    labelText: "First Name",
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: lastName,
                  obscureText: false,
                  decoration: const InputDecoration(
                    hintText: "Enter your Last Name",
                    border: OutlineInputBorder(),
                    labelText: "Last Name",
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: phone,
                        obscureText: false,
                        decoration: const InputDecoration(
                          hintText: "Enter your Phone Number",
                          border: OutlineInputBorder(),
                          labelText: "Phone Number",
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => launchPhone(phone.text),
                      icon: const Icon(Icons.phone),
                      label: const Text('Telephone'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => launchSMS(phone.text),
                      icon: const Icon(Icons.sms),
                      label: const Text('SMS'),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: email,
                        obscureText: false,
                        decoration: const InputDecoration(
                          hintText: "Enter your Email Address",
                          border: OutlineInputBorder(),
                          labelText: "Email Address",
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => launchEmail(email.text),
                      icon: const Icon(Icons.mail),
                      label: const Text('Mail'),
                    ),
                  ],
                ),
                TextButton.icon(onPressed: () {updateRepository();}, label: Text('Save Data'),icon: Icon(Icons.add_box),),
              ],
            ),
            ),
        );
    }
}
