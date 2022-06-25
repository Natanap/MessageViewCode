//
//  RegisterViewController.swift
//  LoginViewCode
//
//  Created by Natanael Alves Pereira on 05/03/22.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {

    var registerScrenn: RegisterScrenn?
    
    var auth:Auth?
    var firestore:Firestore?
    var alert:Alert?
    
    override func loadView() {
        self.registerScrenn = RegisterScrenn()
        self.view = self.registerScrenn
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerScrenn?.configTextFieldDelegate(delegate: self)
        self.registerScrenn?.delegate(delegate: self)
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
        self.alert = Alert(controller: self)
    }

}

extension RegisterVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.registerScrenn?.validaTextFields()
    }
    // Baixar o teclado 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}


extension RegisterVC: RegisterScrennProtocol{
    func actionBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func actionRegisterButton() {
        
        guard let register = self.registerScrenn else{return}
        
        self.auth?.createUser(withEmail: register.getEmail(), password: register.getPassword(), completion: {(result,error) in
            
            if error != nil{
                self.alert?.getAlert(titulo: "Atenção", mensagem: "Erro ao cadastrar, verifique os dados e tente novamente")
            }else{
                
                //Salvar dados no firebase
                
                if let idUsuario = result?.user.uid{
                    self.firestore?.collection("usuarios").document(idUsuario).setData([
                        "nome":self.registerScrenn?.getName() ?? "",
                        "email":self.registerScrenn?.getEmail() ?? "",
                        "id":idUsuario
                    ])
                }
                    
                self.alert?.getAlert(titulo: "Parabens", mensagem: "Usuario cadastrado com sucesso", completion: {
                    let VC = HomeVC()
                    let navVc = UINavigationController(rootViewController: VC)
                    navVc.modalPresentationStyle = .fullScreen
                    self.present(navVc, animated: true, completion: nil)
                })
            }
        })
    }
    
    
    
}
