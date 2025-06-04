# User Management System with Flutter and PostgREST

A complete solution for user authentication and profile management using Flutter for the frontend and PostgREST as the backend API layer for PostgreSQL.

## Project Architecture
┌─────────────────┐ ┌───────────────┐ ┌──────────────┐
│ Flutter App │──────▶│ PostgREST API │──────▶│ PostgreSQL │
└─────────────────┘ HTTP └───────────────┘ └──────────────┘
### Flutter App: Handles the user interface and user interaction. It communicates with the PostgREST API for data operations.

### PostgREST API: Provides a RESTful API directly on top of the PostgreSQL database. It handles requests from the Flutter app, executes database operations, and returns responses.

### PostgreSQL: The relational database storing user information, profiles, and other relevant data.

## ✨ Features
  View User Profile

  Edit/Update User Profile

  Delete User Profile

## 🛠️ Tech Stack
  Frontend: Flutter (Cross-platform UI toolkit)

  Backend API: PostgREST (Serves a RESTful API from any PostgreSQL database)

  Database: PostgreSQL (Powerful, open-source object-relational database system)

