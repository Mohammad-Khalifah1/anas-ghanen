import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/waiting_provider.dart';
import 'ticket_dialog.dart';

class AddGroupSheet extends StatefulWidget {
  const AddGroupSheet({super.key});

  @override
  State<AddGroupSheet> createState() => _AddGroupSheetState();
}

class _AddGroupSheetState extends State<AddGroupSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _partySizeController = TextEditingController();

  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _partySizeController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final name = _nameController.text.trim();
    final partySize = int.tryParse(_partySizeController.text.trim());

    if (partySize == null || partySize <= 0) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final provider = context.read<WaitingProvider>();

      final group = await provider.addNewGroup(
        name: name,
        partySize: partySize,
      );

      if (!mounted) {
        return;
      }

      if (group == null) {
        _showError('تعذر إضافة المجموعة. حاول مرة أخرى.');
        return;
      }

      final groupsAhead = await provider.groupsAhead(group.id);

      if (!mounted) {
        return;
      }

      Navigator.of(context).pop();

      await showDialog<void>(
        context: context,
        builder: (_) {
          return TicketDialog(group: group, groupsAhead: groupsAhead);
        },
      );
    } catch (error) {
      if (!mounted) {
        return;
      }

      _showError('حدث خطأ غير متوقع. حاول مرة أخرى.');

      debugPrint('AddGroupSheet submit error: $error');
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + bottomInset),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'إضافة مجموعة',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[a-zA-Z\u0600-\u06FF\s]'),
                  ),
                ],
                decoration: const InputDecoration(
                  labelText: 'اسم المجموعة',
                  hintText: 'مثال: أحمد أو Ahmed',
                  border: OutlineInputBorder(),
                ),
                validator: _validateName,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _partySizeController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2),
                ],
                onFieldSubmitted: (_) => _submit(),
                decoration: const InputDecoration(
                  labelText: 'عدد الأشخاص',
                  hintText: 'مثال: 4',
                  border: OutlineInputBorder(),
                ),
                validator: _validatePartySize,
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('إضافة إلى قائمة الانتظار'),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  String? _validateName(String? value) {
  final name = value?.trim() ?? '';

  if (name.isEmpty) {
    return 'أدخل اسم المجموعة';
  }

  if (name.length < 2) {
    return 'الاسم قصير جداً';
  }

  return null;
}

  String? _validatePartySize(String? value) {
    final size = int.tryParse(value?.trim() ?? '');

    if (size == null) {
      return 'أدخل عدد الأشخاص';
    }

    if (size < 1) {
      return 'يجب أن يكون العدد شخصاً واحداً على الأقل';
    }

    if (size > 30) {
      return 'الحد الأقصى للمجموعة هو 30 شخصاً';
    }

    return null;
  }
}
