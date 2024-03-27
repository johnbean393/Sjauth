//
//  Sjauth.swift
//
//
//  Created by Bean John on 26/3/2024.
//

import Foundation

public class Sjauth {
	
	public enum SjauthError: Error {
		case notOnStuWireless
		case wrongPassword
	}
	
	public static func login(username: String, password: String) throws {
		
		// Init codable struct containing login credentials
		let loginCredentials: LoginParams = LoginParams(userName: "s20407", pwd: "377580Aa!")
		
		// Make HTTP POST request
		let url: URL = URL(string: "http://sjauth.ykpaoschool.cn/ac_portal/login.php")!
		var request: URLRequest = URLRequest(url: url)
		request.httpMethod = "POST"
		request.httpBody = loginCredentials.encode()
		print(String(data: loginCredentials.encode(), encoding: .utf8)!)
		request.setValue(
			"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:104.0) Gecko/20100101 Firefox/104.0",
			forHTTPHeaderField: "User-Agent"
		)
		request.setValue(
			"text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8",
			forHTTPHeaderField: "Accept"
		)
		request.setValue(
			"en-US.en;q=0.5",
			forHTTPHeaderField: "Accept-Language"
		)
		request.setValue(
			"null",
			forHTTPHeaderField: "Origin"
		)
		request.setValue(
			"keep-alive",
			forHTTPHeaderField: "Connection"
		)
		request.setValue(
			"application/x-www-form-urlencoded; charset=UTF-8",
			forHTTPHeaderField: "Content-Type"
		)
		
		// Send POST request
		var throwError: Error?
		let task: URLSessionDataTask = URLSession(configuration: .default).dataTask(with: request) { (data, response, error) -> Void in
			if response != nil {
				let statusCode: Int = (response as! HTTPURLResponse).statusCode
				if statusCode != 200 {
					throwError = SjauthError.wrongPassword
				}
			} else {
				throwError = SjauthError.notOnStuWireless
			}
		}
		task.resume()
		// Throw error if needed
		if throwError != nil {
			throw throwError!
		}
	}
	
}
