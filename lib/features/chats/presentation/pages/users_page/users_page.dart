import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/app_injector.dart';
import 'package:graduation/common/presentation/widgets/search_widget.dart';
import 'package:graduation/common/utils/constants/image_paths.dart';
import 'package:graduation/common/utils/styles/colors.dart';
import 'package:graduation/common/utils/utils.dart';
import 'package:graduation/features/authentication/domain/models/user_model.dart';
import 'package:graduation/features/chats/presentation/pages/users_page/users_list_cubit.dart';
import 'package:graduation/features/chats/presentation/pages/users_page/users_list_state.dart';
import 'package:graduation/features/chats/presentation/pages/users_page/widgets/user_chat_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersListCubit(injector()),
      child: const UsersPageBody(),
    );
  }
}

class UsersPageBody extends StatefulWidget {
  const UsersPageBody({Key? key}) : super(key: key);

  @override
  State<UsersPageBody> createState() => _UsersPageBodyState();
}

class _UsersPageBodyState extends State<UsersPageBody> {
  @override
  void initState() {
    UsersListCubit.get(context).getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                const Image(
                  image: AssetImage(ImagesPaths.chatHeader),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.h, left: 10.w),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                size: 25.w,
                                color: Colors.white,
                              )),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            AppLocalizations.of(context)!.chats,
                            style: TextStyle(
                                color: Colors.white, fontSize: 20.sp),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.more_vert_rounded,
                                size: 25.w,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    const AppSearchWidget(),
                  ],
                ),
              ],
            ),
            BlocBuilder<UsersListCubit, UsersListState>(
              builder: (context, state) {
                if(state.getUsersState == RequestStatus.loading){
                  return const Center(child: CircularProgressIndicator(color: AppColors.kPrimaryColor,));
                }
                else if(state.getUsersState == RequestStatus.error){
                  return Center(child: Text(state.errorMessage ?? '',));
                }
                return Expanded(
                  child: Padding(
                    padding:
                    EdgeInsets.only(right: 20.w, left: 20.w, bottom: 20.h),
                    child: ListView.separated(
                        itemBuilder: (context, index) =>
                            UserChatItem(user:
                            state.users?[index] ?? const UserData.initial(),),
                        separatorBuilder: (context, index) =>
                            SizedBox(
                              height: 15.h,
                            ),
                        itemCount: state.users?.length ?? 0),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
