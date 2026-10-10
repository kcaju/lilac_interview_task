# Expenzia - Expense Management Application

A modern, responsive, and feature-rich Flutter expense tracking and credit management application built with **Provider** for state management and **SQLite (`sqflite`)** for reliable local database persistence.

---

## 📱 Features

### 1. **Onboarding & Splash Flow**
- **Splash Screen**: Animated branded introduction.
- **Onboarding Screen**: Clean illustration with direct navigation to the main application.

### 2. **Custom Bottom Navigation & Docked Action Button**
- **Custom Docked Navigation Bar**: Built with active and inactive PNG asset icons for all tabs (Home, History, Credit, Profile).
- **Center Add Action Button**: Styled docked Floating Action Button (`+`) for rapid transaction entry.
- **Keyboard-Aware Layout**: Automatically docks and hides cleanly when the virtual keyboard is active, preventing viewport jumping.

### 3. **Home Dashboard**
- **Balance Card**: Gradient teal card displaying real-time Total Balance (`Income - Expenses`).
- **Income & Expense Summary**: Real-time totals with directional indicator icons.
- **Analytics Metrics**: Dynamic calculation of **Daily Average** spending and **Weekly** totals.
- **Recent Transactions**: Quick snapshot of latest entries with color-coded badges (Green for `+ Income`, Red for `- Expense`).
- **Empty State**: Custom friendly illustrations when no records exist.

### 4. **Transaction Management (CRUD)**
- **Add Transactions**: Enter title, amount, type (`Income` / `Expense`), and pick dates.
- **Themed Date Picker**: Full teal color theme matching the app aesthetic (header, selection ring, buttons).
- **Active Focus Fields**: Input fields glow with an active teal border and shadow upon tapping/typing.
- **Validation**: Strict inline validation for names, valid positive numbers, and dates.
- **Transaction History**: View all historical records with a single-tap toggle to reveal **Edit (✏️)** and **Delete (🗑️)** actions.
- **Edit Transactions**: Pre-populated form to update any transaction details in the database.

### 5. **Credit & Due Date Tracker**
- **Credit / Dues Entry**: Track subscriptions (`Netflix`, `Spotify`), loans, bills, and personal dues.
- **Dynamic Due Date Calculation**:
  - Automatically identifies if a due date is today $\rightarrow$ displays **`Due Today`** (with **`Today`** highlighted in coral red).
  - Displays **`Due On DD/MM/YY`** in muted gray for future scheduled dues.
- **Swipe-to-Delete**: Swipe left on any saved credit tile to dismiss and delete from SQLite.

### 6. **Profile & Data Management**
- **Profile Screen**: User details and avatar badge.
- **Clear Storage**: One-tap SQLite database reset with safety confirmation dialog.

### 7. **UX & Interaction Polish**
- **Tap-to-Dismiss Keyboard**: Tapping anywhere outside an active text field instantly closes the keyboard.
- **Scroll-to-Dismiss**: Dragging or scrolling dismisses on-screen input focus naturally.

---

## 🛠️ Tech Stack & Dependencies

| Dependency | Version | Purpose |
| :--- | :--- | :--- |
| **Flutter SDK** | `^3.13.3` | Cross-platform framework |
| **provider** | `^6.1.5+1` | Reactive state management |
| **sqflite** | `^2.4.3` | SQLite database persistence for Android, iOS, & desktop |
| **path** | `^1.9.0` | File system path utilities for SQLite database |
| **cupertino_icons** | `^1.0.8` | iOS style icons support |

---

## 📁 Project Structure

```text
lib/
├── controller/
│   ├── bottomnav_controller.dart  # Bottom navigation tab index controller
│   ├── database_helper.dart      # SQLite database initialization & CRUD operations
│   └── expense_provider.dart      # Global reactive state provider for transactions & credits
├── model/
│   ├── credit_model.dart          # Credit & dues model with dynamic date parsing
│   └── transaction_model.dart     # Income/Expense transaction model
├── view/
│   ├── bottom_nav_screen.dart     # Main scaffolding with docked FAB & navigation
│   ├── credit_screen.dart         # Credit / Dues tracking and saved lists
│   ├── edit_transaction_screen.dart # Edit existing transaction screen
│   ├── history_screen.dart        # Transaction history with inline edit/delete actions
│   ├── home_screen.dart           # Dashboard overview, balance card, and recent list
│   ├── onboarding_screen.dart     # Onboarding welcome screen
│   ├── profile_screen.dart        # Profile overview & Clear database storage
│   ├── splash_screen.dart         # Splash screen
│   └── transaction_screen.dart    # Add new income / expense transaction
├── widgets/
│   ├── custom_button.dart         # Standardized elevated button
│   ├── custom_dropdown_field.dart # Dropdown input selector
│   ├── custom_header.dart         # App bar header with optional back navigation
│   ├── custom_input_field.dart    # Active teal border & focused text input
│   ├── empty_state_widget.dart    # Reusable empty list placeholder
│   ├── saved_credit_tile.dart     # Formatted credit & due date tile
│   └── transaction_tile.dart      # Transaction item with color-coded amount
└── main.dart                      # App entry point, MultiProvider setup & global theme
```

---

## 🚀 Setup & Installation Instructions

### Prerequisites
- **Flutter SDK** installed (version `>= 3.13.3`). Check with:
  ```bash
  flutter --version
  ```
- **Dart SDK** installed.
- Android Studio / Xcode / VS Code with Flutter extension.
- Connected physical device or emulator/simulator.

### Step 1: Clone the Repository
```bash
git clone <repository-url>
cd lilac_interview_task
```

### Step 2: Install Dependencies
Run the following command in the project root:
```bash
flutter pub get
```

### Step 3: Verify Setup & Code Integrity
Run the static analyzer to ensure everything is configured properly:
```bash
flutter analyze
```

### Step 4: Run the App
Launch on an active device or emulator:
```bash
flutter run
```

---

## 🎨 Color Palette

- **Primary Teal**: `#2F7E79`
- **Secondary Teal**: `#3F877D`
- **Background Ring**: `#D4E7E3`
- **Income (Green)**: `#25A969`
- **Expense / Urgency (Red/Coral)**: `#F95B51` / `#EF4444`
- **Dark Text**: `#1E1E1E`
- **Muted Text / Borders**: `#9CA3AF` / `#D1D5DB`
