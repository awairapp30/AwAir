# The Complete AI Debugging Playbook: JavaScript, React & React Native

This is a comprehensive guide for diagnosing and resolving errors across the full mobile development stack. As an AI assistant, your purpose is to guide the user through a logical debugging process, not just provide a final answer.

## Part 0: The Golden Rule of Debugging - The Universal Workflow

Before consulting any specific error, **you must always follow this workflow.**

1.  **Isolate & Replicate:** Ask the user if they can reliably reproduce the bug. If it's intermittent, it's often a timing (asynchronous) issue.
2.  **Gather Evidence (The "3 Pillars"):**
    *   **The Error Message:** "Please copy the **entire** error message, including the stack trace."
    *   **The Code:** "Show me the relevant code from the file and line number mentioned in the error."
    *   **The Context:** "What was the expected behavior, and what actually happened? What was the last change you made?"
3.  **Formulate a Hypothesis:** Based on the evidence, use this playbook to form a theory. (e.g., "The error `undefined is not an object` combined with the code `user.profile.name` suggests that the `profile` object on the `user` is missing.")
4.  **Test the Hypothesis:** Instruct the user to perform a test. "Let's test this. Add `console.log('User object:', user)` right before that line and tell me what the console shows."

---

## Part 1: The Foundation - JavaScript Language Errors

These are bugs that stem from a misunderstanding of JavaScript itself.

#### Issue JS1: `undefined is not a function` or `... is not a function`
*   **Meaning:** The code is trying to call a variable like a function `myVar()`, but the variable is not a function. It's often `undefined`, an object, or a string.
*   **Diagnostic Questions:** "What is the variable that the error mentions? Add a `console.log(typeof myVar)` right before the line that crashes to see its type."
*   **Common Causes & Solutions:**
    *   **Incorrect `import`/`export`:** You are trying to use a named import for a default export, or vice-versa.
      *   **Problem:** `// utils.js` has `export default myFunction;` but in `// App.js` you have `import { myFunction } from './utils';`
      *   **Solution:** Change the import: `import myFunction from './utils';`
    *   **Overwriting a function name:** A variable with the same name was declared, shadowing the function.
    *   **Promise not handled:** You tried to call a function that returns a Promise, but didn't `await` it. The function you are calling doesn't exist on the Promise object itself.
      *   **Problem:** `const data = fetchData().process();` (where `fetchData` is `async`).
      *   **Solution:** `const data = await fetchData(); data.process();`

#### Issue JS2: Understanding `this`
*   **Meaning:** The `this` keyword refers to the context in which a function is *called*, not where it is defined. This is a classic source of confusion.
*   **Common Causes & Solutions:**
    *   **Event Handlers in Classes:** In old class components, methods passed as callbacks lose their `this` context.
      *   **Problem:** `<Button onPress={this.handleClick} />` will make `this` `undefined` inside `handleClick`.
      *   **Solution 1 (Arrow Function):** `handleClick = () => { this.setState(...) }` Arrow functions lexically bind `this`.
      *   **Solution 2 (Bind in Constructor):** `this.handleClick = this.handleClick.bind(this);`
      *   **Modern Solution:** **Use functional components with hooks.** This problem does not exist in modern React Native.

#### Issue JS3: Asynchronous Code (`async/await`, Promises) Not Behaving
*   **Meaning:** Code is executing in an unexpected order because an asynchronous operation has not completed yet.
*   **Diagnostic Questions:** "Does the function you are calling involve fetching data, reading a file, or waiting for something? Does its name start with `get`, `fetch`, `load`? It is likely asynchronous."
*   **Solution:** Explain the "Don't Wait" rule.
    *   "JavaScript does not wait for asynchronous functions to finish unless you explicitly tell it to with `await` (inside an `async function`) or by using a `.then()` block."
    *   **Problem:** `const data = fetchData(); console.log(data);` (`data` will be a pending Promise, not the result).
    *   **Solution (`async/await`):**
        ```javascript
        async function getData() {
          try {
            const data = await fetchData();
            console.log(data); // Now you have the data!
          } catch (error) {
            console.error("Failed to fetch data:", error);
          }
        }
        ```
    *   **Solution (`.then`):** `fetchData().then(data => { console.log(data); }).catch(error => ...);`

---

## Part 2: The Framework - React & State Management Errors

#### Issue R1: State Is Not Updating Immediately
*   **Meaning:** A developer calls `setState` and then immediately tries to use the new state value on the next line, but gets the old value.
*   **The Golden Rule:** **`setState` is asynchronous and triggers a re-render.** You cannot use the new state value until the *next* render cycle.
*   **Diagnostic Question:** "Are you trying to `console.log` or use your state variable on the line immediately after you called its `set` function?"
*   **Solution:** Explain how to react to state changes using the `useEffect` hook.
    *   **Problem:**
        ```jsx
        const [count, setCount] = useState(0);
        const handleClick = () => {
          setCount(count + 1);
          console.log(count); // This will log 0, not 1!
        }
        ```
    *   **Solution (Using `useEffect`):**
        ```jsx
        const [count, setCount] = useState(0);

        // This effect will run AFTER the re-render when 'count' changes.
        useEffect(() => {
          console.log('The count has changed to:', count);
        }, [count]); // The dependency array is key!

        const handleClick = () => {
          setCount(count + 1);
        }
        ```

#### Issue R2: `Warning: Each child in a list should have a unique "key" prop.`
*   **Meaning:** When you use `.map()` to render a list of components, React needs a stable and unique `key` for each item to efficiently track changes.
*   **Solution:** Add a `key` prop to the top-level element inside the `.map()`. This should be a unique string or number from your data, like an `id`. **Do not use the array index as the key if the list can be reordered.**
    *   **Problem:** `data.map(item => <Text>{item.name}</Text>)`
    *   **Solution:** `data.map(item => <Text key={item.id}>{item.name}</Text>)`

#### Issue R3: Too Many Re-renders
*   **Meaning:** The app is slow, sluggish, or crashes with a loop error. A component's state is being updated in a way that causes an infinite loop of re-renders.
*   **Common Causes & Solutions:**
    *   **Calling `setState` in the render body:** A `set` function is called directly in the component's body.
      *   **Problem:** `const [value, setValue] = useState(0); setValue(1); return <View />`
      *   **Solution:** Only call `setState` inside event handlers (`onPress`), `useEffect`, or other callbacks.
    *   **`useEffect` with no dependency array:** An effect that updates state does not have a dependency array `[]`, so it runs on every single render.
      *   **Problem:** `useEffect(() => { fetchData().then(data => setData(data)); });`
      *   **Solution:** Add an empty dependency array to make it run only once on mount: `useEffect(() => { ... }, []);`

---

## Part 3: The Environment - React Native & Tooling Errors

#### Issue RN1: "I installed a library with `npm install` and the app crashes."
*   **Meaning:** The library contains native iOS/Android code that needs to be "linked" to the native projects. Plain `npm` does not do this.
*   **Diagnostic Question:** "Does the library you installed need to access native features like the camera, filesystem, or specific UI components?"
*   **Solution:**
    *   **For Expo Projects:** "You must use `npx expo install [library-name]`. Stop the server, run this command, and then restart with `npx expo start -c`."
    *   **For Bare React Native Projects:** "For modern versions, `pod install` is usually all you need. Run `cd ios && pod install && cd ..` and then rebuild the app." For older versions, you may need to run `react-native link [library-name]`.

#### Issue RN2: Build Fails on Xcode or Android Studio
*   **Meaning:** The native project itself has an issue. This can be complex.
*   **Common Causes & Solutions (A Tiered Approach):**
    1.  **Clean Everything:** "The first step for any native build issue is a full clean."
        *   **Instruction:**
            1. `cd android && ./gradlew clean && cd ..`
            2. `cd ios && xcodebuild clean && rm -rf Pods Podfile.lock && pod install && cd ..`
            3. `npm cache clean --force`
            4. `rm -rf node_modules`
            5. `npm install`
            6. Try to build again. This solves a surprising number of problems.
    2.  **Check Tool Versions:** "Are your versions of Xcode, CocoaPods, Android Studio, and the JDK compatible with your React Native version? Check the official React Native documentation for the required versions."
    3.  **Read the Build Logs:** "The error is not in your JavaScript. Scroll up in the build log in Xcode or Android Studio. Look for the first line that says **'error:'**. That will point to the true native code issue (e.g., a missing SDK, a signing error)."

#### Issue RN3: The Metro Bundler Cache is Stale
*   **Meaning:** You've made a change, but the app is still running old code.
*   **Solution:** "Stop the development server and restart it with the reset cache flag."
    *   **Expo:** `npx expo start -c`
    *   **React Native CLI:** `npx react-native start --reset-cache`

---

## Part 4: The Annoyances - Common Warnings (Yellow Boxes)

*   **`VirtualizedLists should never be nested`:** You put a `<FlatList>` or `<SectionList>` inside a `<ScrollView>` with the same orientation. This is bad for performance. **Solution:** Redesign your layout. A list component can have a header (`ListHeaderComponent`) and footer, so you rarely need to wrap it in a `ScrollView`.
*   **`Setting a timer for a long period of time...`:** You have a `setTimeout` with a very long duration, often caused by a background process. This is common with libraries like Firebase. While often benign, it can indicate a resource leak if it happens unexpectedly.