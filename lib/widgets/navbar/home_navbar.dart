import 'package:flutter/material.dart';
import 'package:pan_out/theme/constants.dart';
import 'package:pan_out/theme/size_config.dart';

class HomeNavbar extends StatelessWidget {
  const HomeNavbar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(145),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
        color: kPrimaryColor,
      ),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: kBgColor,
        ),
        child: Row(
          children: [
            Image.asset(
              "assets/images/avatar.jpg",
              width: 130,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Rıfkı", style: TextStyle(color: Colors.white)),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    height: getProportionateScreenHeight(20),
                    width: getProportionateScreenWidth(171),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: kGreenColor,
                    ),
                    child: Text("100%", style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    height: getProportionateScreenHeight(20),
                    width: getProportionateScreenWidth(171),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: kGreenColor,
                    ),
                    child: Text("100%", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
