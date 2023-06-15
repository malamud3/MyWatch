import AuthenticationServices
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class LoginViewModel {
    
    // MARK: - Properties
    
    let loginManager: LoginManager
    var model: User
    
    // MARK: - Initialization
    
    init(model: User, loginManager: LoginManager) {
        self.model = model
        self.loginManager = loginManager
    }
    
    // MARK: - Actions
    
    func login(with method: AuthMethod, completion: @escaping (Bool, String?) -> Void) async throws {
        switch method {
        case .phone:
            try await loginWithPhoneNumber(completion: completion)
        case .apple:
            // loginWithAppleID(completion: completion)
            break
        case .google:
            try await loginWithGoogle(completion: completion)
        case .sms:
            try await verifyPhoneNumber(completion: completion)
        }
    }
    
    func loginWithPhoneNumber(completion: @escaping (Bool, String?) -> Void) async throws {
        guard let phoneNumber = model.phoneNumber, !phoneNumber.isEmpty else
             {
            completion(false, "Please enter valid phone number and verification code.")
            return
        }
        
         loginManager.login(withPhoneNumber: phoneNumber) { result in
            switch result {
            case .success(let verificationID):
                completion(true, verificationID)
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }
    
    func verifyPhoneNumber(completion: @escaping (Bool, String?) -> Void) async throws{
        
        guard let verificationCode = loginManager.verificationCode else {
            completion(false, "Please enter a valid phone number.") 
            return
        }
        loginManager.verifyPhoneNumber(verificationCode: verificationCode) { result in
            switch result {
            case .success:
                completion(true, nil)
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }

    func loginWithGoogle(completion: @escaping (Bool, String?) -> Void) async throws {
        // Configure Google Sign-In
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        let scenes = await UIApplication.shared.connectedScenes
        let windowScenes = scenes.first as? UIWindowScene
        let window = await windowScenes?.windows.first
        guard let rootViewController = await window?.rootViewController else { return }

        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)

        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }

        let accessToken = gidSignInResult.user.accessToken.tokenString
        
        Task {
            let isGuidedAccessEnabled = UIAccessibility.isGuidedAccessEnabled
            print("Is Guided Access enabled? \(isGuidedAccessEnabled)")
        }
        
        try await loginManager.login(withGoogleIDToken: idToken, accessToken: accessToken) { result in
            switch result {
            case .success:
                completion(true, nil)
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }
}
