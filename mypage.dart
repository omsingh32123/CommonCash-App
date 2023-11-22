import 'package:flutter/services.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int balance = 0;
  int amount = 0;
  String smt = "";
  String note = "";
  int tamount = 0;
  @override
  Widget build(BuildContext context) {
    double sheight = MediaQuery.of(context).size.height;
    refreshamount();
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Common Cash",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFFE7ECEF),
          foregroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Container(
            color: const Color(0xFFE7ECEF),
            child: Column(children: <Widget>[
              Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
                width: 500,
                decoration: BoxDecoration(
                    color: const Color(0xFFE7ECEF),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        inset: true,
                        color: Colors.white,
                        offset: Offset(-3, -3),
                        blurRadius: 5,
                      ),
                      BoxShadow(
                        inset: true,
                        color: Color(0xFFA7A9AF),
                        offset: Offset(3, 3),
                        blurRadius: 3,
                      )
                    ]),
                child: Center(
                    child: Column(
                  children: [
                    Text(
                      "₹$balance",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: AutofillHints.birthday),
                    ),
                  ],
                )),
              ),
              const SizedBox(
                height: 70,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      smt = value;
                    });
                    print(smt);
                  },
                  maxLength: 6,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 24, 24, 24), width: 1.0),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 154, 154, 154),
                          width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: "Enter Amount",
                    labelStyle: const TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      note = value;
                    });
                    print(note);
                  },
                  maxLength: 16,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 24, 24, 24), width: 1.0),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 154, 154, 154),
                          width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: "Enter Note",
                    labelStyle: const TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      if (smt.isNotEmpty && note.isNotEmpty) {
                        amount = int.parse(smt);
                        print("ADD CALLING $amount = $note");
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc('11111')
                            .get()
                            .then((value) {
                          setState(() {
                            tamount = value['amount'];
                          });
                          add(amount, note, tamount);
                          Fluttertoast.showToast(
                            msg: 'Money Added',
                            toastLength: Toast.LENGTH_SHORT, // Toast.LENGTH_SHORT or Toast.LENGTH_LONG
                            gravity: ToastGravity.BOTTOM, // ToastGravity.TOP, ToastGravity.CENTER
                            timeInSecForIosWeb: 1, // Time duration (in seconds) for iOS and web
                            backgroundColor: Colors.grey, // Background color of the toast
                            textColor: Colors.white, // Text color of the toast
                            fontSize: 16.0, // Font size of the text
                          );
                          print("Amount Fetched !");
                        }).onError((error, stackTrace) {});
                      }
                      else
                      {
                        Fluttertoast.showToast(
                          msg: 'Fields are empty',
                          toastLength: Toast.LENGTH_SHORT, // Toast.LENGTH_SHORT or Toast.LENGTH_LONG
                          gravity: ToastGravity.BOTTOM, // ToastGravity.TOP, ToastGravity.CENTER
                          timeInSecForIosWeb: 1, // Time duration (in seconds) for iOS and web
                          backgroundColor: Colors.grey, // Background color of the toast
                          textColor: Colors.white, // Text color of the toast
                          fontSize: 16.0, // Font size of the text
                        );
                      }
                    },
                    child: const Icon(
                      Icons.add_circle,
                      size: 70,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (smt.isNotEmpty && note.isNotEmpty) {
                        amount = int.parse(smt);
                        print("DEDUCT CALLING $amount = $note");
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc('11111')
                            .get()
                            .then((value) {
                          setState(() {
                            tamount = value['amount'];
                          });
                          deduct(amount, note, tamount);
                          Fluttertoast.showToast(
                            msg: 'Money Deducted',
                            toastLength: Toast.LENGTH_SHORT, // Toast.LENGTH_SHORT or Toast.LENGTH_LONG
                            gravity: ToastGravity.BOTTOM, // ToastGravity.TOP, ToastGravity.CENTER
                            timeInSecForIosWeb: 1, // Time duration (in seconds) for iOS and web
                            backgroundColor: Colors.grey, // Background color of the toast
                            textColor: Colors.white, // Text color of the toast
                            fontSize: 16.0, // Font size of the text
                          );
                          print("Amount Fetched !");
                        }).onError((error, stackTrace) {});
                      }
                      else
                      {
                        Fluttertoast.showToast(
                          msg: 'Fields are empty',
                          toastLength: Toast.LENGTH_SHORT, // Toast.LENGTH_SHORT or Toast.LENGTH_LONG
                          gravity: ToastGravity.BOTTOM, // ToastGravity.TOP, ToastGravity.CENTER
                          timeInSecForIosWeb: 1, // Time duration (in seconds) for iOS and web
                          backgroundColor: Colors.grey, // Background color of the toast
                          textColor: Colors.white, // Text color of the toast
                          fontSize: 16.0, // Font size of the text
                        );
                      }
                    },
                    child: const Icon(
                      Icons.do_disturb_on_rounded,
                      size: 70,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 45,
              ),
              const Center(
                child: Text(
                  "Payment History",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
              const Center(
                child: Icon(
                  Icons.arrow_drop_down,
                  size: 37,
                ),
              ),
              Container(
                height: 400,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .snapshots(),
                    builder: (context, snapshot) {
                      // if (snapshot.connectionState == ConnectionState.waiting) {
                      //   return CircularProgressIndicator(); // Display a loading indicator while data is loading.
                      // }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (!snapshot.hasData) {
                        return const Text(
                            'No data available'); // Handle the case when there's no data.
                      }
                      final documents = snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          int n = documents.length;
                          final documentData = documents[n - 1 - index].data();
                          if (documentData['note'] != '1efhg3i82137fhd') {
                            return ListTile(
                              title: Card(
                                elevation: 10,
                                child: Container(
                                    width: double.infinity,
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 8, 20, 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color:
                                          const Color.fromARGB(255, 51, 48, 59),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${documentData['note']}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              (documentData['sign'] == 0)
                                                  ? "-${documentData['amount']}"
                                                  : "+${documentData['amount']}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${documentData['date'].substring(0, 11)}, ${documentData['date'].substring(11, 19)}",
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 191, 191, 191),
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              "${documentData['balance']}",
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 191, 191, 191),
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              ),
                            );
                          } else {
                            return Text("");
                          }
                        },
                      );
                    }),
              ),
            ]),
          ),
        ));
  }

  deduct(int amount, String note, int tamount) {
    print("DEDUCT CALLED $amount = $note");
    DateTime date = DateTime.now();
    FirebaseFirestore.instance
        .collection('users')
        .doc('11111')
        .get()
        .then((value) {
      setState(() {
        tamount = value['amount'];
      });
      print("Amount Fetched !");
    }).onError((error, stackTrace) {});
    FirebaseFirestore.instance.collection('users').doc('11111').set({
      'amount': tamount - amount,
      'note': '1efhg3i82137fhd',
    }).then((value) async {
      print("summed");
    }).onError((error, stackTrace) {});
    FirebaseFirestore.instance.collection('users').doc(date.toString()).set({
      'amount': amount,
      'note': note,
      'balance': tamount - amount,
      'date': date.toString(),
      'sign': 0,
    }).then((value) async {
      print("added history");
    }).onError((error, stackTrace) {});
    refreshamount();
  }

  add(int amount, String note, int tamount) {
    print("ADD CALLED $amount = $note");
    DateTime date = DateTime.now();
    FirebaseFirestore.instance
        .collection('users')
        .doc('11111')
        .get()
        .then((value) {
      setState(() {
        tamount = value['amount'];
      });
      print("Amount Fetched ! $tamount");
    }).onError((error, stackTrace) {});
    FirebaseFirestore.instance.collection('users').doc('11111').set({
      'amount': tamount + amount,
      'note': '1efhg3i82137fhd',
    }).then((value) async {
      print("summed");
    }).onError((error, stackTrace) {});
    FirebaseFirestore.instance.collection('users').doc(date.toString()).set({
      'amount': amount,
      'note': note,
      'balance': tamount + amount,
      'date': date.toString(),
      'sign': 1,
    }).then((value) async {
      print("added history");
    }).onError((error, stackTrace) {});
    refreshamount();
  }

  refreshamount() {
    FirebaseFirestore.instance
        .collection('users')
        .doc('11111')
        .get()
        .then((value) {
      setState(() {
        balance = value['amount'];
      });
      print("Amount Fetched !");
    }).onError((error, stackTrace) {});
  }
}
