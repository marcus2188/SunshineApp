//
//  RegisterView.swift
//  Kuchi
//
//  Created by MmmM on 27/5/20.
//  Copyright © 2020 Omnijar. All rights reserved.
//

import SwiftUI

struct RegisterView: View {
    @State var uname = ""
    @State var pas = ""
    @State var isregistered = false
    @EnvironmentObject var user : User
    
    private func validinputs(unamestr:String, passtr:String) -> Bool{
        if !unamestr.isEmpty && !passtr.isEmpty && unamestr.count > 7 && passtr.count > 7{
            return true
        }
        else{
            return false
        }
    }
    var body: some View {
        Group {
            if isregistered{
                HomeView()
            }
            else{
                ZStack {
                    Image("waves").resizable().edgesIgnoringSafeArea([.top, .bottom]).blur(radius: 3)
                    VStack {
                        Text("You are my sunshine").font(.largeTitle).foregroundColor(.white).lineLimit(3).multilineTextAlignment(.leading)
                        Text("my only sunshine").font(.largeTitle).foregroundColor(.white).multilineTextAlignment(.leading).lineLimit(3)
                        Text(".................................").font(.largeTitle).foregroundColor(.white).multilineTextAlignment(.leading).lineLimit(3)
                        HStack {
                            Text("Username  ").font(.headline).foregroundColor(.white).bold()
                            Text(String(self.uname.count)).font(.headline).foregroundColor(self.uname.count>7 ? .green : .red).bold()
                        }.padding(.top, 250)
                        TextField("Enter your username:", text: $uname).textfieldbordered()
                        HStack {
                            Text("Password ").font(.headline).foregroundColor(.white).bold()
                            Text(String(self.pas.count)).font(.headline).foregroundColor(self.pas.count>7 ? .green : .red).bold()
                        }.padding(.top)
                        SecureField.init("Enter your password:", text: $pas).textfieldbordered()
                        Button(action:{self.isregistered = true; self.registeruser()}, label:{Text("Login").font(.title).foregroundColor(.yellow).padding(.top, 30)}).disabled(!self.validinputs(unamestr: self.uname, passtr: self.pas))
                        
                    }.keyboardoffsetter()//450 padding
                }
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView().environmentObject(User())
    }
}

extension RegisterView{
    // All functions: 
    func registeruser(){
        user.profile.username = self.uname
        user.profile.password = self.pas
    }
}
