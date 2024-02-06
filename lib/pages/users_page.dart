import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thai_stock_live/controllers/home_controller.dart';

class UsersPage extends GetView<HomeController> {
  UsersPage({super.key}) {
    controller.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
              onPressed: () {
                _displayUserDialog(context);
              },
              icon: const Icon(Icons.person_add))
        ],
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.users.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  controller.deleteUser(controller.users[index].id);
                  controller.fetchUsers();
                },
              ),
              title: Text(controller.users[index].userName),
              subtitle: Text(
                  controller.users[index].isAdmin == true ? "Admin" : "User"),
            );
          },
        );
      }),
    );
  }

  Future<void> _displayUserDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add New User'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) {
                      controller.setNewUserName(value);
                    },
                    decoration: const InputDecoration(hintText: "User Name"),
                  ),
                  TextFormField(
                    obscureText: true,
                    onChanged: (value) {
                      controller.setNewPassword(value);
                    },
                    decoration: const InputDecoration(hintText: "Password"),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                child: const Text('CANCEL'),
                onPressed: () {
                  Get.back();
                },
              ),
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('OK'),
                onPressed: () {
                  controller.addNewUser(
                      controller.newUserName, controller.newPassword);
                  controller.fetchUsers();
                  Get.back();
                },
              ),
            ],
          );
        });
  }
}
