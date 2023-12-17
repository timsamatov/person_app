import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:person_app/data/model/person_model.dart';
import 'package:person_app/presentation/widget/custom_text_field.dart';

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
              ElevatedButton(
                  onPressed: () {}, child: const Text('Get Location'))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> randomPerson() async {
    final Dio dio = Dio();
    try {
      final Response response = await dio.get('https://randomuser.me/api/');

      final Results model = Results.fromJson(response.data);
      name = model.name?.first ?? '';
      username = model.login?.username ?? '';
      email = model.email ?? '';
      phone = model.phone ?? '';
      setState(() {});
    } catch (e) {
      print('Ошибка: $e');
    }
  }
}
