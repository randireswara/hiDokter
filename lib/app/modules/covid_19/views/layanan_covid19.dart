import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_dokter/app/database/authentication/authentication_repository.dart';
import 'package:hi_dokter/app/modules/covid_19/controllers/covid_19_controller.dart';

class CovidForm extends StatefulWidget {
  const CovidForm({super.key});

  @override
  _CovidFormState createState() => _CovidFormState();
}

class _CovidFormState extends State<CovidForm> {
  bool _hasFever = false;
  bool _hasCough = false;
  bool _hasShortnessOfBreath = false;
  bool _hasSoreThroat = false;
  bool _hasFatigue = false;

  final controller = Get.put(Covid19Controller());
  final repo = Get.put(AuthenticationRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Covid Form',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Please answer the following questions:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              CheckboxListTile(
                title: const Text('Do you have a fever?'),
                value: _hasFever,
                onChanged: (value) {
                  setState(() {
                    _hasFever = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Do you have a cough?'),
                value: _hasCough,
                onChanged: (value) {
                  setState(() {
                    _hasCough = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Do you have shortness of breath?'),
                value: _hasShortnessOfBreath,
                onChanged: (value) {
                  setState(() {
                    _hasShortnessOfBreath = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Do you have a sore throat?'),
                value: _hasSoreThroat,
                onChanged: (value) {
                  setState(() {
                    _hasSoreThroat = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Do you have fatigue?'),
                value: _hasFatigue,
                onChanged: (value) {
                  setState(() {
                    _hasFatigue = value!;
                  });
                },
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Perform validation and submit the form
                    // ...
                    controller.sendCovidForm(
                        repo.userModel.value.email!,
                        _hasFever,
                        _hasCough,
                        _hasShortnessOfBreath,
                        _hasSoreThroat,
                        _hasFatigue);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Feedback sent'),
                        backgroundColor: Colors.amber,
                      ),
                    );
                    Get.back();
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
