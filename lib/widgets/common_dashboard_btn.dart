import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:traslater_sri/utils/colors.dart';

class CommonDashboardButton extends StatelessWidget {
  const CommonDashboardButton({
    super.key,
    required this.icon,
    required this.discription,
    required this.onTap,
  });

  final Widget icon;
  final String discription;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InkWell(
        onTap: onTap,
        child: Center(
            child: Container(
          width: MediaQuery.of(context).size.width / 4,
          height: MediaQuery.of(context).size.height / 7,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.elliptical(10, 10),
              ),
              color: Colors.white60),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                Text("${discription}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            //  Icon(
            //   FontAwesomeIcons.cameraRetro,
            //   size: 45,
            //   color: kDefTextColor,
            // ),
          ),
        )),
      ),
    );
  }
}
