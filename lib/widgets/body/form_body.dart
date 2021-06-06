import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pan_out/store.dart';
import 'package:pan_out/theme/constants.dart';
import 'package:pan_out/theme/size_config.dart';
import 'package:pan_out/widgets/card/category_card.dart';
import 'package:pan_out/widgets/button/submit_button.dart';
import 'package:provider/provider.dart';

class FormBody extends StatefulWidget {
  @override
  _FormBodyState createState() => _FormBodyState();
}

class _FormBodyState extends State<FormBody> {
  int activeKey = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: getProportionateScreenWidth(305),
        height: getProportionateScreenHeight(530),
        margin: EdgeInsets.only(top: 12),
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: kGrayColor,
        ),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Center(
                child: GridView.builder(
                    itemCount: 6,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int i) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            activeKey = i;
                            context.read<Store>().setIndex(i);
                          });
                          context
                              .read<Store>()
                              .updateGoal("category", kCategories[i]);
                        },
                        child: CategoryCard(
                          id: i,
                          bgColor: activeKey == i ? kIconColor : kBgColor,
                          iconColor: activeKey == i ? kBgColor : kIconColor,
                          category: kCategories[i],
                          icon: kIcons[i],
                        ),
                      );
                    }),
              ),
            ),
            SizedBox(height: 4),
            Expanded(
              flex: 0,
              child: SubmitButton(
                  text: "Devam Et",
                  route: '/type-form',
                  bgColor: activeKey != -1 ? kSecondaryColor : Colors.grey),
            )
          ],
        ));
  }
}
