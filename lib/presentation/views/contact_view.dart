import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phone_book_app/presentation/components/contact_card.dart';
import 'package:phone_book_app/presentation/views/contactform_view.dart';
import 'package:phone_book_app/presentation/vm/contacts_vm.dart';
import 'package:phone_book_app/presentation/vm/theme_vm.dart';

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
    final themeNotifier = ref.watch(themeNotifierProvider);
    final contacts = contactVM.allFilteredContacts;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Phone Book App"),
        actions: [
          Switch(
            value: themeNotifier.isDarkMode,
            onChanged: (value) {
              ref.read(themeNotifierProvider.notifier).toggleTheme();
            },
          ),
        ],
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
              decoration: const InputDecoration(
                labelText: 'Search Contacts',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14.0)),
                ),
              ),
              onChanged: (query) {
                contactVM.searchContacts(query);
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
                  contactVM: contactVM,
                );
              },
            ),
          ],
        ),
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
            color: Theme.of(context).textTheme.titleLarge?.color,
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
                  color: Theme.of(context).iconTheme.color,
                ),
                SizedBox(
                  width: 12.w,
                ),
                Text(
                  "Add Contact",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
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
