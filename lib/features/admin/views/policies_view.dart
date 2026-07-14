import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/policy_model.dart';
import '../../../widgets/admin/admin_crud_view.dart';
import '../../../widgets/admin/admin_field_spec.dart';
import '../controllers/policies_admin_controller.dart';

class PoliciesView extends StatelessWidget {
  const PoliciesView({super.key});

  static const _fields = [
    AdminFieldSpec(
      key: 'code',
      label: 'Code',
      type: AdminFieldType.text,
      required: true,
    ),
    AdminFieldSpec(
      key: 'name',
      label: 'Name',
      type: AdminFieldType.text,
      required: true,
    ),
    AdminFieldSpec(
      key: 'operation',
      label: 'Operation',
      type: AdminFieldType.text,
    ),
    AdminFieldSpec(
      key: 'value',
      label: 'Value',
      type: AdminFieldType.text,
      required: true,
    ),
    AdminFieldSpec(key: 'score', label: 'Score', type: AdminFieldType.decimal),
    AdminFieldSpec(
      key: 'description',
      label: 'Description',
      type: AdminFieldType.multilineText,
    ),
    AdminFieldSpec(
      key: 'is_active',
      label: 'Active',
      type: AdminFieldType.boolean,
    ),
  ];

  static const _emptyValues = {
    'code': '',
    'name': '',
    'operation': '==',
    'value': '',
    'score': 0.0,
    'description': null,
    'is_active': true,
  };

  Map<String, dynamic> _toFormValues(PolicyModel item) => {
    'code': item.code,
    'name': item.name,
    'operation': item.operation,
    'value': item.value,
    'score': item.score,
    'description': item.description,
    'is_active': item.isActive,
  };

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PoliciesAdminController>();

    return AdminCrudView<PolicyModel>(
      title: 'Policies',
      controller: controller,
      fields: (isEdit) => _fields,
      toFormValues: _toFormValues,
      emptyFormValues: _emptyValues,
      itemTitle: (item) => '${item.name} (${item.code})',
      itemSubtitle: (item) =>
          '${item.operation ?? "=="} ${item.value} · score ${item.score ?? 0}'
          '${item.isActive ? "" : " · Inactive"}',
      searchHint: 'Search by name or code...',
    );
  }
}
