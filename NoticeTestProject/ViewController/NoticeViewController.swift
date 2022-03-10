//
//  NoticeViewController.swift
//  NoticeTestProject
//
//  Created by 박형환 on 2022/03/09.
//

import UIKit

class NoticeViewController: UIViewController {
    
    var notice: (title: String?, content: String?, time: String?, day: String?)?
    @IBOutlet weak var notice_title: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var okBtn: UIButton!
    
    @IBOutlet weak var popUpView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.popUpView.layer.cornerRadius = 10
        self.popUpView.layer.borderWidth = 2
        self.popUpView.layer.borderColor = UIColor.blue.cgColor
        notice_title.text = notice?.title
        content.text = notice?.content
        time.text = notice?.time
        day.text = notice?.day
        
    }


    @IBAction func clickedBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
