// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:workapp/register.dart';
import 'package:workapp/style/app_style.dart';
import 'package:workapp/todo_list.dart';
import 'package:workapp/widget/bottom_bar.dart';
import '../data/data.dart';
import '../size_config.dart';
import 'package:workapp/lab_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal! * 7,
            ),
            child: Column(
              children: const [
                UserInfo(),

                GetBestMedicalService(),
                // User Info Area .

                Services(),


                // GetBestMedicalService
              ],
            ),
          ),
          // Upcoming Appointments
          const UpcomingAppointments(),


        ],

      ),

    );
  }
}

class Services extends StatelessWidget {
  const Services({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Services",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.w700, letterSpacing: 1),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: servicesList
              .map(
                (e) => CupertinoButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              child: Container(
                width: SizeConfig.blockSizeHorizontal! * 17,
                height: SizeConfig.blockSizeHorizontal! * 17,
                decoration: BoxDecoration(
                  color: e.color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: SvgPicture.asset(e.image),
                ),
              ),
            ),
          )
              .toList(),
        ),
      ],
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: const Padding(
        padding: EdgeInsets.only(bottom: 7),
        child: Text("👋 Hello!"),
      ),
      subtitle: Text(
        "Kamal Perera",
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(fontWeight: FontWeight.w700),
      ),
      trailing: Container(
        width: 48.0,
        height: 48.0,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppStyle.profile),
            fit: BoxFit.cover,
            repeat: ImageRepeat.repeat,
          ),
          borderRadius: BorderRadius.all(Radius.circular(18.0)),
        ),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: 18.0,
              height: 18.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppStyle.primarySwatch,
                border: Border.all(
                  color: Colors.white,
                  width: 3.0,
                  style: BorderStyle.solid,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GetBestMedicalService extends StatelessWidget {
  const GetBestMedicalService({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding:
      EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical! * 3.5),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 199, 230, 252),
              borderRadius: BorderRadius.all(Radius.circular(28.0)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal! * 6,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Get the Best\nMedical Service",
                          style:
                          Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(height: SizeConfig.blockSizeVertical! * 1),
                        Text(
                          "Lorem Ipsum is simply dummy\ntext of the printing",
                          style:
                          Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1,
                            fontSize: 11.0,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                    EdgeInsets.only(top: SizeConfig.blockSizeVertical! * 2),
                    child: Image.asset(AppStyle.image1),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UpcomingAppointments extends StatelessWidget {
  const UpcomingAppointments({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal! * 7,
              vertical: SizeConfig.blockSizeVertical! * 2),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal! * 7,
          ),
          child: Text(
            "Upcoming Appointments",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w700, letterSpacing: 1),
          ),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical! * 2),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(left: 28),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TodoListPage(), // Replace ToDoListScreen with your screen
                      ),
                    );
                    // Add functionality for the Assignment button
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // Change button color here
                    minimumSize: Size(
                      MediaQuery.of(context).size.width *
                          0.4, // Set button width to 30% of screen width
                      MediaQuery.of(context).size.height *
                          0.2, // Set button height to 6% of screen height
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(15), // Set border radius here
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'ASSIGNMENTS',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                          height: 8), // Space between 'Laboratory' and 'Hai'
                      Text(
                        '12/4',
                        style: TextStyle(
                          fontSize: 18, // Font size of 'Hai'
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                        builder: (context) => LabListPage(),
                    ),);
                    // Add functionality for the Laboratory button
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Change button color here
                    minimumSize: Size(
                      MediaQuery.of(context).size.width *
                          0.4, // Set button width to 30% of screen width
                      MediaQuery.of(context).size.height *
                          0.2, // Set button height to 6% of screen height
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(15), // Set border radius here
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'LABOROTERY',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                          height: 8), // Space between 'Laboratory' and 'Hai'
                      Text(
                        '4/2',
                        style: TextStyle(
                          fontSize: 18, // Font size of 'Hai'
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
