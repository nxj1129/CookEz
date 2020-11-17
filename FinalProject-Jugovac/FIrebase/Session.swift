//
//  Session.swift
//  FinalProject-Jugovac
//
//  Created by Niko Jugovac on 11/17/20.
//  Copyright © 2020 Niko Jugovac. All rights reserved.
//

import Foundation
import Firebase
import Combine

class Session: ObservableObject{
    var didChange = PassthroughSubject<Session, Never>()
    
    @Published var session: User? {didSet {self.didChange.send(self)}}
    var handle: AuthStateDidChangeListenerHandle?
    
    func listen(){
        handle = Auth.auth().addStateDidChangeListener({(auth, user) in
            if let user = user {
                self.session = User(uid: user.uid, email: user.email)
            }
            else{
                self.session = nil
            }
        })
    }
    
    func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback){
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback){
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    func signOut(){
        do{
            try Auth.auth().signOut()
            self.session = nil
        }
        catch{
            print("An error occured while signin out.")
        }
    }
    
    func unbind(){
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        unbind()
    }
    
}

struct User{
    var uid: String
    var email: String?
    
    init(uid: String, email: String?) {
        self.uid = uid
        self.email = email
    }
}
