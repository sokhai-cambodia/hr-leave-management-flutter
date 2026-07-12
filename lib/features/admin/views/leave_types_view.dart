import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/leave_type_model.dart';
import '../../../widgets/admin/admin_crud_view.dart';
import '../../../widgets/admin/admin_field_spec.dart';
import '../controllers/leave_types_admin_controller.dart';

class LeaveTypesView extends StatelessWidget {
  const LeaveTypesView({super.key});

  static const _fields = [
    AdminFieldSpec(key: 'code', label: 'Code', type: AdminFieldType.text, required: true),
    AdminFieldSpec(key: 'name', label: 'Name', type: AdminFieldType.text, required: true),
    AdminFieldSpec(
      key: 'entitlement',
      label: 'Entitlement (days)',
      type: AdminFieldType.number,
      required: true,
    ),
    AdminFieldSpec(key: 'description', label: 'Description', type: AdminFieldType.multilineText),
    AdminFieldSpec(key: 'is_allow_plan', label: 'Allow planning', type: AdminFieldType.boolean),
    AdminFieldSpec(key: 'is_active', label: 'Active', type: AdminFieldType.boolean),
  ];

  static const _emptyValues = {
    'code': '',
    'name': '',
    'entitlement': 0,
    'description': null,
    'is_allow_plan': true,
    'is_active': true,
  };

  Map<String, dynamic> _toFormValues(LeaveTypeModel item) => {
    'code': item.code,
    'name': item.name,
    'entitlement': item.entitlement,
    'description': item.description,
    'is_allow_plan': item.isAllowPlan,
    'is_active': item.isActive,
  };

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LeaveTypesAdminController>();

    return AdminCrudView<LeaveTypeModel>(
      title: 'Leave Types',
      controller: controller,
      fields: (isEdit) => _fields,
      toFormValues: _toFormValues,
      emptyFormValues: _emptyValues,
      itemTitle: (item) => '${item.name} (${item.code})',
      itemSubtitle: (item) =>
          '${item.entitlement} days · ${item.isActive ? "Active" : "Inactive"}'
          '${item.isAllowPlan ? "" : " · No planning"}',
      searchHint: 'Search by name or code...',
    );
  }
}
