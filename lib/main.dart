import 'package:camel_up/cubit/auth_cubit.dart';
import 'package:camel_up/cubit/auth_status_cubit.dart';
import 'package:camel_up/cubit/auth_textfield_error_cubit.dart';
import 'package:camel_up/cubit/enter_role_cubit.dart';
import 'package:camel_up/cubit/idea_upload_cubit.dart';
import 'package:camel_up/cubit/need_teammates_cubit.dart';
import 'package:camel_up/cubit/privacy_members_cubit.dart';
import 'package:camel_up/cubit/selected_members_count_cubit.dart';
import 'package:camel_up/cubit/selected_members_cubit.dart';
import 'package:camel_up/cubit/selected_radio_button_cubit.dart';
import 'package:camel_up/cubit/team_results_cubit.dart';
import 'package:camel_up/cubit/team_selection_cubit.dart';
import 'package:camel_up/repos/idea_repo.dart';
import 'package:camel_up/repos/user_repo.dart';
import 'package:camel_up/screens/auth/login.dart';
import 'package:camel_up/screens/auth/signup.dart';
import 'package:camel_up/screens/home/home.dart';
import 'package:camel_up/screens/welcome/welcome.dart';
import 'package:camel_up/tests/tests.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  final _userRepo = UserRepo();
  final _ideaRepo = IdeaRepo();

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(_userRepo)
        ),
        BlocProvider<AuthTextfieldErrorCubit>(
          create: (context) => AuthTextfieldErrorCubit()
        ),
        BlocProvider<AuthStatusCubit>(
          create: (context) => AuthStatusCubit()
        ),
        BlocProvider<TeamResultsCubit>(
          create: (context) => TeamResultsCubit(userRepo: _userRepo)
        ),
        BlocProvider<TeamSelectionCubit>(
          create: (context) => TeamSelectionCubit()
        ),
        BlocProvider<EnterRoleCubit>(
          create: (context) => EnterRoleCubit()
        ),
        BlocProvider<SelectedMembersCubit>(
          create: (context) => SelectedMembersCubit()
        ),
        BlocProvider<SelectedMembersCountCubit>(
          create: (context) => SelectedMembersCountCubit()
        ),
        BlocProvider<SelectedRadioButtonCubit>(
          create: (context) => SelectedRadioButtonCubit()
        ),
        BlocProvider<NeedTeammatesCubit>(
          create: (context) => NeedTeammatesCubit()
        ),
        BlocProvider<PrivacyMembersCubit>(
          create: (context) => PrivacyMembersCubit(_userRepo)
        ),
        BlocProvider<IdeaUploadCubit>(
          create: (context) => IdeaUploadCubit(_ideaRepo)
        ),
      ],
      child: MaterialApp(
          title: 'Camel Up',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Body(),
        ),
    );
  }
}

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  void initState() {
    super.initState();

    // Tests.uploadMockProfiles();
    
    Future.delayed(Duration.zero, (){
      final authCubit = context.bloc<AuthCubit>();
      authCubit.checkSignedInUser();
    });

  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state){
        if(state is AuthInitial){
          return CircularProgressIndicator();
        }else if(state is AuthLoggedIn){
          return Home();
        }else if(state is AuthSignUp){
          return SignUp();
        }else if(state is AuthLogIn){
          return Login();
        }else if(state is AuthSignedUp){
          return Welcome();
        }else if(state is AuthSignUpError){
          return SignUp();
        }
        else{
          return Login();
        }
      }
    );
  }
}
