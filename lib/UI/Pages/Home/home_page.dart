import 'package:flare_chat_app/Bloc/Home/home_cubit.dart';
import 'package:flare_chat_app/Components/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Bloc/Home/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchUserInformation();
  }

  final TextEditingController _meesageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (BuildContext context, HomeState state) {},
      builder: (context, state) {
        if (state is HomeSuccess) {
          final infoModel = state.infoModel;
          return StreamBuilder(
            stream: context.watch<HomeCubit>().streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Hata: ${snapshot.error}');
              } else {
                // Firestore'dan gelen mesajları kullanın
                List messages = snapshot.data ?? [];
                return Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    title: const Text('Flare Chat'),
                    toolbarHeight: 80,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    actions: [
                      IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CircleAvatar(
                          child: ClipOval(
                              child: Image.network(
                            infoModel?.image ??
                                'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg',
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          )),
                        ),
                      )
                    ],
                  ),
                  body: Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 80,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 4),
                              child: Card(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      messages[index]['username'],
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      messages[index]['message'],
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              )),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.82,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    boxShadow: const [BoxShadow(blurRadius: 10, color: AppColor.buttonColor)],
                                    border: Border.all(color: AppColor.buttonColor),
                                    borderRadius: const BorderRadius.all(Radius.circular(28))),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: TextField(
                                    controller: _meesageController,
                                    cursorColor: AppColor.buttonColor,
                                    decoration: const InputDecoration(
                                      hintText: "Message",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              InkWell(
                                onTap: () {
                                  context
                                      .read<HomeCubit>()
                                      .sendMessage(_meesageController.text, infoModel?.username ?? "Anonymous");
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.buttonColor,
                                    boxShadow: [BoxShadow(blurRadius: 200, color: AppColor.buttonColor)],
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Center(child: Icon(Icons.send)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
            },
          );
        }
        return const Center(
          child: Text("Error"),
        );
      },
    );
  }
}
