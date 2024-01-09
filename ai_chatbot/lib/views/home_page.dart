import "dart:convert";

import 'package:http/http.dart' as http;
import "package:ai_chatbot/constants/colours.dart";
import "package:ai_chatbot/models/conversation.dart";
import "package:ai_chatbot/views/widgets/chat_list_field.dart";
import "package:ai_chatbot/views/widgets/chat_text_field.dart";
import "package:flutter/material.dart";

fetchdata(String url) async {
  http.Response response = await http.get(Uri.parse(url));
  return response.body;
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var data;
  String url = '';
  String funnyURL = '';
  final controller = TextEditingController();
  List<Conversation> conversations = [];

  bool get isConversationStarted => conversations.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        backgroundColor: CustomColours.primaryColor,
        body: SafeArea(
            child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!isConversationStarted) ...[
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white, width: .8)),
                  child: const Column(children: [
                    SizedBox(height: 20),
                    Text("Welcome to Legalease",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    Text("Your AI-powered legal assistant",
                        style: TextStyle(fontSize: 18)),
                    SizedBox(height: 20),
                    Text("Get started by asking a question",
                        style: TextStyle(fontSize: 18)),
                    SizedBox(height: 20),
                    Text(
                        "For example: What is the legal age to drive in India?",
                        style: TextStyle(fontSize: 18)),
                    SizedBox(height: 20),
                    Text("Made with ❤️ by pdf-philes",
                        style: TextStyle(fontSize: 18)),
                    SizedBox(height: 20),
                  ]),
                )
              ] else
                Expanded(child: ChatListView(conversations: conversations)),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ChatTextField(
                      controller: controller,
                      onSubmitted: (question) async {
                        url =
                            "http://10.0.2.2:5000/get-response?query=${question}";

                        funnyURL = "http://10.0.2.2:5000/get-response";
                        controller.clear();
                        FocusScope.of(context).unfocus();
                        conversations.add(Conversation(question!, ""));

                        data = await fetchdata(funnyURL);
                        conversations.last =
                            Conversation(question, "Hello there");
                        var decoded = jsonDecode(data)['response'];
                        conversations.last =
                            Conversation(conversations.last.question, decoded);
                      })
                ],
              ))
            ],
          ),
        )));
  }
}
