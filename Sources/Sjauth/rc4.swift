//
//  rc4.swift
//  STUWIRELESS Login
//
//  Created by Bean John on 26/3/2024.
//

import Foundation

func doEncryptRC4(_ src: String, passwd: String) -> String {
	
	let src = src.trimmingCharacters(in: .whitespacesAndNewlines)
	var j = 0, a = 0, b = 0, c = 0, temp: Int
	let plen = passwd.count
	let size = src.count
	var key = Array<Int>(repeating: 0, count: 256)
	var sbox = Array<Int>(repeating: 0, count: 256)
	var output = Array<String>(repeating: "", count: size)
	
	for i in 0..<256 {
		key[i] = Int(passwd.unicodeScalars[passwd.unicodeScalars.index(passwd.unicodeScalars.startIndex, offsetBy: i % plen)].value)
		sbox[i] = i
	}
	for i in 0..<256 {
		j = (j + sbox[i] + key[i]) % 256
		temp = sbox[i]
		sbox[i] = sbox[j]
		sbox[j] = temp
	}
	for i in 0..<size {
		a = (a + 1) % 256
		b = (b + sbox[a]) % 256
		temp = sbox[a]
		sbox[a] = sbox[b]
		sbox[b] = temp
		c = (sbox[a] + sbox[b]) % 256
		temp = Int(src.unicodeScalars[src.unicodeScalars.index(src.unicodeScalars.startIndex, offsetBy: i)].value) ^ sbox[c]
		output[i] = String(format: "%02X", temp)
	}
	
	return output.joined().lowercased()
}
