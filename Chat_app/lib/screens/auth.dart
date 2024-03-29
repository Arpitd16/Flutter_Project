import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/widgets/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firebase = FirebaseAuth.instance;

class Authscreen extends StatefulWidget {
  const Authscreen({super.key});

  @override
  State<Authscreen> createState() {
    return _Authscreen();
  }
}

class _Authscreen extends State<Authscreen> {
  final _form = GlobalKey<FormState>();

  var _isloging = true;
  var _useremail = '';
  var _userpassword = '';
  var _username = '';
  File? _slectedimg;
  var _isAuth = false;

  void _submitform() async {
    final isvalid = _form.currentState!.validate();

    if (!isvalid || !_isloging && _slectedimg == null) {
      return;
    }
    _form.currentState!.save();

    try {
      setState(() {
        _isAuth = true;
      });
      if (_isloging) {
        final usercreadential = await _firebase.signInWithEmailAndPassword(
          email: _useremail,
          password: _userpassword,
        );
      } else {
        final usercreadential = await _firebase.createUserWithEmailAndPassword(
          email: _useremail,
          password: _userpassword,
        );

        final storageref = FirebaseStorage.instance
            .ref()
            .child('userimage')
            .child('${usercreadential.user!.uid}.jpg');

        await storageref.putFile(_slectedimg!);
        final imageurl = await storageref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(usercreadential.user!.uid)
            .set({
          'username': _username,
          'email': _useremail,
          'image_url': imageurl
        });
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        //an error
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'An error occurred'),
        ),
      );
      setState(() {
        _isAuth = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 30,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              width: 200,
              child: Image.asset('assets/images/chat.png'),
            ),
            Card(
              margin: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _form,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!_isloging)
                          Userimagepicker(
                            onpickimg: (pickedimage) {
                              _slectedimg = pickedimage;
                            },
                          ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Email address'),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains('@')) {
                              return 'Please enter valid email!';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _useremail = value!;
                          },
                        ),
                        if (!_isloging)
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Username'),
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  value.trim().length < 4) {
                                return 'please enter at least 4 word in username';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _username = value!;
                            },
                          ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.trim().length < 6) {
                              return 'please enter more than 6 word in password';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _userpassword = value!;
                          },
                        ),
                        const SizedBox(height: 12),
                        if (_isAuth) CircularProgressIndicator(),
                        if (!_isAuth)
                          ElevatedButton(
                            onPressed: _submitform,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                            child: Text(_isloging ? 'Login' : 'Signup'),
                          ),
                        if (!_isAuth)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isloging = !_isloging;
                              });
                            },
                            child: Text(_isloging
                                ? 'Create new account'
                                : 'I already have an account'),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
