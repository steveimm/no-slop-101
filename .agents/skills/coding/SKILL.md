---
name: coding
description: rules and instructions when doing coding implementations
---

This skill describes coding rules and instructions that you must follow. However, user request in a session takes higher precedence.

# Algorithm Design
- Simple is always the best
  - Pursue the most boring but robust solution
  - When you have multiple alternatives of implementing something, default to the simplest one unless you have a good reason not to
  - In such case, prompt the user to check first before proceeding                                                                                                            
- As modular as needed, emphasize on needed
  - Do not implement very specific algorithm to support just one edge case, it will break on others
  - Group related functions into one module, otherwise split into different files
- Never duplicate codes
  - Before implementing something new, check if the feature already exists and reuse it
  - If something similar but not exactly the same exists, check if it's worth to refactor the implementation to support all at once


# Testing
- Test implementation comes later during refining
  - Initial implementation requires iteration with user which will break tests if you implement to early, wasting time
  - However, you may test your code in a temporary scratchpad to confirm your implementation if needed
- Test code coverage is NOT a priority
  - Do not add trivial tests just to make the test suite cover all lines of code
  - Test the actual use cases of the features and the edge cases
  - Quality over quantity

# Project Configuration
Utilize CLI as much as possible, do not edit project configuration and dependencies on your own unless it is necessary. 

Examples:
- Use `uv init` to instantiate project, don't write the `pyproject.toml` manually
- Use `uv add` to add new dependencies, don't manually edit the `pyproject.toml` to add new library. You do NOT know the latest version
- Do not edit lock files directly, regenerate instead

# Style
- Your code is NOT a scratch pad 
  - Excessive comment blocks are strictly prohibited
  - Only add comment when it is absolutely needed, even then 2-line comment is maximum
- If you add comment, make it brief, concise, as long as it conveys the meaning well
  - It does not have to be a complete full sentence
- Do not split your code lines into 80 col max, 120-140 col is fine
  - When there are too many params in functions, if it exceeds the 140 col, use trailing commas and make each param consumes one line
  - Same case for when calling the function 
- Add single blank line to indicate sections within a code, increasing readability

Bad example:
```python
def quicksort(arr):
    if len(arr) <= 1:
        return arr
    pivot = arr[len(arr) // 2]
    left = [x for x in arr if x < pivot]
    middle = [x for x in arr if x == pivot]
    right = [x for x in arr if x > pivot]
    return quicksort(left) + middle + quicksort(right)
```
Good example:
```python
def quicksort(arr: list[int]) -> list:
    """
    Sort a list of integers ascending using quick sort

    Args:
        arr: list of integers
    Returns:
        Sorted list in ascending order
    """
    if len(arr) <= 1:
        return arr

    pivot = arr[len(arr) // 2]
    left = [x for x in arr if x < pivot]
    middle = [x for x in arr if x == pivot]
    right = [x for x in arr if x > pivot]

    return quicksort(left) + middle + quicksort(right)
```

## Python-specific
- When writing strings, 
  - In case of multi-lines, use triple-quotes
  - In case of a long one-line strings, do NOT split into multilines using string literal concatenation
- Don't add `__init__` in a module when not needed, this is prone to circular import
- Every parameter must be clearly typed
- No module-level docstring, filename and structure should be clear enough
- Every func must have docstring following google style 
  - 1-2 lines brief explanation in the beginning, followed by args, returns, exception, etc.     
  - Don't mention the type in args explanation, the param type already explain that
  - Exception is built-in functions override like `__enter__`, `__repr__`, etc. You may omit docstring on those, but if there is a specific reason/explanation to be added, then include docstring
- Each entry in `__all__` inside `__init__` must go on its own line, even if the whole list fit within 140 col

