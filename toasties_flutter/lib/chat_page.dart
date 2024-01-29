import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:provider/provider.dart';
import 'package:toasties_flutter/common/entity/index.dart';
import 'package:toasties_flutter/common/providers/state_provider.dart';
import 'package:toasties_flutter/common/widgets/chat_input_group.dart';
import 'package:toasties_flutter/LAILA/engine.dart';
import 'package:toasties_flutter/common/widgets/msg_bubble.dart';
import 'package:toasties_flutter/common/widgets/typing_indicator.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final TextEditingController _textController;
  late final ScrollController _scrollController;
  final GlobalKey<NavigatorState> _chatNavKey = GlobalKey<NavigatorState>();

  bool _loading = false;
  set loading(bool set) => setState(() => _loading = set);
  bool get loading => _loading;

  late final List<Content> chats;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _scrollController = ScrollController(keepScrollOffset: true);
    LAILA.getAllInitContent().then(
          (value) => LAILA.currentChatContentList,
        );
    chats = LAILA.currentChatContentList;
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    chats.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (chats.isNotEmpty && chats.last.role == 'user') {
      loading = true;
    }
    return Scaffold(
      key: _chatNavKey,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Consumer<ToastieStateProvider>(
          builder: (context, authProvider, child) => Scaffold(
            body: Stack(
              children: [
                Positioned.fill(
                  bottom: 60,
                  child: Column(
                    children: [
                      chats.isNotEmpty
                          ? Expanded(
                              child: StreamBuilder(
                                initialData: LAILA.gemini.chat(chats),
                                stream: LAILA.gemini.streamChat(chats),
                                builder: (context, snapshot) {
                                  return ListView.builder(
                                    controller: _scrollController,
                                    shrinkWrap: true,
                                    itemCount: chats.length,
                                    itemBuilder: (context, index) {
                                      return ToastieChatBubble.fromContent(
                                        chats[index],
                                      );
                                    },
                                  );
                                },
                              ),
                            )
                          : Container(),
                      /////////////////////////////////////////////
                      TypingIndicator(loading: loading),
                    ],
                  ),
                ),
                ChatInputGroup(
                  textController: _textController,
                  onSave: () {
                    print('======================= current Chat saved(?)');
                    print('======================= $chats');
                    // // call save function that takes the current content
                    // // list, converts it to a Chat object, and saves it to
                    // // the database
                    // authProvider.saveCurrentChat();
                  },
                  onSend: () {
                    // print(_textController.text);
                    final newMsg = Message(
                      timeCreated: Timestamp.now(),
                      isMsgUser: true,
                      content: _textController.text,
                    );
                    authProvider.addToCurrentChat(newMsg);

                    final newContent = Content(
                      role: "user",
                      parts: [
                        Parts(
                          text: _textController.text,
                        ),
                      ],
                    );

                    setState(() => chats.add(newContent));

                    _textController.clear();
                    loading = true;

                    LAILA.gemini.streamChat(chats).listen((candidates) {
                      loading = false;
                      setState(() {
                        // check if the last message in the chat is from the user
                        if (chats.isNotEmpty &&
                            chats.last.role == candidates.content?.role) {
                          // if it is, then add the candidates output to the last message
                          chats.last.parts!.last.text =
                              '${chats.last.parts!.last.text}${candidates.output}';
                        }
                        // if it isn't, then just add a new message to the chat (both locally and in the database)
                        else {
                          final newContent = Content(
                            role: 'model',
                            parts: [Parts(text: candidates.output)],
                          );
                          chats.add(newContent);
                          final newMsg = Message(
                            timeCreated: Timestamp.now(),
                            isMsgUser: false,
                            content:
                                candidates.output ?? "ERROR RECEIVING MESSAGE",
                          );
                          authProvider.addToCurrentChat(newMsg);
                        }
                      });

                      loading = false;
                    });

                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.bounceIn,
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
