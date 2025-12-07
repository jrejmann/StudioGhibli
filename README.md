# GhibliStudio 🎬✨

iOS app that lets you browse Studio Ghibli films, search by keywords, and add your favourite movies for quick access.

The app focuses on modern iOS development practices and leverages Apple’s latest UI and concurrency technologies.

---

## Features

- Browse Studio Ghibli films
- Search films using a search phrase
- Add and manage favourite films
- Fast, responsive UI with smooth animations

<div align="center">
  <img src="https://github.com/user-attachments/assets/ba90bc78-1d7a-42f4-acba-dad27084a37f" width="22%" />
  <img src="https://github.com/user-attachments/assets/83f3d812-a606-4838-9e60-174f98b7391a" width="22%" />
  <img src="https://github.com/user-attachments/assets/cb1b49e4-6cc7-4573-be3d-afda8e35e7d9" width="22%" />
  <img src="https://github.com/user-attachments/assets/4abced8d-be52-4ef3-8869-78b5bb646d1b" width="22%" />
</div>
---

## Tech Stack


This project is built with the latest Apple technologies and modern architecture:

- **Swift 6**
- **iOS 26**
- **Liquid Glass UI**
- **MVVM architecture**
- **Service pattern**
- **Dependency Injection**
- **URLSession with `async/await`**
- **Task Groups** for concurrent data fetching

---

## Architecture

The project is structured around:

- **MVVM (Model–View–ViewModel)** for clear separation of concerns
- A dedicated **service layer** to handle networking and data access
- **Dependency Injection** to make the codebase modular, testable, and easy to maintain

---

## Networking

Networking is handled using:

- `URLSession`
- Swift’s modern concurrency model (`async/await`)
- `TaskGroup` for concurrent fetching of multiple resources

---

## Requirements

- iOS 26.0+
- Xcode 16+
- Swift 6

---

## Note

This project is a code-along variation of Karin’s Prater app and is intended for learning and practice purposes.
