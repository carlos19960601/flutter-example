import 'package:dio/dio.dart';
import 'package:v2ex/http/init.dart';

class DioRequestWeb {
  static Future getTopicsByTabKey(
    String type,
    String id,
    int p,
  ) async {
    var res = {};

    Response response;
    switch (type) {
      case 'tab':
        response = await Request().get(
          '/',
          data: {'tab': id},
          extra: {'ua': 'pc'},
        );
        break;
      case 'recent':
        return await getTopicsRecent('recent', p).then((value) => value);
      case 'changes':
        return await getTopicsRecent('changes', p).then((value) => value);
      case 'go':
        return await NodeWebApi.getTopicsByNodeId(id, p)
            .then((value) => value.topicList);
      default:
        response = await Request().get(
          '/',
          data: {'tab': 'all'},
          extra: {'ua': 'mob'},
        );
        break;
    }

    return res;
  }

  // 获取最新的主题
  static Future getTopicsRecent(String path, int p) async {
    var res = {};
    var topicList = <TabTopicItem>[];
    List childNodeList = [];
    List<int> actionCounts = [];
    String balance = '';
    Response response;
    try {
      response = await Request().get(
        '/$path',
        data: {'p': p},
        extra: {'ua': 'pc'},
      );
    } catch (err) {
      rethrow;
    }
    var tree = ETree.fromString(response.data);
    var aRootNode = tree.xpath("//*[@class='cell item']");
    for (var aNode in aRootNode!) {
      var item = TabTopicItem();
      item.memberId =
          aNode.xpath("/table/tr/td[3]/span[2]/strong/a/text()")![0].name!;
      if (aNode.xpath("/table/tr/td[1]/a[1]/img") != null &&
          aNode.xpath("/table/tr/td[1]/a[1]/img")!.isNotEmpty) {
        item.avatar = Uri.encodeFull(aNode
            .xpath("/table/tr/td[1]/a[1]/img[@class='avatar']")
            ?.first
            .attributes["src"]);
      }
      String topicUrl = aNode
          .xpath("/table/tr/td[3]/span[1]/a")
          ?.first
          .attributes["href"]; // 得到是 /t/522540#reply17
      item.topicId = topicUrl.replaceAll("/t/", "").split("#")[0];
      if (aNode.xpath("/table/tr/td[4]")!.first.children.isNotEmpty) {
        item.replyCount =
            int.parse(aNode.xpath("/table/tr/td[4]/a/text()")![0].name!);
      }
      item.lastReplyTime =
          aNode.xpath("/table/tr/td[3]/span[2]/span/text()")![0].name!;
      item.nodeName = aNode.xpath("/table/tr/td[3]/span[2]/a/text()")![0].name!;

      item.topicTitle = aNode
          .xpath("/table/tr/td[3]/span[1]/a/text()")![0]
          .name!
          .replaceAll('&quot;', '"')
          .replaceAll('&amp;', '&')
          .replaceAll('&lt;', '<')
          .replaceAll('&gt;', '>');
      item.nodeId = aNode
          .xpath("/table/tr/td[3]/span[2]/a")
          ?.first
          .attributes["href"]
          .split('/')[2];
      topicList.add(item);
    }
    try {
      Read().mark(topicList);
    } catch (err) {
      print(err);
    }
    var document = parse(response.data);
    var rightBarNode = document.querySelector('#Rightbar > div.box');
    List tableList = rightBarNode!.querySelectorAll('table');
    if (tableList.isNotEmpty) {
      var actionNodes = tableList[1]!.querySelectorAll('span.bigger');
      for (var i in actionNodes) {
        actionCounts.add(int.parse(i.text ?? 0));
      }
      if (rightBarNode.querySelector('#money') != null) {
        balance = rightBarNode.querySelector('#money >a')!.innerHtml;
      }
      var noticeEl = rightBarNode.querySelectorAll('a.fade');
      if (noticeEl.isNotEmpty) {
        var unRead = noticeEl[0].text.replaceAll(RegExp(r'\D'), '');
        // print('$unRead条未读消息');
        if (int.parse(unRead) > 0) {
          eventBus.emit('unRead', int.parse(unRead));
        }
      }
    }
    res['topicList'] = topicList;
    res['childNodeList'] = childNodeList;
    res['actionCounts'] = actionCounts;
    res['balance'] = balance;
    return res;
  }
}
