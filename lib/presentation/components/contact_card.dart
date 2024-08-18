import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_book_app/models/contact_model.dart';
import 'package:phone_book_app/presentation/views/contactform_view.dart';
import 'package:phone_book_app/presentation/vm/contacts_vm.dart';
import 'package:phone_book_app/utils/logger.dart';

class ContactCard extends StatefulWidget {
  const ContactCard({super.key, required this.contact, required this.contactVM});
  final Contact contact;
  final ContactViewModel contactVM;

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddEditContactView(
                      contact: widget.contact,
                    )));
      },
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: widget.contact.avatar == ""
                ? Image.asset("profile_icon".png)
                : CircleAvatar(
                    backgroundImage: NetworkImage(widget.contact.avatar),
                  ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.contact.name,
                style: TextStyle(
                  color: Theme.of(context).textTheme.titleLarge?.color,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              Row(
                children: [
                  Icon(
                    Icons.call,
                    size: 12.sp,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    widget.contact.phone,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.titleLarge?.color,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddEditContactView(
                            contact: widget.contact,
                          )));
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => _showDeleteConfirmationDialog(context),
          ),
        ],
      ),
    );
  }

  void _deleteContact() {
    widget.contactVM.deleteContact(widget.contact.id);
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
