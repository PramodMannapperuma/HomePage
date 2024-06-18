import 'package:flutter/material.dart';
import 'package:untitled/app_colors.dart';

class UserSection extends StatelessWidget {
  const UserSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 500,
        height: MediaQuery.of(context).size.height * 0.18,
        decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.background,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12)),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // CircleAvatar(
                  //   backgroundImage: AssetImage(
                  //       'assets/images/user.jpg'), // replace with your image asset
                  //   radius: 30,
                  // ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Hello Demon ',
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.waving_hand,
                            size: 35,
                            color: Colors.yellow,
                          ),
                        ],
                      ),
                      Text(
                        'Welcome Back to work ,',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      Text(
                        'Last login: 2024/06/03',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
