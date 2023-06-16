import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_dokter/app/modules/kritik_dan_saran/controllers/kritik_dan_saran_controller.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  FeedbackPageState createState() => FeedbackPageState();
}

class FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  String? _email;
  String? _feedback;
  final controller = Get.put(KritikDanSaranController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Send Feedback',
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.left,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black87,
            size: 20,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.amber,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'Enter your name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              onSaved: (value) {
                _name = value;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
              onSaved: (value) {
                _email = value;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Feedback',
                hintText: 'Enter your feedback',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your feedback';
                }
                return null;
              },
              onSaved: (value) {
                _feedback = value;
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  await controller.uploadKritik(_email!, _feedback!, _name!);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Feedback sent'),
                      backgroundColor: Colors.amber,
                    ),
                  );
                  _formKey.currentState!.reset();
                }
              },
              child: Text('Send Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}
