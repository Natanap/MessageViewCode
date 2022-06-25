//
//  ContatoController.swift
//  MessageCursoViewCode
//
//  Created by Natanael Alves Pereira on 09/06/22.
//

import Foundation
import UIKit
import FirebaseFirestore

protocol ContatoProtocol: AnyObject{
    func alertStateError(titulo:String,message:String)
    func successContato()
}

class ContatoController{
    
    weak var delegate:ContatoProtocol?
    
    public func delegate(delegate:ContatoProtocol?){
        self.delegate = delegate
    }
    
    func addContact(email:String, emailUsuarioLogado:String, idUsuario:String){
        if email == emailUsuarioLogado{
            self.delegate?.alertStateError(titulo: "Voce adicionou seu proprio e-mail", message: "Adicione um email diferente")
            return
        }
        
        //verificar se existe o usuario no firebase
        let firestore = Firestore.firestore()
        firestore.collection("usuarios").whereField("email", isEqualTo: email).getDocuments { snapshotResultado, error in
            
            // Conta total de retorno
            if let totalItens = snapshotResultado?.count{
                if totalItens == 0{
                    self.delegate?.alertStateError(titulo: "Usuario não cadastrado", message: "Verfifique o email e tente novamente")
                    return
                }
            }
            
            //Salvar contato
            if let snapshot = snapshotResultado {
                for document in snapshot.documents{
                    let dados = document.data()
                    self.salvarContato(dadosContato: dados, idUsuario: idUsuario  )
                }
            }
        }
    }
    
    func salvarContato(dadosContato:Dictionary<String, Any>, idUsuario:String){
        let contact:Contact = Contact(dicionario: dadosContato)
        let firestore:Firestore = Firestore.firestore()
        firestore.collection("usuarios").document(idUsuario).collection("contatos").document(contact.id ?? "").setData(dadosContato){(error) in
            if error == nil {
                self.delegate?.successContato()
            }
        }
    }
}
