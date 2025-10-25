I'll create a comprehensive markdown file with all the hoisting information. Here's the complete guide:

```markdown
# JavaScript Hoisting - Complete Guide

## What is Hoisting?

Hoisting makes some types of declarations accessible in a JavaScript scope even before they are written in the code.

**Key Insight**: Only the **declaration** is moved to the top, not the **initialization**.

---

## 📊 Hoisting Behavior Table

| Declaration Type | Result When Accessed Before Declaration | Notes |
|------------------|------------------------------------------|-------|
| `var myVar` | `undefined` | Hoisted but initialized with `undefined` |
| `let myLet` | `ReferenceError` | Hoisted but in Temporal Dead Zone (TDZ) |
| `const myConst` | `ReferenceError` | Hoisted but in Temporal Dead Zone (TDZ) |
| `function myFunc() {}` | Function is available and callable | Fully hoisted |
| `class MyClass` | `ReferenceError` | Hoisted but in TDZ |
| `import` statements | Available throughout module | Fully hoisted |
| Function parameters | Available in function scope | Hoisted within function |

---

## 🔍 Detailed Examples

### 1. Variable Hoisting

#### `var` - Hoisted but initialized with `undefined`
```javascript
console.log(myVar); // Output: undefined
var myVar = 10;
console.log(myVar); // Output: 10
```

#### `let`/`const` - Temporal Dead Zone (TDZ)
```javascript
console.log(myLet); // ❌ ReferenceError: Cannot access 'myLet' before initialization
let myLet = 20;
```

### 2. Function Hoisting

#### Function Declarations - Fully Hoisted
```javascript
greet(); // Output: "Hello!"
function greet() {
  console.log("Hello!");
}
```

#### Function Expressions - NOT Fully Hoisted
```javascript
sayHello(); // ❌ TypeError: sayHello is not a function
var sayHello = function() {
  console.log("Hello!");
};
```

#### Arrow Functions - NOT Hoisted
```javascript
sayHi(); // ❌ ReferenceError or TypeError
const sayHi = () => console.log("Hi!");
```

### 3. Class Hoisting
```javascript
const person = new Person(); // ❌ ReferenceError
class Person {}
```

### 4. Import Hoisting (ES6 Modules)
```javascript
// Imported modules are hoisted to the top
console.log(myFunction); // Works if myFunction is imported
import { myFunction } from './myModule.js';
```

---

## 🆚 `var` vs `let`/`const` - The Key Difference

### `var` Behavior
- **Hoisted**: Yes
- **Initial Value**: `undefined`
- **Scope**: Function scope
- **Can be re-declared**: Yes

```javascript
console.log(x); // undefined
var x = 5;
var x = 10; // No error
```

### `let`/`const` Behavior
- **Hoisted**: Yes, but in TDZ
- **Initial Value**: No initial value (TDZ)
- **Scope**: Block scope
- **Can be re-declared**: No

```javascript
console.log(x); // ❌ ReferenceError
let x = 5;
let x = 10; // ❌ SyntaxError
```

---

## 📋 Complete List: What Gets Hoisted vs What Doesn't

### ✅ GETS HOISTED
- `var` declarations
- Function declarations
- Class declarations
- Import statements
- Function parameters
- `arguments` object (in regular functions)

### ❌ DOES NOT GET HOISTED
- `let`/`const` assignments (only declarations are hoisted)
- Arrow functions
- Function expressions
- Variable assignments
- Export statements

---

## 🎯 The Temporal Dead Zone (TDZ)

The TDZ is the period between entering a scope and the actual declaration of a variable.

```javascript
// Start of TDZ for myLet
console.log(myLet); // ❌ ReferenceError (in TDZ)
// ...
// ...
let myLet = 10;     // End of TDZ for myLet
console.log(myLet); // ✅ Works (10)
```

---

## 🏆 Best Practices

### ✅ DO
- Use `const` for values that won't change
- Use `let` for values that will change
- Declare variables at the top of their scope
- Initialize variables when declaring them
- Use function declarations for hoisted functions

### ❌ AVOID
- Using `var` in modern JavaScript
- Relying on hoisting for variable access
- Using variables before declaration
- Using function expressions if you need hoisting

### Good Code Structure:
```javascript
// 1. Declare and initialize variables at top
const config = { apiUrl: '...' };
let isLoading = false;

// 2. Declare functions
function fetchData() {
  // function body
}

// 3. Main execution code
fetchData();
```

---

## 🧪 Quick Reference Examples

```javascript
// Test your understanding:
console.log(a);     // undefined
console.log(b());   // 2
console.log(c);     // ReferenceError

var a = 1;
function b() { return 2; }
let c = 3;
```

---

## 🔍 Common Pitfalls

### 1. Loop with `var`
```javascript
for (var i = 0; i < 3; i++) {
  setTimeout(() => console.log(i), 100); // Output: 3, 3, 3
}
```

### 2. Loop with `let` (fixed)
```javascript
for (let i = 0; i < 3; i++) {
  setTimeout(() => console.log(i), 100); // Output: 0, 1, 2
}
```

### 3. Function in Block
```javascript
if (true) {
  function test() { return "A"; }
} else {
  function test() { return "B"; }
}
test(); // Result varies by browser - avoid this pattern!
```

---

## 💡 Key Takeaways

1. **Hoisting moves declarations, not assignments**
2. **`let`/`const` are safer than `var`** due to TDZ
3. **Function declarations are fully hoisted**
4. **Always declare variables before using them**
5. **Use modern JavaScript features (`let`/`const`)**

---

*Remember: Understanding hoisting helps prevent bugs and write more predictable JavaScript code!*
```

You can copy this entire markdown content and save it as `javascript-hoisting-guide.md` on your computer. This file contains all the information we discussed in a well-organized format that you can reference anytime!