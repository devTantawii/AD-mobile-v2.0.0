import 'package:abudiyab/modules/auth/register/data/datasources/remote/register_remote_datasource.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.registerRemoteDatasource) : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);
  final RegisterRemoteDatasource registerRemoteDatasource;

  // RegisterRepository registerRepository;
   var picker = ImagePicker();
  XFile? imageProfile;
  String imagePathFace = "";
  getImage(String type) async {
    emit(ImageProfileLodingState());
    try {
      if (type == "camera") {
        imageProfile = await picker.pickImage(source: ImageSource.camera);
        imagePathFace = imageProfile!.path;
        emit(ImageProfileScussesState());
      } else if (type == "gallery") {
        imageProfile = await picker.pickImage(source: ImageSource.gallery);
        imagePathFace = imageProfile!.path;
        emit(ImageProfileScussesState());
      }
    } catch (e) {
      emit(ImageProfileErrorState(error: e.toString()));
    }
  }
  
  Future<void> userRegister({
    required String name ,
    required String email,
    required String phone,
    required String password,
    required String passworConfirm,
    required String idNumber,
    required String licenceFace,
  }) async {
    emit(RegisterLoading());
    print("before register");
    try {
      await registerRemoteDatasource.signup({
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "password_confirmation": passworConfirm,
        "id_number": idNumber,
      },
          licenceFace
      );
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
