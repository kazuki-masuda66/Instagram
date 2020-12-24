//
//  PostCommentController.swift
//  Instagram
//
//  Created by 増田 一樹 on 2020/12/23.
//  Copyright © 2020 Kazuki. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class PostCommentController: UIViewController  {
    
    var id : String!
    
    @IBOutlet weak var displayName: UILabel!
    
    @IBOutlet weak var commentField: UITextField!
    
    // 投稿ボタンをタップしたときに呼ばれるメソッド
    @IBAction func handleCommentButton(_ sender: Any) {
                
        // メッセージデータの保存場所を定義する
        let postRef = Firestore.firestore().collection(Const.PostPath).document(id)

        // HUDで投稿処理中の表示を開始
        SVProgressHUD.show()
        
        // FireStoreに投稿データを保存する
                let postDic = [
                    "comment": self.commentField.text!
            ] as [String : Any]
        postRef.updateData(postDic)
        // HUDで投稿完了を表示する
         SVProgressHUD.showSuccess(withStatus: "コメントしました")
         // 投稿処理が完了したので先頭画面に戻る
        UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    // キャンセルボタンをタップしたときに呼ばれるメソッド
    @IBAction func handleCancelButton(_ sender: Any) {
        // 加工画面に戻る
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 受け取った名前を表示名に設定する
        displayName.text = Auth.auth().currentUser?.displayName
    }
}
