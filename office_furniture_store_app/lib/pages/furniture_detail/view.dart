import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:office_furniture_store_app/core/app_extension.dart';
import 'package:office_furniture_store_app/core/app_style.dart';
import 'package:office_furniture_store_app/models/furniture.dart';
import 'package:office_furniture_store_app/pages/home/controller.dart';
import 'package:office_furniture_store_app/widgets/rating_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OfficeFurnitureDetailScreen extends StatefulWidget {
  final Furniture furniture;

  const OfficeFurnitureDetailScreen({
    super.key,
    required this.furniture,
  });

  @override
  State<OfficeFurnitureDetailScreen> createState() =>
      _OfficeFurnitureDetailScreenState();
}

class _OfficeFurnitureDetailScreenState
    extends State<OfficeFurnitureDetailScreen> {
  OfficeFurnitureController controller = Get.find<OfficeFurnitureController>();

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          splashRadius: 18.0,
          onPressed: () {},
          icon: widget.furniture.isFavorite
              ? const Icon(Icons.bookmark, color: Colors.black)
              : const Icon(Icons.bookmark_border, color: Colors.black),
        ),
      ],
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(FontAwesomeIcons.arrowLeft, color: Colors.black),
      ),
      title: Text(widget.furniture.title, style: h2Style),
    );
  }

  Widget furnitureImageSlider(double height) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
      height: height * 0.5,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            itemCount: widget.furniture.images.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Hero(
                    tag: index,
                    child: Image.asset(
                      widget.furniture.images[index],
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 20,
            child: Obx(
              () => AnimatedSmoothIndicator(
                effect: const WormEffect(
                  dotColor: Colors.white38,
                  activeDotColor: Colors.white,
                ),
                activeIndex: controller.currentPageViewItemIndicator.value,
                count: widget.furniture.images.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              furnitureImageSlider(height),
              Center(
                child: StarRatingBar(
                  score: widget.furniture.score,
                  itemSize: 25,
                ).fadeAnimation(0.4),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: const Text(
                  "Synopsis",
                  style: h2Style,
                  textAlign: TextAlign.end,
                ).fadeAnimation(0.6),
              ),
              Text(
                widget.furniture.description,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black45),
              ).fadeAnimation(0.8),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    "Color :",
                    style: h2Style,
                    textAlign: TextAlign.end,
                  ),
                ],
              ).fadeAnimation(1.0)
            ],
          ),
        ),
      ),
    );
  }
}
