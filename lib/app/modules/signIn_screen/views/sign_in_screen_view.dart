import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hi_dokter/app/modules/signIn_screen/views/sign_up_form.dart';

import '../../../data/model/user_model.dart';
import '../../../widget/fade_in_animation/form_header.dart';
import '../controllers/sign_in_screen_controller.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  int _activeStepIndex = 0;
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(SignInScreenController());

  List<Step> stepList() => [
        Step(
            state:
                _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 0,
            title: const Text("Account"),
            content: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, bottom: 20, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: controller.fullname,
                                      decoration: const InputDecoration(
                                        label: Text("Fullname"),
                                        prefixIcon:
                                            Icon(Icons.person_2_outlined),
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Name is required';
                                        }
                                        return null;
                                      }),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: controller.email,
                                      decoration: const InputDecoration(
                                        label: Text("Email"),
                                        prefixIcon: Icon(Icons.email),
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Email is required';
                                        }
                                        return null;
                                      }),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.phone,
                                      controller: controller.phoneNo,
                                      decoration: const InputDecoration(
                                        label: Text("No.Phone"),
                                        hintText: "+628938989",
                                        prefixIcon: Icon(Icons.phone),
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'phoneNo is required';
                                        }
                                        return null;
                                      }),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Obx(() => TextFormField(
                                        controller: controller.password,
                                        obscureText:
                                            controller.obscureText.value,
                                        textInputAction: TextInputAction.next,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Password is required';
                                          } else if (value.length < 7) {
                                            return 'Password must be at least 7 characters long';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                                Icons.password_outlined),
                                            labelText: 'Password',
                                            hintText: 'Password',
                                            border: const OutlineInputBorder(),
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  controller.showPassword();
                                                },
                                                icon: controller
                                                        .obscureText.value
                                                    ? const Icon(
                                                        Icons.visibility_off,
                                                        color: Colors.black,
                                                      )
                                                    : const Icon(
                                                        Icons.visibility,
                                                        color: Colors.black,
                                                      ))),
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Obx(() => TextFormField(
                                        controller: controller.repassword,
                                        obscureText:
                                            controller.obscureText.value,
                                        textInputAction: TextInputAction.done,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Password is required';
                                          } else if (value.length < 7) {
                                            return 'Password must be at least 7 characters long';
                                            // ignore: unrelated_type_equality_checks
                                          } else if (value !=
                                              controller.password.text) {
                                            print(controller.password);
                                            return 'Password do not match';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                                Icons.password_outlined),
                                            labelText: 'Re-Write Password',
                                            hintText: 'Re-Write Password',
                                            border: const OutlineInputBorder(),
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  controller.showPassword();
                                                },
                                                icon: controller
                                                        .obscureText.value
                                                    ? const Icon(
                                                        Icons.visibility_off,
                                                        color: Colors.black,
                                                      )
                                                    : const Icon(
                                                        Icons.visibility,
                                                        color: Colors.black,
                                                      ))),
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              setState(() {
                                                _activeStepIndex += 1;
                                              });
                                              // Get.toNamed(Routes.FORGET_PASSWORD);
                                            }
                                          },
                                          child: const Text("Next")))
                                ],
                              )),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                  text: "Already Have An Account?",
                                  style: Theme.of(context).textTheme.bodySmall),
                              const TextSpan(text: " Login"),
                            ]),
                          ),
                        ),
                        Image(
                          image: const AssetImage("assets/images/logo_ut.png"),
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 1,
            title: const Text("Company"),
            content: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, bottom: 20, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SignUpFormWidget(),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      _activeStepIndex -= 1;
                                    });
                                  },
                                  child: Text("Back")),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    controller.onSubmit();
                                    FocusScope.of(context).unfocus();
                                    if (controller.cek.value) {
                                      setState(() {
                                        _activeStepIndex += 1;
                                      });
                                    }
                                  },
                                  child: Text("Next")),
                            ),
                          ],
                        ),
                        Image(
                          image: const AssetImage("assets/images/logo_ut.png"),
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
        Step(
            state: StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: const Text("Confirm"),
            content: Container(
              padding: const EdgeInsets.only(
                  right: 20, left: 20, bottom: 20, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Make sure your data is correct ",
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Thanks For Filling Data, Hope You Enjoy This App",
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(() => Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    _activeStepIndex -= 1;
                                  });
                                },
                                child: Text("Back")),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  final user = UserModel(
                                      fullName: controller.fullname.text.trim(),
                                      email: controller.email.text.trim(),
                                      phoneNo: controller.phoneNo.text.trim(),
                                      password: controller.password.text.trim(),
                                      createdAt: DateTime.now().toString(),
                                      division: controller.division.text.trim(),
                                      companyName:
                                          controller.company.text.trim(),
                                      photoUrl:
                                          'https://firebasestorage.googleapis.com/v0/b/haidokter-3dce7.appspot.com/o/avatar1.png?alt=media&token=44aee037-9611-466d-85a8-f07b16dac94a',
                                      role: "pasien");

                                  controller.registerUser(user);
                                },
                                child: controller.loading.value
                                    ? const Text("Create Account")
                                    : const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2.0,
                                      )),
                          ),
                        ],
                      ))
                ],
              ),
            ))
      ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Stepper(
          steps: stepList(),
          controlsBuilder: (BuildContext context, ControlsDetails controls) {
            return const SizedBox.shrink();
          },
          currentStep: _activeStepIndex,
          type: StepperType.horizontal,
        ),
      ),
    );
  }
}

class SignUp2 extends StatelessWidget {
  SignUp2({super.key});

  final controller = Get.put(SignInScreenController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            const EdgeInsets.only(right: 20, left: 20, bottom: 20, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const FormHeader(
                  image: "assets/images/logo_hidoc.png",
                  title: "Create your profile to start your journey with us",
                  subtitle: "",
                  cra: CrossAxisAlignment.center,
                  alignText: TextAlign.center,
                ),
                const SignUpFormWidget(),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/step1');
                        },
                        child: Text("Create Account"))),
                TextButton(
                  onPressed: () {},
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                          text: "Already Have An Account?",
                          style: Theme.of(context).textTheme.bodySmall),
                      const TextSpan(text: " Login"),
                    ]),
                  ),
                ),
                Image(
                  image: const AssetImage("assets/images/logo_ut.png"),
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SignInScreenView extends GetView<SignInScreenController> {
  const SignInScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const FormHeader(
              image: "assets/images/logo_hidoc.png",
              title: "Create your profile to start your journey with us",
              subtitle: "",
              cra: CrossAxisAlignment.center,
              alignText: TextAlign.center,
            ),
            Expanded(
              child: WillPopScope(
                onWillPop: () async =>
                    !await navigatorKey.currentState!.maybePop(),
                child: Navigator(
                  key: navigatorKey,
                  onGenerateRoute: (settings) {
                    switch (settings.name) {
                      case '/':
                        return MaterialPageRoute(
                            builder: (context) => const Hal1());

                      case '/step1':
                        return MaterialPageRoute(builder: (context) => Hal2());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Hal1 extends StatelessWidget {
  const Hal1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SignUpFormWidget(),
          TextButton(
            onPressed: () {},
            child: Text.rich(
              TextSpan(children: [
                TextSpan(
                    text: "Already Have An Account?",
                    style: Theme.of(context).textTheme.bodySmall),
                const TextSpan(text: " Login"),
              ]),
            ),
          ),
          Image(
            image: const AssetImage("assets/images/logo_ut.png"),
            height: MediaQuery.of(context).size.height * 0.1,
          ),
        ],
      ),
    );
  }
}

class Hal2 extends StatelessWidget {
  const Hal2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SignUpFormWidget(),
          TextButton(
            onPressed: () {},
            child: Text.rich(
              TextSpan(children: [
                TextSpan(
                    text: "Ini tes ya",
                    style: Theme.of(context).textTheme.bodySmall),
                const TextSpan(text: " Login"),
              ]),
            ),
          ),
          Image(
            image: const AssetImage("assets/images/logo_ut.png"),
            height: MediaQuery.of(context).size.height * 0.1,
          ),
        ],
      ),
    );
  }
}
