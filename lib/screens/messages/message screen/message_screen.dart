import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../style/style.dart';
import '../cubit/chat_cubit.dart';
import '../utils/bottom_sheet_message_screen.dart';

import '../utils/messages_list.dart';
import '../utils/search_user_textfield.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController searUserController = TextEditingController();
  late StreamSubscription<SearchUsersState> _searchUsersSubscription;

  @override
  void initState() {
    super.initState();
    _searchUsersSubscription =
        BlocProvider.of<SearchUsersCubit>(context).stream.listen((state) {
      if (state is SearchUsersLoadedState) {
        showSearchResultsBottomSheet(context, state.searchResults);
      }
    });
  }

  @override
  void dispose() {
    searUserController.dispose();
    _searchUsersSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            'Messages',
            style: textBoldW.copyWith(fontSize: 20),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 25),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              (MediaQuery.of(context).padding.top + kToolbarHeight),
          child: Column(
            children: [
              // ! search user textfield
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: SearchUserTextfield(
                  controller: searUserController,
                  hintText: 'Search user ..',
                  onTap: () async {
                    String searchText = searUserController.text.trim();
                    if (searchText.isNotEmpty) {
                      BlocProvider.of<SearchUsersCubit>(context)
                          .searchUsers(searchText);
                    }
                    // ? gets rid of keyboard
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    // ? gets rid of keyboard
                  },
                ),
              ),
              // ! search user textfield
              const SizedBox(height: 25),
              // * shows the messages
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: DefaultTabController(
                      length: 2, // Number of tabs
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 15),
                            child: TabBar(
                              labelStyle: tabBarText,
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.black,
                              dividerHeight: 0,
                              indicatorSize: TabBarIndicatorSize.label,
                              indicator: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              tabs: [
                                Tab(
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: const Center(child: Text('Primary')),
                                  ),
                                ),
                                Tab(
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: const Center(child: Text('General')),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Expanded(
                            child: TabBarView(
                              children: [
                                // Content for Tab 1
                                MessagesList(),
                                // Content for Tab 2
                                Placeholder(),
                                // Content for Tab 3
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // * shows the messages
            ],
          ),
        ),
      ),
    );
  }

  // * navigates current user into chatroom wit corresponding user
}
