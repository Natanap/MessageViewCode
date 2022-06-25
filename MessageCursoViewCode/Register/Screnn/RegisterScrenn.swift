//
//  RegisterScrenn.swift
//  LoginViewCode
//
//  Created by Natanael Alves Pereira on 05/03/22.
//

import UIKit


protocol RegisterScrennProtocol:AnyObject{
    
    func actionBackButton()
    func actionRegisterButton()
}


class RegisterScrenn: UIView {
    
    weak var delegate:RegisterScrennProtocol?
    
    func delegate(delegate:RegisterScrennProtocol?){
        
        self.delegate = delegate
    }
    
    lazy var backButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(self.tappedBackButton), for: .touchUpInside)
        return button
    }()
    
    lazy var imageAddUser: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage (named:  "usuario")
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    lazy var nameTextField:UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.keyboardType = .emailAddress
        tf.layer.cornerRadius = 8.5
        tf.placeholder = "Digite seu Nome"
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .darkGray
        
        return tf
    }()
    
    lazy var emailTextField:UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.keyboardType = .emailAddress
        tf.layer.cornerRadius = 8.5
        tf.placeholder = "Digite seu Email"
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .darkGray
        
        return tf
    }()
    
    lazy var passwordTextField:UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.keyboardType = .default
        tf.layer.cornerRadius = 8.5
        tf.placeholder = "Digite sua senha"
        tf.isSecureTextEntry = true
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .darkGray
        
        return tf
    }()
    
    lazy var registerButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cadastrar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 7.5
        button.backgroundColor = UIColor(red: 3/255, green: 58/255, blue: 51/255, alpha: 1.0)
        button.addTarget(self, action: #selector(self.tappedregisterButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configBackGround()
        self.configSuperView()        
        self.setUpConstraints()
        self.configButtonEnable(false)
    }
    
    private func configSuperView(){
        self.addSubview(self.backButton)
        self.addSubview(self.imageAddUser)
        self.addSubview(self.nameTextField)
        self.addSubview(self.emailTextField)
        self.addSubview(self.passwordTextField)
        self.addSubview(self.registerButton)
        
    }
    
    private func configBackGround(){
        self.backgroundColor = UIColor(red: 24/255, green: 117/255, blue:104/255, alpha: 1.0)
    }
    
    public func configTextFieldDelegate(delegate:UITextFieldDelegate){
        self.nameTextField.delegate = delegate
        self.emailTextField.delegate = delegate
        self.passwordTextField.delegate = delegate

    }
    
    @objc private func tappedBackButton(){
        self.delegate?.actionBackButton()
    }
    
    @objc private func tappedregisterButton(){
        self.delegate?.actionRegisterButton()
    }
    
    public func validaTextFields(){
        let name:String = self.nameTextField.text ?? ""
        let email:String = self.emailTextField.text ?? ""
        let passaword:String = self.passwordTextField.text ?? ""
        
        //Verifica se os campos estão vazios
        if !name.isEmpty && !email.isEmpty && !passaword.isEmpty{
            self.configButtonEnable(true)
        }else{
            self.configButtonEnable(false)
        }
    }
    
    private func configButtonEnable(_ enable:Bool){
        //habilita o button
        if enable {
            self.registerButton.setTitleColor(.white, for: .normal)
            self.registerButton.isEnabled = true
        }else{
            self.registerButton.setTitleColor(.lightGray, for: .normal)
            self.registerButton.isEnabled = false
        }
        
    }
    
    public func getName()-> String{
        return self.nameTextField.text ?? ""
        
    }
    
    public func getEmail()-> String{
        return self.emailTextField.text ?? ""
        
    }
    
    public func getPassword()-> String{
        return self.passwordTextField.text ?? ""
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints(){
        NSLayoutConstraint.activate([
        
            self.imageAddUser.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.imageAddUser.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.imageAddUser.widthAnchor.constraint(equalToConstant: 150),
            self.imageAddUser.heightAnchor.constraint(equalToConstant: 150),
        
            self.backButton.topAnchor.constraint(equalTo: self.imageAddUser.topAnchor),
            self.backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            self.nameTextField.topAnchor.constraint(equalTo: self.imageAddUser.bottomAnchor, constant: 10),
            self.nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.nameTextField.heightAnchor.constraint(equalToConstant: 45),
            
            self.emailTextField.topAnchor.constraint(equalTo: self.nameTextField.bottomAnchor, constant: 15),
            self.emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.emailTextField.heightAnchor.constraint(equalToConstant: 45),
            
            self.passwordTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 15),
            self.passwordTextField.leadingAnchor.constraint(equalTo: self.emailTextField.leadingAnchor),
            self.passwordTextField.trailingAnchor.constraint(equalTo: self.emailTextField.trailingAnchor),
            self.passwordTextField.heightAnchor.constraint(equalTo: self.emailTextField.heightAnchor),
            
            self.registerButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 15),
            self.registerButton.leadingAnchor.constraint(equalTo: self.emailTextField.leadingAnchor),
            self.registerButton.trailingAnchor.constraint(equalTo: self.emailTextField.trailingAnchor),
            self.registerButton.heightAnchor.constraint(equalTo: self.emailTextField.heightAnchor),
            
        ])
    }
    
    //offset = positivo
    //inset = negativo

}
