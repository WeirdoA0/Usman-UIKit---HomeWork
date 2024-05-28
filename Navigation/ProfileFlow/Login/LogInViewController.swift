//
//  LogInViewController.swift.swift
//  Navigation
//
//  Created by Руслан Усманов on 06.10.2023.
//

import UIKit
import StorageService
class LogInViewController: UIViewController, UITextFieldDelegate {
    
    var loginDelegate: LoginViewControllerDelegate?
    var biometricService: LocalAuthorizationService? = LocalAuthorizationService()
    
    //MARK: SubViews
    
    private lazy var biometricButton: UIButton = CustomButton(title: "" , textColor: .customTintColor, backColor: nil, closure: { [weak self] in
            self?.biometricService?.authorizeIfPossible({ [weak self] bool in
                guard let self else { return }
                if bool{
                    authorizationFinished()
                }
            })
        })
    
    private lazy var biometricButtonLabel: UILabel = {
       let lbl = UILabel()
        lbl.text = NSLocalizedString("Auth with", comment: "")
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = .customTintColor
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.isScrollEnabled = true
        
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = view.bounds
        view.backgroundColor = .customViewBackGroundColor
        
        return view
    }()
    
    private lazy var VKLogo: UIImageView = {
        
        
        let image = UIImage(named: "logo")
        let newImage = UIImageView(image: image)
        
        newImage.translatesAutoresizingMaskIntoConstraints = false
        
        return newImage
    }()
    
    private lazy var loginPasswordField: UIStackView =  {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.clipsToBounds = true
        
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        stackView.layer.masksToBounds = true
        
        stackView.addArrangedSubview(loginField)
        
        let grayView: UIView = UIView()
        grayView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        grayView.backgroundColor = UIColor.lightGray
        
        stackView.addArrangedSubview(grayView)
        
        stackView.addArrangedSubview(passwordField)
        
        return stackView
    }()
    
    private lazy var loginField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        
        text.backgroundColor = .customViewBackGroundColor
        text.font = UIFont.systemFont(ofSize: 16)
        text.tintColor = .customTintColor
        text.autocapitalizationType = .none
        
        text.keyboardType = UIKeyboardType.default
        text.clearButtonMode = .whileEditing
        text.returnKeyType = UIReturnKeyType.done
        text.contentVerticalAlignment = .center
        
        text.placeholder = NSLocalizedString("Email or phone", comment: "")
        text.text = "login@gmail.com"
        
        text.delegate = self
        
        return text
    }()
    private lazy var passwordField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        
        text.backgroundColor = .customViewBackGroundColor
        text.textColor = .customTintColor
        text.font = UIFont.systemFont(ofSize: 16)
        text.autocapitalizationType = .none
        
        text.keyboardType = UIKeyboardType.default
        text.clearButtonMode = .whileEditing
        text.returnKeyType = UIReturnKeyType.done
        text.contentVerticalAlignment = .center
        text.text = "qwerty"
        
        text.placeholder = NSLocalizedString("Password", comment: "")
        text.isSecureTextEntry = true
        
        text.delegate = self
        
        return text
    }()
    
    private lazy var signUpBtn = CustomButton(title: NSLocalizedString("Sign Up", comment: ""), textColor: .white, backColor: nil, closure: { [weak self] in
        self?.signUpPressed()
    })
    
    private lazy var loginButton: CustomButton = CustomButton(title: NSLocalizedString("Log in", comment: ""), textColor: .white, backColor: nil){ [weak self] in
        self?.logInPressed()
    }
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        setView()
        addSubviews()
        setConstaints()
        tuneSubViews()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeObservers()
    }

    //MARK: addSubviews
    private func addSubviews() {
        [loginPasswordField, loginButton , VKLogo, signUpBtn, biometricButton, biometricButtonLabel].forEach({
            contentView.addSubview($0)
        })
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        
        
    }
    //MARK: Constraints
    private func setConstaints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            
            VKLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 90),
            VKLogo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            VKLogo.heightAnchor.constraint(equalToConstant: 100),
            VKLogo.widthAnchor.constraint(equalToConstant: 100),
            
            loginPasswordField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginPasswordField.heightAnchor.constraint(equalToConstant: 100.5),
            loginPasswordField.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant:  -32),
            loginPasswordField.topAnchor.constraint(equalTo: VKLogo.bottomAnchor, constant: 90),
            
            loginButton.topAnchor.constraint(equalTo: loginPasswordField.bottomAnchor, constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            signUpBtn.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            signUpBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            signUpBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            signUpBtn.heightAnchor.constraint(equalToConstant: 50),
            
            biometricButton.topAnchor.constraint(equalTo: signUpBtn.bottomAnchor, constant: 32),
            biometricButton.widthAnchor.constraint(equalToConstant: 50),
            biometricButton.heightAnchor.constraint(equalToConstant: 50),
            biometricButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            biometricButtonLabel.bottomAnchor.constraint(equalTo: biometricButton.topAnchor, constant: -4),
            biometricButtonLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    
    //MARK: KeyBoard Obervers
    private func addObservers() {
        let notiCenter = NotificationCenter.default
        
        notiCenter.addObserver(
            self,
            selector: #selector(keyBoardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        notiCenter.addObserver(
            self,
            selector: #selector(keyBoardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    
    @objc func keyBoardWillShow(_ notfication: Notification) {
        let height = (notfication.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height
        scrollView.contentInset.bottom += height ?? 0
    }
    @objc func keyBoardWillHide(_ notfication: Notification) {
        scrollView.contentInset.bottom =   0
    }
    
    private func removeObservers() {
        let notiCenter = NotificationCenter.default
        notiCenter.removeObserver(self)
    }
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    //MARK: Private
    
    private func setView() {
        view.backgroundColor = .customControllerBackGroundColor
    }
    
    private func tuneSubViews(){
        loginButton.setBackgroundImage(UIImage(named: "pixel"), for: .normal)
        loginButton.layer.cornerRadius = 10
        loginButton.layer.masksToBounds = true
        
        signUpBtn.setBackgroundImage(UIImage(named: "pixel"), for: .normal)
        signUpBtn.layer.cornerRadius = 10
        signUpBtn.layer.masksToBounds = true
        
        biometricService?.getBiometryType(isFaceID: { [weak self] bool in
            if bool {
                self?.biometricButton.setImage(UIImage(named: "faceIDIcon"), for: .normal)
            } else {
                self?.biometricButton.setImage(UIImage(named: "touchIDIcon"), for: .normal)
            }
        })
    }

    private func pullAnError() {
        let alert = UIAlertController(title: NSLocalizedString("Incorrect login or password", comment: ""), message: NSLocalizedString("Enter correct login and password", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
    }
    private func checkFieldIsNotEmpty() throws -> Bool {
        var isNotEmpty = true
        if loginField.text == "" {
            isNotEmpty = false
            throw AppError.emptyField
        }
    
        if passwordField.text == "" {
            isNotEmpty = false
            throw AppError.emptyField
        }
        return isNotEmpty
        }
    
    private func authorizationFinished(){
#if DEBUG
        let userService = TestUserService()
#else
        let userService = CurrentUserService()
#endif
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let VController = ProfileViewController()
            let favoriteVC = (self.tabBarController?.viewControllers?.last as? UINavigationController)?.viewControllers.first as? FavoritesViewController
            
            VController.viewModel = ProfileViewModel(user: userService.user)
            VController.favoriteVCDelegate = favoriteVC
            
            VController.tabBarItem = self.tabBarItem
            self.navigationController?.setViewControllers([VController], animated: true)
        }
    }
    
    //MARK: Login & SignUp
    
    @objc func logInPressed() {
        
        loginDelegate?.checkCredentials(login: loginField.text!, password: passwordField.text!, completion: { [weak self] result in
            switch result{
            case .failure(let error):
                self?.makeAlert(title: NSLocalizedString("An error occured", comment: ""), message: error.localizedDescription)
            case .success(let user):
                print(user.user.uid)
                
                self?.authorizationFinished()
                
            }
            
        })
        
        
        
    }
    
    private func signUpPressed() {
        loginDelegate?.singUp(login: loginField.text!, password: passwordField.text!, completion: { [weak self] result in
            switch result{
            case .failure(let error):
                self?.makeAlert(title: NSLocalizedString("An error occured", comment: ""), message: error.localizedDescription)
            case .success(let user):
                print(user.user.uid + " signedUp")

            }
        })
    }
}


