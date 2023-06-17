import 'package:bijan_i/pages/home_page.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD

import '../services/firebase_auth_helper.dart';
=======
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../providers/fakeuser.dart';
>>>>>>> abc7cfe (hehe)

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/wavy_background.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Login",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w200,
                        fontSize: 100,
                      ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
<<<<<<< HEAD
                InkWell(
                  onTap: () async {
                    await FirebaseAuthHelper.signInWithGoogle();
                    Navigator.of(context).popAndPushNamed('/main');
                  },
                  child: Ink(
                    color: const Color(0xFF397AF3),
                    child: const Padding(
                      padding: EdgeInsets.all(6),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
=======
                Spacer(),
                //need to add Sized boxes for this more buttons.
                Consumer(builder: (context, ref, child) {
                  return OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        width: 2,
                        color: Theme.of(context).primaryColor,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () {
                      ref.read(userProvider.notifier).state = 'not default';
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HomePage(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
>>>>>>> abc7cfe (hehe)
                        children: [
                          FaIcon(FontAwesomeIcons.google),
                          SizedBox(width: 15),
                          Text(
                            "Login with Google",
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontSize: 25,
                                      color: Theme.of(context).primaryColor,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                Spacer(),
              ],
            ),
          )
        ],
      ),
    );
  }
}


//void main() {
//  runApp(
//    ProviderScope(
//      child: MaterialApp(
//        debugShowCheckedModeBanner: false,
//        home: StartPage(),
//        // routes: ,
//        theme: ThemeData.from(
//          colorScheme: ColorScheme.fromSeed(
//            seedColor: Color.fromRGBO(8, 103, 136, 1),
//            background: Color.fromRGBO(255, 241, 208, 1),
//            secondary: Color.fromRGBO(240, 200, 8, 1),
//            primary: Color.fromRGBO(8, 103, 136, 1),
//            tertiary: Color.fromRGBO(6, 174, 213, 1),
//            error: Color.fromRGBO(221, 28, 26, 1),
//          ),
//        ),
//      ),
//    ),
//  );
//}
