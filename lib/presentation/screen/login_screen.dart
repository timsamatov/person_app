import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:person_app/data/model/person_model.dart';
import 'package:person_app/presentation/widget/custom_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String name = '';
  String username = '';
  String phone = '';
  String email = '';
  String picture = '';
  String longitude = '';
  String latitude = '';

  @override
  void initState() {
    super.initState();
    randomPerson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: const Color(0xff68B1C9),
        title: TextButton(
          onPressed: () {
            randomPerson();
          },
          child: const Text(
            'Generate',
            style: TextStyle(color: Color(0xff0042EB), fontSize: 16),
          ),
        ),
      ),
      backgroundColor: const Color(0xff68B1C9),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 74,
              ),
              const SizedBox(
                height: 66,
              ),
              CustomTextField(
                title: 'Name',
                value: name,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                title: 'UserName',
                value: username,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                title: 'email',
                value: email,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                title: 'phone',
                value: phone,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 1.0,
                child: ElevatedButton(
                  onPressed: () {
                    openGoogleMaps(latitude, longitude);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff002D62),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),)
                    
                  ),
                  child:  const Text('Get Location',style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> randomPerson() async {
    final Dio dio = Dio();

    final Response response = await dio.get('https://randomuser.me/api/');

    final Map<String, dynamic> data = response.data;
    final List<dynamic> results = data['results'];

    if (results.isNotEmpty) {
      final Results model = Results.fromJson(results[0]);
      name = model.name?.first ?? '';
      username = model.login?.username ?? '';
      email = model.email ?? '';
      phone = model.phone ?? '';
      picture = model.picture?.medium ?? '';
      latitude = model.location?.coordinates?.latitude ?? '';
      longitude = model.location?.coordinates?.longitude ?? '';

      setState(() {});
    } else {
      print('Пусто');
    }
  }

  Future<void> openGoogleMaps(String? latitude, String? longitude) async {
    if (latitude != null && longitude != null) {
      String url =
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
      // ignore: deprecated_member_use
      if (await canLaunch(url)) {
        // ignore: deprecated_member_use
        await launch(url);
      } else {
        print('Could not launch $url');
      }
    }
  }
}
