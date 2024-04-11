import 'package:apidash/consts.dart';
import 'package:flutter/material.dart';

class SendRequestButton extends StatefulWidget {
  const SendRequestButton({
    super.key,
    required this.activeId,
    required this.sentRequestId,
    required this.onTap,
  });

  final String? activeId;
  final String sentRequestId;
  final void Function() onTap;

  @override
  State<SendRequestButton> createState() => _SendRequestButtonState();
}

class _SendRequestButtonState extends State<SendRequestButton> {
  @override
  Widget build(BuildContext context) {
    bool disable = widget.sentRequestId.isNotEmpty;

    return FilledButton(
      onPressed: () {},
      child: Row(
        children: [
          Text(
            disable
                ? (widget.activeId == widget.sentRequestId
                    ? kLabelSending
                    : kLabelBusy)
                : kLabelSend,
          ),
          if (!disable) kHSpacer10,
          if (!disable)
            const Icon(
              Icons.send,
              size: 16,
            )
        ],
      ),
    );
  }
}
