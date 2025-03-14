# FakeGithubProj

A modern GitHub client built with SwiftUI and Swift Package Manager (SPM), featuring Face ID authentication and GitHub API integration.

## Features

- **Authentication**
  - Username/password login
  - Face ID support
  - Secure logout functionality

- **GitHub Integration**
  - User profile information retrieval
  - Repository search functionality
  - Personal repository listing
  - Avatar loading with Kingfisher

- **UI/UX**
  - Custom UI components (buttons, user cards, repository lists)
  - Dark mode support
  - Human Interface Guidelines compliant
  - Responsive design
  - XCAssets for resource management

- **Testing**
  - Comprehensive unit tests
  - UI test coverage

## Project Structure

FakeGithubProj/
├── Sources/
│   ├── App/
│   ├── Authentication/
│   ├── Models/
│   ├── Network/
│   ├── UI/
│   └── Utils/
├── Tests/
│   ├── UnitTests/
│   └── UITests/
└── Resources/
└── Assets.xcassets/

## Dependencies

- **Swift Package Manager (SPM) packages:**
  - Kingfisher: For efficient image loading and caching
  - Other dependencies will be automatically managed by SPM

## Getting Started

1. Clone the repository
```bash
git clone https://github.com/yourusername/FakeGithubProj.git
cd FakeGithubProj

2. Open the project in Xcode
```bash
open FakeGithubProj.xcodeproj
 ```

3. Build and run the project
### Testing Credentials
- Username: Any valid GitHub username (e.g., "targetkiller")
- Password: "password"
## API Endpoints
The app uses the following GitHub API endpoints:

- User Info: https://api.github.com/users/{username}
- Repository Search: https://api.github.com/search/repositories?q={query}
- User Repositories: https://api.github.com/users/{username}/repos

## Requirements
- iOS 14.0+
- Xcode 13.0+
- Swift 5.5+

## License
This project is licensed under the MIT License - see the LICENSE file for details.

## Contributing
Contributions are welcome! Please feel free to submit a Pull Request.
