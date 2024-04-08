// 3rd Party Packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project Files
import '../core/common/common.dart';
import '../data/auth/api/auth_api.dart';
import '../data/auth/api/auth_remote_data_source.dart';
import '../data/auth/repository/auth_repository.dart';
import '../ui/blocs/app_user_bloc/user_bloc.dart';
import '../ui/pages/create_profile_page/cubit/create_profile_cubit.dart';
import '../ui/pages/login_page/cubit/login_cubit.dart';
import '../ui/pages/sign_up_page/cubit/sign_up_cubit.dart';

part 'injection_container.main.dart';