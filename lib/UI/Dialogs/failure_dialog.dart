import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartal/kartal.dart';

import '../../Components/Constants/colors.dart';

void showFailureDialog(BuildContext context, state) {
  showDialog(
    routeSettings: const RouteSettings(),
    useRootNavigator: true,
    barrierDismissible: false,
    barrierColor: const Color.fromARGB(221, 6, 5, 5),
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 243, 241, 241),
        title: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SvgPicture.asset(
                state.image!,
                height: 120,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              state.message,
              style: const TextStyle(color: AppColor.signInBackColor, fontSize: 18),
            ),
            const SizedBox(
              height: 12,
            ),
            InkWell(
              onTap: () {
                context.route.pop();
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColor.buttonColor,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text('Cancel'),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}
