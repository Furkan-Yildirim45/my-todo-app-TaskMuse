
import 'package:task_muse/product/exception/global_manage_cubit_exception.dart';
import 'package:task_muse/product/global/cubit/global_manage_cubit.dart';

class GlobalManageProvider{
  static GlobalManageCubit? _manageCubit;

  static void init(GlobalManageCubit cubit) {
    _manageCubit ??= cubit;
  }
  static GlobalManageCubit get globalManageCubit{
    if(_manageCubit == null) throw GlobalManageCubitException();
    return _manageCubit!;
  }
}
