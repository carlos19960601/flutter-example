import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:office_furniture_store_app/core/app_extension.dart';
import 'package:office_furniture_store_app/core/app_style.dart';
import 'package:office_furniture_store_app/models/furniture.dart';
import 'package:office_furniture_store_app/widgets/rating_bar.dart';

class FurnitureListView extends StatelessWidget {
  final bool isHorizontal;
  final List<Furniture> furnitureList;
  final Function(Furniture furniture)? onTap;

  const FurnitureListView({
    super.key,
    this.isHorizontal = true,
    required this.furnitureList,
    this.onTap,
  });

  Widget _furnitureImage(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Image.asset(image, width: 150, height: 150),
    ).fadeAnimation(0.4);
  }

  Widget _furnitureScore(Furniture furniture) {
    return Row(
      children: [
        StarRatingBar(score: furniture.score),
        const SizedBox(width: 10),
        Text(furniture.score.toString(), style: h4Style),
      ],
    ).fadeAnimation(1.0);
  }

  Widget _listViewItem(Furniture furniture, int index) {
    Widget widget = isHorizontal
        ? Column(
            children: [
              _furnitureImage(furniture.images[0]),
              const SizedBox(height: 10),
              Text(
                furniture.title.addOverFlow,
                style: h4Style,
              ).fadeAnimation(0.8),
              _furnitureScore(furniture),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _furnitureImage(furniture.images[0]),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(furniture.title, style: h4Style).fadeAnimation(0.8),
                      const SizedBox(height: 5),
                      _furnitureScore(furniture),
                      const SizedBox(height: 5),
                      Text(
                        furniture.description,
                        style: h5Style.copyWith(fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ).fadeAnimation(1.4)
                    ],
                  ),
                ),
              ),
            ],
          );
    return GestureDetector(
      onTap: () => onTap?.call(furniture),
      child: widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return isHorizontal
        ? SizedBox(
            height: 220,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                Furniture furniture = furnitureList[index];
                return _listViewItem(furniture, index);
              },
              separatorBuilder: (context, index) {
                return const Padding(padding: EdgeInsets.only(left: 15));
              },
              itemCount: furnitureList.length,
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            reverse: true,
            physics: const ClampingScrollPhysics(),
            itemCount: furnitureList.length,
            itemBuilder: (context, index) {
              Furniture furniture = furnitureList[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 15, top: 10),
                child: _listViewItem(furniture, index),
              );
            },
          );
  }
}
