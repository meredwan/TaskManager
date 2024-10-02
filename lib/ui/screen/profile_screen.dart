import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/tmappbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(
        isProfileScreenOpen: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 48,
              ),
              Text(
                "update Profile",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              _buildPhotoPicker(),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Email"),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "First Name"),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Last Name"),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Phone"),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Password"),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(onPressed: () {
                
              }, child: Icon(Icons.arrow_circle_right_outlined))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoPicker() => Container(
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              child: Text(

                "Photos",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 10,),
            Text("Photos")
          ],
        ),
      );
}
