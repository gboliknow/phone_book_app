import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phone_book_app/models/contact_model.dart';
import 'package:phone_book_app/presentation/views/contactform_view.dart';
import 'package:phone_book_app/presentation/vm/contacts_vm.dart';
import 'package:phone_book_app/utils/logger.dart';

class ContactHomeView extends StatefulHookConsumerWidget {
  const ContactHomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContactHomeViewState();
}

class _ContactHomeViewState extends ConsumerState<ContactHomeView> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contactVM = ref.watch(contactViewModelProvider);
    final contacts = contactVM.contacts;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Phone Book App"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddEditContactView()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(
              height: 24.h,
            ),
            const ContactHeader(),
            SizedBox(
              height: 24.h,
            ),
            SizedBox(height: 24.h),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Contacts',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14.0)),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                  },
                ),
              ),
              onChanged: (query) {
                setState(() {
                  // Update UI to show filtered contacts based on search
                  contactVM.searchContacts(query);
                });
              },
            ),
            SizedBox(height: 24.h),
            ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 15.h,
                );
              },
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ContactCard(
                  contact: contact,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.contact});
  final Contact contact;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddEditContactView(
                      contact: contact,
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
            child: contact.avatar == ""
                ? Image.asset("profile_icon".png)
                : CircleAvatar(
                    backgroundImage: NetworkImage(contact.avatar),
                  ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                contact.name,
                style: TextStyle(
                  color: Colors.black,
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
                    contact.phone,
                    style: TextStyle(
                      color: Colors.black,
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
              // Navigate to Edit Contact Screen
            },
          ),
          Container(
            height: 40,
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10.r)),
            child: Row(
              children: [
                Icon(
                  Icons.delete,
                  size: 16.sp,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ContactHeader extends StatelessWidget {
  const ContactHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Contacts",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AddEditContactView()));
          },
          child: Container(
            height: 40,
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary, borderRadius: BorderRadius.circular(10.r)),
            child: Row(
              children: [
                Icon(
                  Icons.add,
                  size: 16.sp,
                ),
                SizedBox(
                  width: 12.w,
                ),
                Text(
                  "Add Contact",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}