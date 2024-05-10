import 'package:v2ex/models/tabs.dart';

class Strings {
  static String v2exHost = "https://www.v2ex.com";

  static List<TabModel> tabs = [
    TabModel('最近', 'recent', 'recent', true),
    TabModel('最新', 'changes', 'changes', true),
    TabModel('全部', 'all', 'tab', true),
    TabModel('最热', 'hot', 'tab', true),
    TabModel('技术', 'tech', 'tab', true),
    TabModel('创意', 'creative', 'tab', true),
    TabModel('好玩', 'play', 'tab', true),
    TabModel('APPLE', 'apple', 'tab', true),
    TabModel('酷工作', 'jobs', 'tab', true),
    TabModel('交易', 'deals', 'tab', true),
    TabModel('城市', 'city', 'tab', true),
    TabModel('问与答', 'qna', 'tab', true),
    TabModel('R2', 'r2', 'tab', true),
  ];
}
