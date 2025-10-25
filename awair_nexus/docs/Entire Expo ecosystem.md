# Master Guide: Building Mobile Apps with Expo

This document is the master reference for developing, building, and deploying mobile applications using the Expo framework.

## 1. What is Expo?

Expo is an open-source framework and a set of tools built around React Native. Its primary goal is to simplify and accelerate the mobile app development process.

*   **Key Idea:** It allows you to write your app in JavaScript/TypeScript and handles the complex native iOS and Android configuration for you.
*   **Expo SDK:** A library of pre-built native modules (like Camera, Location, Authentication) that you can use with simple JavaScript calls.
*   **Expo Go:** A client app for your physical phone that lets you instantly run and test your project without needing Xcode or Android Studio.
*   **EAS (Expo Application Services):** A cloud service for building and submitting your app to the Apple App Store and Google Play Store.

---

## 2. Getting Started: The Development Workflow

### Step 1: Create a New Project

To start a new project, use the `create-expo-app` command in your terminal.

```bash
# This will create a new project in a folder named "my-awesome-app"
npx create-expo-app my-awesome-app

# Navigate into your new project directory
cd my-awesome-app
```

### Step 2: Run the Development Server

The development server is the heart of the Expo workflow. It bundles your JavaScript code and serves it to the Expo Go app.

```bash
# Start the development server
npx expo start```

This will do two things:
1.  Open a new tab in your web browser with the **Expo Dev Tools**.
2.  Show a **QR Code** in your terminal.

### Step 3: Run the App on Your Phone

1.  Download the **Expo Go** app from the App Store or Play Store on your physical device.
2.  Make sure your phone and your computer are on the **same Wi-Fi network**.
3.  Scan the QR code from the terminal using your phone's camera (or the scanner in the Expo Go app).

Your app will now load and run inside Expo Go. Every time you save a file in VS Code, the app will **hot-reload** with the new changes instantly.

---

## 3. Core Concepts and Project Structure

*   **`app.json`:** The central configuration file for your project. This is where you set your app's name, icon, splash screen, version, and permissions.
*   **`package.json`:** Manages your project's JavaScript dependencies (libraries) and defines scripts.
*   **`app` directory:** This is where your app's code lives. Expo uses **file-based routing** with `expo-router`. This means the file structure inside the `app` directory defines the navigation of your app.
    *   `app/index.js`: The home screen of your app.
    *   `app/settings.js`: Creates a screen accessible at the `/settings` route.
    *   `app/_layout.js`: The root layout of your app. It defines shared UI elements like a header or tab bar.

---

## 4. Building the User Interface (UI)

Expo uses components from React Native to build the UI.

### Basic Components

*   **`<View>`:** The most fundamental building block. It's a container that supports layout with Flexbox, styling, and touch handling. Think of it as a `<div>` in web development.
*   **`<Text>`:** Used to display text. All text must be inside a `<Text>` component.
*   **`<Image>`:** Used to display images.
*   **`<TextInput>`:** A component for entering text.
*   **`<Pressable>` / `<TouchableOpacity>`:** Wrappers that make other components tappable and interactive.

### Styling

Styling is done using JavaScript objects with a `StyleSheet.create` call. It looks like CSS but is not CSS.

```jsx
import { StyleSheet, Text, View } from 'react-native';

export default function App() {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Hello, World!</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1, // Take up all available screen space
    backgroundColor: '#fff',
    alignItems: 'center', // Center children horizontally
    justifyContent: 'center', // Center children vertically
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333',
  },
});
```

### Layout with Flexbox

Flexbox is the primary way to create layouts.
*   `flex: 1`: Makes a component expand to fill all available space. The root `<View>` should almost always have this.
*   `flexDirection`: `'column'` (default) or `'row'`.
*   `justifyContent`: Aligns children along the primary axis (`flexDirection`).
*   `alignItems`: Aligns children along the secondary axis.

---

## 5. Navigation with `expo-router`

`expo-router` is a file-system based router that simplifies navigation.

### Example File Structure:

```
app/
 ├── _layout.js      # Main app layout (e.g., defines tabs)
 ├── index.js        # The first tab (Home screen)
 ├── profile.js      # The second tab (Profile screen)
 └── (modal)/details.js # A modal screen
```

### Navigating Between Screens

`expo-router` provides hooks to navigate.

```jsx
import { Link, router } from 'expo-router';
import { Pressable, Text } from 'react-native';

// Method 1: Using the Link component (like an <a> tag)
<Link href="/profile">
  <Text>Go to Profile</Text>
</Link>

// Method 2: Programmatic navigation
<Pressable onPress={() => router.push('/profile')}>
  <Text>Go to Profile</Text>
</Pressable>
```

---

## 6. Using Native Device Features (Expo SDK)

To use any native device feature, you **MUST** install its library using `npx expo install`. Do not use `npm install`.

```bash
# Example: Install the Camera library
npx expo install expo-camera

# Example: Install the Location library
npx expo install expo-location
```
`npx expo install` ensures you get the version of the library that is compatible with your version of the Expo SDK.

### Common APIs

#### Permissions
Before you can use a feature, you must ask for permission.

```jsx
import { Camera } from 'expo-camera';
import { useEffect, useState } from 'react';

export default function MyCameraComponent() {
  const [permission, requestPermission] = Camera.useCameraPermissions();

  if (!permission) {
    // Permissions are still loading
    return <View />;
  }

  if (!permission.granted) {
    // Permission has not been granted
    return (
      <View>
        <Text>We need your permission to show the camera</Text>
        <Button onPress={requestPermission} title="Grant Permission" />
      </View>
    );
  }
  
  return <Camera style={{ flex: 1 }} />;
}
```

#### SecureStore
A way to store small, sensitive pieces of data (like auth tokens) securely on the device.

```jsx
import * as SecureStore from 'expo-secure-store';

// Save a value
await SecureStore.setItemAsync('authToken', 'your-secret-token');

// Read a value
const token = await SecureStore.getItemAsync('authToken');
```

---

## 7. Configuration (`app.json`)

This file controls the native parts of your app.

```json
{
  "expo": {
    "name": "My Awesome App", // App name
    "slug": "my-awesome-app", // Unique identifier
    "version": "1.0.0",       // App version
    "orientation": "portrait",
    "icon": "./assets/icon.png", // Path to app icon
    "splash": {
      "image": "./assets/splash.png", // Path to splash screen image
      "resizeMode": "contain",
      "backgroundColor": "#ffffff"
    },
    "ios": {
      "supportsTablet": true,
      "bundleIdentifier": "com.company.myawesomeapp" // Your unique app ID on iOS
    },
    "android": {
      "adaptiveIcon": {
        "foregroundImage": "./assets/adaptive-icon.png",
        "backgroundColor": "#ffffff"
      },
      "package": "com.company.myawesomeapp" // Your unique app ID on Android
    },
    "plugins": [ // For configuring native permissions
      [
        "expo-camera",
        {
          "cameraPermission": "Allow $(PRODUCT_NAME) to access your camera."
        }
      ]
    ]
  }
}
```

---

## 8. Building and Deploying with EAS

When you are ready to send your app to others or publish it, you need to create a standalone app file (`.ipa` for iOS, `.apk` or `.aab` for Android). This is done with **EAS (Expo Application Services)**.

### Step 1: Install the EAS CLI

```bash
npm install -g eas-cli
```

### Step 2: Log In and Configure

```bash
# Log in to your Expo account
eas login

# Configure your project to use EAS
eas configure
```

### Step 3: Build the App

This command will upload your code to Expo's cloud servers, which will build the native app file for you. You do not need a Mac to build an iOS app.

```bash
# Build for Android
eas build --platform android

# Build for iOS
eas build --platform ios

# Build for both
eas build --all
```

The CLI will guide you through the process. Once complete, you will get a link to download your app file.

### Step 4: Submit to Stores

EAS can even handle the submission process.

```bash
# Submit your latest Android build to the Google Play Store
eas submit --platform android

# Submit your latest iOS build to the Apple App Store
eas submit --platform ios
```

---

## 9. Debugging and Troubleshooting

When an error occurs, follow this checklist.

1.  **Read the Red Screen:** The error message on your phone is the most important clue. Read it carefully. It will tell you:
    *   **What** the error is (e.g., `undefined is not an object`).
    *   **Where** the error is (the file and line number in the stack trace).

2.  **Check the Terminal:** The terminal where you ran `npx expo start` will have detailed logs and the same error message.

3.  **Use `console.log()`:** The oldest and most reliable debugging tool. You can print the value of any variable to the terminal logs.

    ```js
    const MyComponent = (props) => {
      console.log("These are the props:", props); // Check what's inside props
      return <Text>{props.user.name}</Text>;
    }
    ```

4.  **Open the Developer Menu:**
    *   On your phone, **shake the device** or **press `m`** in the terminal.
    *   This menu allows you to manually reload the app, inspect elements, and connect to a debugger.

5.  **When in Doubt, Restart:** If something seems off and there's no error, stop the server (Ctrl+C) and restart it with a cleared cache:

    ```bash
    npx expo start -c
    ```

---

## 10. The "Bare" Workflow (Advanced Topic)

While Expo handles most native code, sometimes you might need a very specific native library that doesn't have an Expo equivalent. In this case, you can "eject" to the **bare workflow**.

*   **Command:** `npx expo prebuild`
*   **What it does:** This command generates the native `ios` and `android` project folders, just like a standard React Native project would have.
*   **Consequence:** You are now responsible for managing the native code. You can no longer use Expo Go. You must run the app using Xcode and Android Studio directly.
*   **When to do this:** Only as a last resort, when there is absolutely no other way to achieve a feature with the Expo managed workflow. It's an irreversible step for most projects.