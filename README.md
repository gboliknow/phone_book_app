# Phone Book App

## Overview

The **Phone Book App** is a Flutter application that allows users to manage their contacts. It includes features for adding, editing, deleting, and searching contacts. The app supports light and dark themes, and provides a responsive user interface optimized for different screen sizes.

### Features

- **Add Contacts**: Users can create new contacts with a name, phone number, and optional avatar URL.
- **Edit Contacts**: Users can update the details of existing contacts.
- **Delete Contacts**: Users can remove contacts from the list.
- **Search Functionality**: Filter contacts based on name or phone number.
- **Theme Toggling**: Switch between light and dark modes.
- **Responsive Design**: Optimized for different screen sizes using the `flutter_screenutil` package.

## Installation and Setup

To run the Phone Book App on your local machine, follow these steps:

1. **Clone the Repository**

   ```bash
   git clone https://github.com/gboliknow/phone_book_app.git
   cd phone_book_app
Install Dependencies

Ensure you have Flutter installed and configured. Then, run:

bash
Copy code
flutter pub get
Run the App

Use the following command to start the app:

bash
Copy code
flutter run
Run Tests

To execute the tests, use:

bash
Copy code
flutter test
Usage
Adding a Contact
Tap the floating action button (FAB) on the home screen or use the "Add Contact" button in the header.
Enter the contact details in the form and press "Add Contact" to save.
Editing a Contact
Tap on a contact from the list.
Update the contact details in the form and press "Save Changes" to apply the modifications.
Deleting a Contact
While editing a contact, tap the delete icon (trash can) in the app bar.
Confirm the deletion in the dialog that appears.
Searching for Contacts
Use the search bar at the top of the contact list to filter contacts by name or phone number.
Toggling Themes
To switch between light and dark themes, use the theme toggle button (if implemented) or update the theme in the app settings.
Assumptions and Decisions

Data Source: Contacts are initially loaded from a predefined JSON string for demo purposes. In a real-world scenario, this would be replaced with a backend service.
State Management: The app uses the hooks_riverpod package for state management, providing a clean and reactive approach.
Theming: The app supports both light and dark themes, with the ability to toggle between them.
Responsive Design: The app uses the flutter_screenutil package to ensure proper scaling and responsiveness across different screen sizes.
