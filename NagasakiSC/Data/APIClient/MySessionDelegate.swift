//
//  MySessionDelegate.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/04/21.
//

import Foundation

class MySessionDelegate: NSObject, URLSessionDelegate, URLSessionTaskDelegate, URLSessionDataDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        // POSTデータの進捗をログに出力
        print("Sent \(totalBytesSent) / \(totalBytesExpectedToSend)")
    }
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        // リクエスト完了またはエラー時のログ
        if let error = error {
            print("Request failed with error: \(error)")
        } else {
            print("Request completed successfully.")
        }
    }
}
