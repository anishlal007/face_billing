import 'package:facebilling/ui/widgets/Table_Component/models/data_cell_model.dart';

class Convertors {
  static double convertDataCellToWidth(DataCellSize size) {
    return size == DataCellSize.XS
        ? 50
        : size == DataCellSize.S
            ? 90
            : size == DataCellSize.M
                ? 140
                : size == DataCellSize.L
                    ? 250
                    : 50;
  }
}
