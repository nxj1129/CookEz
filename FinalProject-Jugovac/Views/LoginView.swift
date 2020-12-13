//
//  LoginView.swift
//  FinalProject-Jugovac
//
//  Created by Niko Jugovac on 11/17/20.
//  Copyright © 2020 Niko Jugovac. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @EnvironmentObject var session: Session
    
    func signIn() {
        session.signIn(email: email, password: password){(result, error) in
            if let error = error {
                self.error = error.localizedDescription
            }
            else{
                self.email = ""
                self.password = ""
            }
        }
    }
    
    var body: some View{
        VStack{
            ZStack{
                CustomGradient.mygradient
                    .edgesIgnoringSafeArea(.all)
                    
                VStack{
                    Group{
                        Text("CookEz")
                            .font(.custom("The Bugatten", size: 150))
                            .foregroundColor(.yellow)
                            .offset(y: 50)
                        
                        Text("Sign in")
                            .font(.custom("The Bugatten", size: 80))
                            .foregroundColor(.yellow)
                    }.offset(y: -50)
                    
                    
                    Image("CookEzIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .offset(y: -50)
                    
                    HStack{
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                        TextField("Enter email", text: $email)
                            .autocapitalization(.none)
                            .padding(.leading, 12)
                            .background(Color.yellow)
                            .cornerRadius(25)
                            .font(.title)
                            .shadow(color: Color.lightYellow, radius: 8, x: 0, y: 0)
                            .padding(.bottom, 10)
                        
                    }.padding(12)
                    
                    HStack{
                        Image(systemName: "lock.fill")
                            .resizable()
                            .frame(width: 18, height: 20)
                        
                        SecureField("Enter password", text: $password)
                            .padding(.leading, 12)
                            .background(Color.yellow)
                            .cornerRadius(25)
                            .font(.title)
                            .shadow(color: Color.lightYellow, radius: 8, x: 0, y: 0)
                            .padding(.bottom, 10)
                        
                    }.padding(12)
                    
                    HStack{ 
                        Button(action: signIn){
                            Text("Sign in")
                                .fontWeight(.bold)
                                .foregroundColor(.yellow)
                                .padding()
                                .frame(width: 150)
                                .background(CustomGradient.mygradient)
                                .cornerRadius(25)
                                .shadow(radius: 20)
                        }
                        
                    }
                    
                    VStack {
                        if(error != ""){
                            Text(error)
                                .foregroundColor(.yellow)
                        }
                    }
                    .frame(height: 50)
                    .padding(.top, 8)

                    NavigationLink(destination: SignUpView()){
                        HStack{
                            Text("Don't have an account?")
                                .foregroundColor(.white)
                            Text("Create new account")
                                .foregroundColor(.yellow)
                        }.padding(.top, 20)
                    }
                    
                    Spacer().frame(height: 200)
                    
                }.padding(.horizontal, 18)
            }
        }
    }
}


struct SignUpView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @EnvironmentObject var session: Session
    
    func signUp(){
        session.signUp(email: email, password: password){(result, error) in
            if let error = error{
                self.error = error.localizedDescription
            }
            else{
                self.email = ""
                self.password = ""
            }
        }
    }
    
    var body: some View{
        VStack{
            ZStack{
                CustomGradient.mygradient
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    
                    CreateAccountAndTitle()
                    
                    Image("CookEzIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .offset(y: -80)
                    
                    HStack{
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                        TextField("Enter email", text: $email)
                            .padding(.leading, 12)
                            .background(Color.yellow)
                            .cornerRadius(25)
                            .font(.title)
                        
                    }.padding(12)
                    
                    HStack{
                        Image(systemName: "lock.fill")
                            .resizable()
                            .frame(width: 18, height: 20)
                        
                        SecureField("Enter password", text: $password)
                            .padding(.leading, 12)
                            .background(Color.yellow)
                            .cornerRadius(25)
                            .font(.title)
                        
                    }.padding(12)
                    
                    HStack{
                        Button(action: signUp){
                            Text("Create Account").foregroundColor(.yellow).padding().frame(width: 200)
                                .background(CustomGradient.mygradient)
                                .cornerRadius(25)
                                .shadow(radius: 20)
                        }
                    }
                    
                    VStack{
                        if(error != ""){
                            Text(error)
                                .foregroundColor(.yellow)
                        }
                    }.frame(height: 50)
                    .padding(.top, 8)
                    
                    NavigationLink(destination: SignInView()){
                        HStack{
                            Text("Already have an account?")
                                .foregroundColor(.white)
                            Text("Sign In")
                                .foregroundColor(.yellow)
                        }.padding(.top, 20)
                    }
                    
                    Spacer().frame(height: 200)
                    
                }.padding(.horizontal, 18)
            }
        }
    }
}

struct AuthView: View {
    var body: some View{
        NavigationView{
            SignInView()
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View{
        AuthView().environmentObject(Session())
    }
}

struct CreateAccountAndTitle: View {
    var body: some View {
        Group{
            Text("CookEz")
                .font(.custom("The Bugatten", size: 150))
                .foregroundColor(.yellow)
                .offset(y: 50)
            
            Text("Create an account")
                .font(.custom("The Bugatten", size: 80))
                .foregroundColor(.yellow)
        }.offset(y: -80)
    }
}
