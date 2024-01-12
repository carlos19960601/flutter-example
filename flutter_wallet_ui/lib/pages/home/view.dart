import 'package:flutter/material.dart';
import 'package:flutter_wallet_ui/models/credit_card_model.dart';
import 'package:flutter_wallet_ui/models/payment_model.dart';
import 'package:flutter_wallet_ui/models/user_model.dart';
import 'package:flutter_wallet_ui/routes/appp_routes.dart';
import 'package:flutter_wallet_ui/widgets/add_button.dart';
import 'package:flutter_wallet_ui/widgets/credit_card.dart';
import 'package:flutter_wallet_ui/widgets/payment_card.dart';
import 'package:flutter_wallet_ui/widgets/user_card.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            color: Colors.grey.shade50,
            height: Get.mediaQuery.size.height / 2,
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Stack(
                        children: [
                          Material(
                            elevation: 4,
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/bg1.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Opacity(
                            opacity: 0.3,
                            child: Container(
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(flex: 1, child: Container()),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                    ),
                    width: Get.mediaQuery.size.width,
                    height: Get.mediaQuery.size.longestSide <= 755
                        ? Get.mediaQuery.size.height / 4
                        : Get.mediaQuery.size.height / 4.3,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: creditCards.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: ()=>Get.toNamed(AppRoutes.overview),
                            child: CreditCard(
                              card: creditCards[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                    top: Get.mediaQuery.size.longestSide <= 775 ? 20 : 35,
                    left: 10,
                    right: 10,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.menu,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.notifications_none,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Wallet",
                                style: TextStyle(
                                  fontSize:
                                      Get.mediaQuery.size.longestSide <= 775
                                          ? 35
                                          : 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 36,
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
              ],
            ),
          ),
          Container(
            color: Colors.grey.shade50,
            width: Get.mediaQuery.size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                      left: 25.0, right: 10, bottom: 20, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Send Money",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 25),
                  height: 110,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: userCards.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: AddButton(),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: UserCardWidget(
                          user: userCards[index - 1],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          const Padding(
            padding:
                EdgeInsets.only(left: 25.0, bottom: 15, right: 10, top: 40),
            child: Row(
              children: [
                Text(
                  "All",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Received",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Sent",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 20,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 25.0,
              bottom: 15,
              top: 15,
            ),
            child: Text(
              "23 july 2019",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return PaymentCard(payment: paymentCards[index]);
                },
                separatorBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(left: 85.0),
                    child: Divider(),
                  );
                },
                padding: EdgeInsets.zero,
                itemCount: paymentCards.length,
              )
            ],
          ),
        ],
      ),
    );
  }
}
