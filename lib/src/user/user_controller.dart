import 'package:kirgu_employee/src/user/user.dart';
import 'package:kirgu_employee/src/user/user_repository.dart';

class UserController {
  UserController(this.userRepository);

  final UserRepository userRepository;

  late User? _currentUser;

  User get currentUser => _currentUser!;

  Future<void> signIn(String username, String password) async {
    _currentUser = await userRepository.signIn(username, password);
  }
}
