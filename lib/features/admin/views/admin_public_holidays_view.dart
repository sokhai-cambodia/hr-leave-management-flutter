import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/public_holiday_model.dart';
import '../../../widgets/admin/admin_crud_view.dart';
import '../../../widgets/admin/admin_field_spec.dart';
import '../controllers/public_holidays_admin_controller.dart';

class AdminPublicHolidaysView extends StatelessWidget {
  const AdminPublicHolidaysView({super.key});

  static const _fields = [
    AdminFieldSpec(key: 'date', label: 'Date', type: AdminFieldType.date, required: true),
    AdminFieldSpec(key: 'name', label: 'Name', type: AdminFieldType.text, required: true),
    AdminFieldSpec(key: 'description', label: 'Description', type: AdminFieldType.multilineText),
  ];

  static const _emptyValues = {'date': '', 'name': '', 'description': null};

  Map<String, dynamic> _toFormValues(PublicHolidayModel item) => {
    'date': item.date,
    'name': item.name,
    'description': item.description,
  };

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PublicHolidaysAdminController>();

    return AdminCrudView<PublicHolidayModel>(
      title: 'Public Holidays',
      controller: controller,
      fields: (isEdit) => _fields,
      toFormValues: _toFormValues,
      emptyFormValues: _emptyValues,
      itemTitle: (item) => item.name,
      itemSubtitle: (item) => item.date,
      searchHint: 'Search by name or date...',
    );
  }
}
