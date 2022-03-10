//
//  ViewController.swift
//  NoticeTestProject
//
//  Created by 박형환 on 2022/03/09.
//

import UIKit
import FirebaseRemoteConfig

class ViewController: UIViewController {
    
    let isHiddenKey = "notice_isHidden"
    let titleKey = "notice_Title"
    let contentKey = "notice_Content"
    let timeKey = "notice_Time"
    let dayKey = "notice_Day"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getNotice()
       
    }
   
        
       
}


extension ViewController {
    
    func getNotice() {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        guard let remoteConfig = appdelegate.remoteConfig else {return}
        remoteConfig.setDefaults(fromPlist: "noticeProperty")
        remoteConfig.fetch{ [weak self] (status,error) -> Void in
            guard let self = self else {return}
            if status == .success{
                remoteConfig.activate(completion: nil)
            }else {
                print("Config not fetched")
                   print("Error: \(error?.localizedDescription ?? "No error available.")")
            }
            if remoteConfig[self.isHiddenKey].boolValue{
                let noticeVC = NoticeViewController(nibName: "NoticeViewController", bundle: nil)
                let title = remoteConfig[self.titleKey].stringValue
                let content = remoteConfig[self.contentKey].stringValue
                let time = remoteConfig[self.timeKey].stringValue
                let day = remoteConfig[self.dayKey].stringValue
                noticeVC.notice = (title: title, content: content, time: time, day: day)
                self.modalTransitionStyle = .crossDissolve
                self.modalPresentationStyle = .fullScreen
                self.present(noticeVC, animated: true, completion: nil)
            }else {
                self.addAlert()
            }
        }
    }
    func addAlert() {
      debugPrint("addAlert - called1")
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        guard let remoteConfig = appdelegate.remoteConfig else {return}
        guard let message = remoteConfig["alert_message"].stringValue else {return}
        guard let title = remoteConfig["alert_Title"].stringValue else {return}
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
      alertController.addAction(ok)
      debugPrint("addAlert - called2")
      DispatchQueue.main.async { [weak self] in
          guard let self = self else {return}
          self.present(alertController, animated: true)
      }
  }
   
}

