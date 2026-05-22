import 'package:markdown/markdown.dart' as md;
import 'package:flutter_markdown_latex/flutter_markdown_latex.dart';

void main() {
  final text = r'$n=4$, $m=2$';
  
  final inlineSyntaxes = <md.InlineSyntax>[
    LatexInlineSyntax(),
    ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes,
  ];

  final extensionSet = md.ExtensionSet(
    [LatexBlockSyntax(), ...md.ExtensionSet.gitHubFlavored.blockSyntaxes],
    inlineSyntaxes,
  );

  final document = md.Document(
    extensionSet: extensionSet,
    encodeHtml: false,
  );

  final nodes = document.parseLines([text]);
  
  for (var node in nodes) {
    if (node is md.Element) {
      print('Block: ${node.tag}');
      for (var child in node.children ?? []) {
        if (child is md.Element) {
          print('  Inline: ${child.tag}, MathStyle: ${child.attributes["MathStyle"]}, Text: ${child.textContent}');
        } else if (child is md.Text) {
          print('  Text: ${child.text}');
        }
      }
    }
  }
}
