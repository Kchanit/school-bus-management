import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: const TextStyle(color: Colors.black),
          iconTheme: const IconThemeData(color: Colors.black),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.close)),
          actions: [
            IconButton(
                onPressed: () {
                  showAlertDialog(context);
                },
                icon: const Icon(Icons.delete_forever_rounded))
          ],
          centerTitle: true,
        ),
/** notification box */
        body: _notiBox());
  }
}

Widget _notiBox() {
  return InkWell(
    onTap: () => Get.back(),
    child: Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      color: Colors.amber,
      child: const Wrap(spacing: 30, children: [
        Icon(Icons.mail_rounded),
        Wrap(
          direction: Axis.vertical,
          children: [
            Text('Your Child has arrived in the bus.'),
            Text('23 Oct 2023 14.15')
          ],
        )
      ]),
    ),
  );
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = ElevatedButton(
    child: const Text("Cancel"),
    onPressed: () {},
  );
  Widget continueButton = ElevatedButton(
    child: const Text("Delete"),
    onPressed: () {},
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Delete all messages"),
    content: const Text("Once deleted, you won't be able to access it."),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}