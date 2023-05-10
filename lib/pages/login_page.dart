import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Define the events for the login page
abstract class LoginEvent {}

class EmailChanged extends LoginEvent {
  final String email;

  EmailChanged({required this.email});
}

class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged({required this.password});
}

class LoginSubmitted extends LoginEvent {}

class RegisterSubmitted extends LoginEvent {}

// Define the states for the login page
abstract class LoginState {}

class InitialLoginState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  final String errorMessage;

  LoginErrorState({required this.errorMessage});
}

// Define the Bloc for the login page
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String email = '';
  String password = '';

  LoginBloc() : super(InitialLoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged) {
      email = event.email;
    } else if (event is PasswordChanged) {
      password = event.password;
    } else if (event is LoginSubmitted) {
      yield LoginLoadingState();

      // Make API request to validate credentials
      bool success = await AuthService.login(email, password);

      if (success) {
        yield LoginSuccessState();
      } else {
        yield LoginErrorState(errorMessage: 'Invalid email or password');
      }
    } else if (event is RegisterSubmitted) {
      yield LoginLoadingState();

      // Make API request to create new account
      bool success = await AuthService.register(email, password);

      if (success) {
        yield LoginSuccessState();
      } else {
        yield LoginErrorState(errorMessage: 'Failed to create account');
      }
    }
  }
}
// Define the login page UI
class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                // Implement login logic here
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text('Don\'t have an account? Register here.'),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextFormField(
              controller: lastNameController,
              decoration: InputDecoration(
                labelText: 'Surname',
              ),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            TextFormField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                // Implement register logic here
              },
              child: Text('Register'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Already have an account? Login here.'),
            ),
          ],
        ),
      ),
    );
  }
}


// Define the AuthService class to handle user authentication
class AuthService {
  static Future<bool> login(String email, String password) async {
// Make API request to validate credentials
// Return true if login is successful, false otherwise
    return true;
  }

  static Future<bool> register(String email, String password) async {
// Make API request to create new account
// Return true if account is created successfully, false otherwise
    return true;
  }
}