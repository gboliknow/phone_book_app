import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phone_book_app/models/contact_model.dart';
import 'package:phone_book_app/presentation/vm/contacts_vm.dart';

class AddEditContactView extends StatefulHookConsumerWidget {
  final Contact? contact;
  const AddEditContactView({super.key, this.contact});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddEditContactViewState();
}

class _AddEditContactViewState extends ConsumerState<AddEditContactView> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _avatarController;
  bool isEditMode = false;

  @override
  void initState() {
    super.initState();
    isEditMode = widget.contact != null;
    _nameController = TextEditingController(text: widget.contact?.name ?? '');
    _phoneController = TextEditingController(text: widget.contact?.phone ?? '');
    _avatarController = TextEditingController(text: widget.contact?.avatar ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _avatarController.dispose();
    super.dispose();
  }

  void _saveContact() {
    if (_formKey.currentState!.validate()) {
      final contactVM = ref.read(contactViewModelProvider);

      final newContact = Contact(
        id: isEditMode ? widget.contact!.id : DateTime.now().toString(),
        name: _nameController.text,
        phone: _phoneController.text,
        avatar: _avatarController.text.isNotEmpty ? _avatarController.text : 'https://picsum.photos/200/300',
      );

      if (isEditMode) {
        contactVM.editContact(widget.contact!.id, newContact);
      } else {
        contactVM.addContact(newContact);
      }
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(isEditMode ? 'Contact updated' : 'Contact added')),
      );
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? 'Edit Contact' : 'Add Contact'),
        actions: [
          if (isEditMode)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _showDeleteConfirmationDialog(context),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  labelStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  final phoneRegExp = RegExp(r'^\+?\d{10,15}$');
                  if (!phoneRegExp.hasMatch(value)) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                  controller: _avatarController,
                  decoration: InputDecoration(
                    labelText: 'Avatar URL',
                    labelStyle: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an avatar URL';
                    }
                    return null;
                  }),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveContact,
                child: Text(isEditMode ? 'Save Changes' : 'Add Contact'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteContact() {
    final contactVM = ref.read(contactViewModelProvider);

    if (widget.contact != null) {
      contactVM.deleteContact(widget.contact!.id);
      Navigator.pop(context);
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Contact'),
        content: const Text('Are you sure you want to delete this contact?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _deleteContact();
              Navigator.pop(ctx); // Close the dialog after deleting
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
