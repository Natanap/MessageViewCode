//
//  ViewController.swift
//  LoginViewCode
//
//  Created by Natanael Alves Pereira on 21/02/22.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    var loginScreen:LoginScreen?
    var auth: Auth?
    var alert: Alert?
    
    override func loadView() {
        self.loginScreen = LoginScreen()
        self.view = self.loginScreen

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginScreen?.delegate(delegate: self)
        self.loginScreen?.configTextFieldDelegate(delegate: self)
        self.auth = Auth.auth()
        self.alert = Alert(controller: self)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension LoginVC:LoginScreenProtocol{
    func actionLoginButton() {
        
        guard let login = self.loginScreen else {return}

        self.auth?.signIn(withEmail: login.getEmail(), password: login.getPassword(), completion: { (usuario, error) in

            if error != nil{
                self.alert?.getAlert(titulo: "Atencao", mensagem: "Dados incorretos")
            }else{
                if usuario == nil {
                    self.alert?.getAlert(titulo: "Atencao", mensagem: "Tivemos um problema")
                }else{
                    let VC = HomeVC()
                    let navVc = UINavigationController(rootViewController: VC)
                    navVc.modalPresentationStyle = .fullScreen
                    self.present(navVc, animated: true, completion: nil)
                }
            }

        })
        
    }
    
    func actionRegisterButton() {
        // CHAMANDO A OUTRA TELA
        let vc:RegisterVC = RegisterVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension LoginVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBegin")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEnd")
        self.loginScreen?.validaTextFields()
    }
    
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

