import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/chat/chat_view_model.dart';
import '../features/chat/chat_screen.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  late ChatViewModel chatViewModel;

  @override
  void initState() {
    super.initState();
    chatViewModel = ChatViewModel();
    WidgetsBinding.instance.addObserver(this);
    // TODO: Set up notification delegate equivalent if needed
    // TODO: Handle shared content on startup
    checkForSharedContent();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App became active
      checkForSharedContent();
    }
  }

  void handleURL(Uri url) {
    if (url.scheme == "bitchat" && url.host == "share") {
      checkForSharedContent();
    }
  }

  void checkForSharedContent() async {
    // TODO: Implement platform channel to access shared content (iOS/macOS app group)
    // For now, just print debug info
    debugPrint("DEBUG: checkForSharedContent called");
    // Example: simulate finding shared content
    // final sharedContent = await getSharedContent();
    // if (sharedContent != null) {
    //   chatViewModel.addSystemMessage("preparing to share ...");
    //   Future.delayed(Duration(seconds: 1), () {
    //     chatViewModel.sendMessage(sharedContent);
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: chatViewModel,
      child: MaterialApp(
        title: 'Bitchat Universal',
        home: ChatScreen(),
        // TODO: Implement onGenerateRoute to handle custom URLs if needed
      ),
    );
  }
}
