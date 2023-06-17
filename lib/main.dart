import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateProvider((ref) => 'default');

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        print("trigger");
        if (user == null) {
          ref.read(userProvider.notifier).state = 'Logged Out';
        } else {
          ref.read(userProvider.notifier).state = user.email ?? 'Logged Out';
        }
      }
    );

    return MaterialApp(
      title: 'RBA Events',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'RBA Events'),
    );
  }

}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  Future<UserCredential> signInWithGoogle() async {
      if (kIsWeb){
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        return await FirebaseAuth.instance.signInWithPopup(googleProvider);
      }
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String value = ref.watch(userProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(title),
            Text(
              value,
              style: const TextStyle(fontSize: 24),
            ),
            const UserListScreen(),
          ],
        ),
      ),
      floatingActionButton:  Wrap(
        direction: Axis.horizontal,
        children: [
          FloatingActionButton(
            onPressed: signInWithGoogle,
            tooltip: 'Log In',
            child: Icon(Icons.login),
          ),
          FloatingActionButton(
            onPressed: () => ref.read(userProvider.notifier).state = 'some value',
            tooltip: 'Log Out',
            child: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}

// class _MyHomePageState extends State<MyHomePage> {
//   User? _user;

//   @override
//   void initState() {
//     super.initState();
//     FirebaseAuth.instance.authStateChanges().listen((User? user) {
//       setState(() {
//         _user = user;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(widget.title),
//             Text(
//               _user != null ? 'Logged in as: ${_user!.email}' : 'Logged out',
//               style: const TextStyle(fontSize: 24),
//             ),
//             const UserListScreen(),
//           ],
//         ),
//       ),
//       floatingActionButton: const FloatingActionButton(
//         onPressed: signInWithGoogle,
//         tooltip: 'Increment',
//         child: Icon(Icons.check),
//       ),
//     );
//   }
// }

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if(!snapshot.hasData){
          return const CircularProgressIndicator();
        }

        final userList = snapshot.data?.docs ?? [];
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: userList.length,
          itemBuilder: (BuildContext context, int index) {
            final userData = userList[index].data() ?? {};
            final name = (userData as Map)['name'];
            return ListTile(
              title: Text(name ?? ''),
            );
          },
        );
      },
    );
  }
}