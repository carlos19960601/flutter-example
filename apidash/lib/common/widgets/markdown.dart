import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:url_launcher/url_launcher.dart';

class CustomMarkdown extends StatelessWidget {
  const CustomMarkdown({
    super.key,
    required this.data,
    this.padding = const EdgeInsets.all(16),
    this.onTapLink,
  });

  final String data;
  final EdgeInsets padding;
  final void Function(String text, String? href, String title)? onTapLink;

  @override
  Widget build(BuildContext context) {
    final mdStyleSheet = MarkdownStyleSheet(
      h1: Theme.of(context).textTheme.headlineLarge,
      p: Theme.of(context).textTheme.titleMedium,
    );
    return Markdown(
      data: data,
      padding: padding,
      styleSheet: mdStyleSheet,
      selectable: true,
      onTapLink: onTapLink ??
          (text, href, title) {
            launchUrl(Uri.parse(href ?? ""));
          },
      blockSyntaxes: [SpacerSynax()],
    );
  }
}

final _spacerPattern = RegExp(r'^#br[ \x09\x0b\x0c]*$');

class SpacerSynax extends md.BlockSyntax {
  @override
  md.Node? parse(md.BlockParser parser) {
    pattern.firstMatch(parser.current.content)!;
    parser.advance();
    return md.Element("p", [md.Element.empty("p")]);
  }

  @override
  RegExp get pattern => _spacerPattern;
}
