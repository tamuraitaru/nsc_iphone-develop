//
//  EncryptionConstants.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/04/20.
//

import Foundation

struct EncryptionConstants {
    static let keyword = "Dxi.C4mS@vROM*G>Wgd2M#:ve{CRRxns"  // Ensure key is 16, 24, or 32 bytes long
    static let initVector = "a10eda3554ba772b19fc760543d721f2"  // Ensure IV is 16 bytes long in UInt8 (converted as: a1->161, 0e->14,...,f2-> 242)
}
