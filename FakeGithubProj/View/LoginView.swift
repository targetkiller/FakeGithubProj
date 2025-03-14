
import SwiftUI
import LocalAuthentication

struct LoginView: View {
    @StateObject private var userSettings = UserSettings.shared
    @State private var username = "targetkiller"
    @State private var password = "password"
    @State private var showError = false
    @State private var errDescription = "Invalid username or password"

    var body: some View {
        VStack {
            Spacer()
            
            Image("github_logo")
                .resizable()
                .frame(width: 80, height: 80)
                .padding(.bottom, 10)
            
            Text("Welcome to Fake Github")
               .font(.system(size: 20, weight: .medium))
               .fontWeight(.bold)
               .padding(.bottom, 20)

            Text("Please input your Github username")
              .font(.subheadline)
              .foregroundColor(.gray)
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(.horizontal, 30)

            TextField("Username", text: $username)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal, 30)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal, 30)
            .padding(.bottom, 10)

            if showError {
                Text(errDescription)
                    .foregroundColor(.red)
                    .padding(.bottom, 10)
            }

            Button("Login") {
                if username.isEmpty {
                    errDescription = "Username cannot be empty"
                    showError = true
                } else if password == "password" {
                    UserSettings.shared.username = username
                    UserSettings.shared.isAuthenticated = true
                } else {
                    errDescription = "Incorrect password"
                    showError = true
                }
            }

            Button("Login with Face ID") {
                authenticateUser()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.top, 40)
            
            Spacer()
        }
        .background(Color(.systemBackground))
    }

    private func authenticateUser() {
        let context = LAContext()
        var error: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            DispatchQueue.main.async {
                errDescription = "Biometric authentication is not available"
                showError = true
            }
            return
        }
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Login with Face ID") { success, error in
            DispatchQueue.main.async {
                if let error = error {
                    errDescription = "Authentication failed: \(error.localizedDescription)"
                    showError = true
                    return
                }
                
                if username.isEmpty {
                    errDescription = "Username cannot be empty"
                    showError = true
                } else if success {
                    UserSettings.shared.username = username
                    UserSettings.shared.isAuthenticated = true
                }
            }
        }
    }
}
