import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum SvgImagePath {
  signinlogo,
  signuplogo,
  googleicon,
  networkerror,
  usernot,
  fillinput,
  emailerror,
  pagenot,
  samemail
  
  
}

extension SvgImagePathExtension on SvgImagePath {
  String toPath() {
    return 'assets/Svg/svg_$name.svg';
  }

  SvgPicture toIcon() {
    return SvgPicture.asset(
      color: Colors.white,
      toPath(),
      height: 20,
    );
  }

  SvgPicture toDialogImage() {
    return SvgPicture.asset(
      toPath(),
      height: 120,
    );
  }

  SvgPicture toImage() {
    return SvgPicture.asset(
      toPath(),
      height: 200,
    );
  }
}
