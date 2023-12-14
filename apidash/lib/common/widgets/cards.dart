import 'package:apidash/common/widgets/menus.dart';
import 'package:apidash/common/widgets/texts.dart';
import 'package:apidash/consts.dart';
import 'package:apidash/utils/http.dart';
import 'package:flutter/material.dart';

class SidebarRequestCard extends StatelessWidget {
  const SidebarRequestCard({
    super.key,
    required this.id,
    required this.method,
    this.name,
    this.url,
    this.editRequestId,
    this.activeRequestId,
    this.onTap,
    this.onDoubleTap,
    this.onChangedNameEditor,
    this.onTapOutsideNameEditor,
    this.onMenuSelected,
    this.focusNode,
  });

  final String id;
  final HTTPVerb method;
  final String? name;
  final String? url;
  final String? editRequestId;
  final String? activeRequestId;
  final void Function()? onTap;
  final void Function()? onDoubleTap;
  final Function(String)? onChangedNameEditor;
  final Function()? onTapOutsideNameEditor;
  final Function(RequestItemMenuOption)? onMenuSelected;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).colorScheme.surface;
    final Color colorVariant =
        Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5);

    bool inEditMode = editRequestId == id;
    bool isActiveId = activeRequestId == id;

    String nm = (name != null && name!.trim().isNotEmpty)
        ? name!
        : getRequestTitleFromUrl(url);
    return Tooltip(
      message: nm,
      waitDuration: const Duration(seconds: 1),
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: kBorderRadius8,
        ),
        color: color,
        elevation: isActiveId ? 1 : 0,
        margin: EdgeInsets.zero,
        child: InkWell(
          hoverColor: colorVariant,
          focusColor: colorVariant.withOpacity(0.5),
          onTap: inEditMode ? null : onTap,
          onDoubleTap: inEditMode ? null : onDoubleTap,
          child: Padding(
            padding: EdgeInsets.only(
                left: 6, top: 5, bottom: 5, right: isActiveId ? 6 : 10),
            child: SizedBox(
              height: 20,
              child: Row(
                children: [
                  MethodBox(method: method),
                  kHSpacer4,
                  Expanded(
                    child: inEditMode
                        ? TextFormField(
                            focusNode: focusNode,
                            initialValue: name,
                            style: Theme.of(context).textTheme.bodyMedium,
                            decoration: const InputDecoration(
                              isCollapsed: true,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            onChanged: onChangedNameEditor,
                            onTapOutside: (_) {
                              onTapOutsideNameEditor?.call();
                            },
                          )
                        : Text(nm),
                  ),
                  Visibility(
                    visible: isActiveId && !inEditMode,
                    child: SizedBox(
                      width: 28,
                      child: RequestCardMenu(
                        onSelected: onMenuSelected,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
