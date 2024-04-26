import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pilipala/pages/rank/zone/controller.dart';
import 'package:pilipala/pages/rank/zone/view.dart';

enum RandType {
  all,
  creation,
  animation,
  music,
  dance,
  game,
  knowledge,
  technology,
  sport,
  car,
  life,
  food,
  animal,
  madness,
  fashion,
  entertainment,
  film,
  origin,
  rookie
}

extension RankTypeDesc on RandType {
  String get description => [
        '全站',
        '国创相关',
        '动画',
        '音乐',
        '舞蹈',
        '游戏',
        '知识',
        '科技',
        '运动',
        '汽车',
        '生活',
        '美食',
        '动物圈',
        '鬼畜',
        '时尚',
        '娱乐',
        '影视'
      ][index];

  String get id => [
        'all',
        'creation',
        'animation',
        'music',
        'dance',
        'game',
        'knowledge',
        'technology',
        'sport',
        'car',
        'life',
        'food',
        'animal',
        'madness',
        'fashion',
        'entertainment',
        'film'
      ][index];
}

List tabsConfig = [
  {
    "icon": const Icon(
      Icons.live_tv_outlined,
      size: 15,
    ),
    'label': '全站',
    'type': RandType.all,
    'ctr': Get.put<ZoneController>,
    'page': const ZonePage(rid: 0),
  },
  {
    'icon': const Icon(
      Icons.live_tv_outlined,
      size: 15,
    ),
    'label': '国创相关',
    'type': RandType.creation,
    'ctr': Get.put<ZoneController>,
    'page': const ZonePage(rid: 168),
  },
  {
    'icon': const Icon(
      Icons.live_tv_outlined,
      size: 15,
    ),
    'label': '动画',
    'type': RandType.animation,
    'ctr': Get.put<ZoneController>,
    'page': const ZonePage(rid: 1),
  },
  {
    'icon': const Icon(
      Icons.live_tv_outlined,
      size: 15,
    ),
    'label': '音乐',
    'type': RandType.music,
    'ctr': Get.put<ZoneController>,
    'page': const ZonePage(rid: 3),
  },
  {
    'icon': const Icon(
      Icons.live_tv_outlined,
      size: 15,
    ),
    'label': '舞蹈',
    'type': RandType.dance,
    'ctr': Get.put<ZoneController>,
    'page': const ZonePage(rid: 129),
  },
  {
    'icon': const Icon(
      Icons.live_tv_outlined,
      size: 15,
    ),
    'label': '游戏',
    'type': RandType.game,
    'ctr': Get.put<ZoneController>,
    'page': const ZonePage(rid: 4),
  },
  {
    'icon': const Icon(
      Icons.live_tv_outlined,
      size: 15,
    ),
    'label': '知识',
    'type': RandType.knowledge,
    'ctr': Get.put<ZoneController>,
    'page': const ZonePage(rid: 36),
  },
  {
    'icon': const Icon(
      Icons.live_tv_outlined,
      size: 15,
    ),
    'label': '科技',
    'type': RandType.technology,
    'ctr': Get.put<ZoneController>,
    'page': const ZonePage(rid: 188),
  },
  {
    'icon': const Icon(
      Icons.live_tv_outlined,
      size: 15,
    ),
    'label': '运动',
    'type': RandType.sport,
    'ctr': Get.put<ZoneController>,
    'page': const ZonePage(rid: 234),
  },
  {
    'icon': const Icon(
      Icons.live_tv_outlined,
      size: 15,
    ),
    'label': '汽车',
    'type': RandType.car,
    'ctr': Get.put<ZoneController>,
    'page': const ZonePage(rid: 223),
  },
  {
    'icon': const Icon(
      Icons.live_tv_outlined,
      size: 15,
    ),
    'label': '生活',
    'type': RandType.life,
    'ctr': Get.put<ZoneController>,
    'page': const ZonePage(rid: 160),
  },
  {
    'icon': const Icon(
      Icons.live_tv_outlined,
      size: 15,
    ),
    'label': '美食',
    'type': RandType.food,
    'ctr': Get.put<ZoneController>,
    'page': const ZonePage(rid: 211),
  },
  {
    'icon': const Icon(
      Icons.live_tv_outlined,
      size: 15,
    ),
    'label': '动物圈',
    'type': RandType.animal,
    'ctr': Get.put<ZoneController>,
    'page': const ZonePage(rid: 217),
  },
  {
    'icon': const Icon(
      Icons.live_tv_outlined,
      size: 15,
    ),
    'label': '鬼畜',
    'type': RandType.madness,
    'ctr': Get.put<ZoneController>,
    'page': const ZonePage(rid: 119),
  },
  {
    'icon': const Icon(
      Icons.live_tv_outlined,
      size: 15,
    ),
    'label': '时尚',
    'type': RandType.fashion,
    'ctr': Get.put<ZoneController>,
    'page': const ZonePage(rid: 155),
  },
  {
    'icon': const Icon(
      Icons.live_tv_outlined,
      size: 15,
    ),
    'label': '娱乐',
    'type': RandType.entertainment,
    'ctr': Get.put<ZoneController>,
    'page': const ZonePage(rid: 5),
  },
  {
    'icon': const Icon(
      Icons.live_tv_outlined,
      size: 15,
    ),
    'label': '影视',
    'type': RandType.film,
    'ctr': Get.put<ZoneController>,
    'page': const ZonePage(rid: 181),
  }
];
