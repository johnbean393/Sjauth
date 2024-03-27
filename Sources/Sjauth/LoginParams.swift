//
//  LoginParams.swift
//  STUWIRELESS Login
//
//  Created by Bean John on 26/3/2024.
//

import Foundation

struct LoginParams: Codable {
	
	init(userName: String, pwd: String) {
		let rckey: String = "\(Int(Date().timeIntervalSince1970 * 1000))"
		self.userName = userName
		self.pwd = doEncryptRC4(pwd, passwd: rckey)
		self.auth_tag = rckey
	}
	
	var opr: String = "pwdLogin"
	var userName: String
	var pwd: String
	var auth_tag: String
	var rememberPwd: String = "1"
	
	func encode() -> Data {
		return try! URLEncodedFormEncoder().encode(self)
	}
	
}
