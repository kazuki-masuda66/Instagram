//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by 増田 一樹 on 2020/12/20.
//  Copyright © 2020 Kazuki. All rights reserved.
//

import UIKit
import FirebaseUI

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var likeLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var commentButton: UIButton!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // PostDataの内容をセルに表示
    func setPostData(_ postData: PostData) {
        // 画像の表示
        postImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postData.id + ".jpg")
        postImageView.sd_setImage(with: imageRef)

        // キャプションの表示
        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"

        //コメントの取り出し
        var commentString = ""
        for comment in postData.comment {
            commentString += "\(comment)\n"
        }
        
        print("DEBUG_PRINT: ")
        print(commentString)
        print("DEBUG_PRINT: ")
        print(postData.comment)
        
        // コメントの表示
        if postData.comment == nil {
                self.commentLabel.text = ""
        }else{
            //self.commentLabel.text = "\(commentString)"
            self.commentLabel.text = "\(commentString)"
        }
        
        
        // 日時の表示
        self.dateLabel.text = ""
        if let date = postData.date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateString = formatter.string(from: date)
            self.dateLabel.text = dateString
        }

        // いいね数の表示
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"

        // いいねボタンの表示
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
    }
}
