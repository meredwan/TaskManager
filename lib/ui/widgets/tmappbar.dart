

import 'package:flutter/material.dart';
import 'package:task_manager/ui/screen/sing_in_screen.dart';

import '../utils/appcolors.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget{
   TMAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.ThemeColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
          ),
          Expanded(
            child: ListTile(
              title: Text(
                "Redwan Islam",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
              subtitle: Text(
                "me.redwanislam@gmail.com",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          IconButton(onPressed: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SingInScreen(),), (route) => false);
          }, icon: Icon(Icons.logout))
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);


}


