import 'package:apidash/common/widgets/tabs.dart';
import 'package:apidash/consts.dart';
import 'package:flutter/material.dart';

class RequestPane extends StatefulWidget {
  const RequestPane({
    super.key,
    required this.children,
    required this.codePaneVisible,
    this.showIndicators = const [false, false, false],
    this.onTapTabBar,
    this.tabIndex,
  });

  final List<Widget> children;
  final bool codePaneVisible;
  final List<bool> showIndicators;
  final void Function(int)? onTapTabBar;
  final int? tabIndex;

  @override
  State<RequestPane> createState() => _RequestPaneState();
}

class _RequestPaneState extends State<RequestPane>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 3, animationDuration: kTabAnimationDuration, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tabIndex != null) {
      _tabController.index = widget.tabIndex!;
    }
    return Column(
      children: [
        Padding(
          padding: kPh20v10,
          child: SizedBox(
            height: kHeaderHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Request",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                FilledButton.tonalIcon(
                  onPressed: () {},
                  icon: Icon(
                    widget.codePaneVisible
                        ? Icons.code_off_rounded
                        : Icons.code_rounded,
                  ),
                  label: SizedBox(
                    width: 75,
                    child: Text(
                        widget.codePaneVisible ? "Hide Code" : "View Code"),
                  ),
                ),
              ],
            ),
          ),
        ),
        TabBar(
          controller: _tabController,
          overlayColor: kColorTransparentState,
          onTap: widget.onTapTabBar,
          tabs: [
            TabLabel(
              text: "URL Params",
              showIndicator: widget.showIndicators[0],
            ),
            TabLabel(
              text: "Headers",
              showIndicator: widget.showIndicators[1],
            ),
            TabLabel(
              text: "Body",
              showIndicator: widget.showIndicators[2],
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.children,
          ),
        )
      ],
    );
  }
}
