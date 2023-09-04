import 'package:flutter/material.dart';
import 'package:OWPM/app/extensions.dart';
import 'package:webviewx/webviewx.dart';

class WebViewXPage extends StatefulWidget {
  const WebViewXPage({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WebViewXPageState createState() => _WebViewXPageState();
}

class _WebViewXPageState extends State<WebViewXPage> {
  int count = 0;
  late WebViewXController webviewController;
  final initialContent =
      '<h4> This is some hardcoded HTML code embedded inside the webview <h4> <h2> Hello world! <h2>';
  final executeJsErrorMessage =
      'Failed to execute this task because the current content is (probably) URL that allows iframe embedding, on Web.\n\n'
      'A short reason for this is that, when a normal URL is embedded in the iframe, you do not actually own that content so you cant call your custom functions\n'
      '(read the documentation to find out why).';

  Size get screenSize => MediaQuery.of(context).size;
  @override
  void initState() {
    //  webviewController.getContent();
    //setUrl();
    super.initState();
  }

  @override
  void dispose() {
    webviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildWebViewX(),
      ),
    );
  }

  Widget _buildWebViewX() {
    return WebViewX(
      key: const ValueKey('webviewx'),
      //initialContent: initialContent,
      initialSourceType: SourceType.url,
      height: screenSize.height,
      width: screenSize.width,
      onWebViewCreated: (controller) {
        webviewController = controller;
        _setUrl();
      },
      onPageStarted: (src) =>
          debugPrint('A new page has started loading: $src\n'),
      onPageFinished: (String url) {
        setState(() {
          count++;
        });
      },
      jsContent: const {
        EmbeddedJsContent(
          js: "function testPlatformIndependentMethod() { console.log('Hi from JS') }",
        ),
        EmbeddedJsContent(
          webJs:
              "function testPlatformSpecificMethod(msg) { TestDartCallback('Web callback says: ' + msg) }",
          mobileJs:
              "function testPlatformSpecificMethod(msg) { TestDartCallback.postMessage('Mobile callback says: ' + msg) }",
        ),
      },

      webSpecificParams: const WebSpecificParams(
        printDebugInfo: true,
      ),
      mobileSpecificParams: const MobileSpecificParams(
        androidEnableHybridComposition: true,
      ),
      navigationDelegate: (navigation) {
        return NavigationDecision.navigate;
      },
    );
  }

  void _setUrl() {
    webviewController.loadContent(
      Uri.encodeFull(context.args['url']),
      SourceType.url,
    );
  }

  Widget buildSpace({
    Axis direction = Axis.horizontal,
    double amount = 0.2,
    bool flex = true,
  }) {
    return flex
        ? Flexible(
            child: FractionallySizedBox(
              widthFactor: direction == Axis.horizontal ? amount : null,
              heightFactor: direction == Axis.vertical ? amount : null,
            ),
          )
        : SizedBox(
            width: direction == Axis.horizontal ? amount : null,
            height: direction == Axis.vertical ? amount : null,
          );
  }
}
