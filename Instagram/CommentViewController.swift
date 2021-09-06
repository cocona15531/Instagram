//
//  CommentViewController.swift
//  Instagram
//
//  Created by Issei Ueda on 2021/09/02.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    @IBOutlet weak var commentTextField: UITextField!
    
    var postData: PostData!
    
    @IBAction func sendButton(_ sender: Any) {
        
        if let commentator = Auth.auth().currentUser?.displayName {
            // コメント追加する更新データを作成
            var updateValue: FieldValue
            updateValue = FieldValue.arrayUnion([commentator + " : " + commentTextField.text!])
            // commentsに更新データを書き込む
            let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
            postRef.updateData(["comments": updateValue])
            // HUDで投稿完了を表示する
            SVProgressHUD.showSuccess(withStatus: "投稿しました")
            // 投稿処理が完了したので先頭画面に戻る
           UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        // 画面を閉じてタブ画面に戻る
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
