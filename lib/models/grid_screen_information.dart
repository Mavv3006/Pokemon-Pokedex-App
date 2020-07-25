import 'package:to_string/to_string.dart';

part 'grid_screen_information.g.dart';

@ToString()
class GridScreenInformation {
  int crossAxisCount;
  double childAspectRatio;

  @override
  String toString() {
    return _$GridScreenInformationToString(this);
  }
}
