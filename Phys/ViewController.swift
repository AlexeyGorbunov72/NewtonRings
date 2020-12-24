//
//  ViewController.swift
//  Phys
//
//  Created by Alexey on 07.12.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ringView: RingView!
    @IBOutlet weak var pic: UIImageView!
    @IBAction func didPressSave(_ sender: UIButton) {
        let image = ringView.asImage()
        let items = [image]
        let activityVC: UIActivityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        let excludeActivities: [UIActivity.ActivityType] = [.airDrop,
                                                   .addToReadingList,
                                                   .copyToPasteboard,
                                                   .mail,
                                                   .message]
        activityVC.excludedActivityTypes = excludeActivities

        self.present(activityVC, animated: true, completion: nil)
    }
    @IBAction func didPressBarItem(_ sender: UIBarButtonItem) {
        guard let image = ringView.getImage() else{
            print("fail get context")
            return
        }
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)

        image.pngData()
        self.present(activityViewController, animated: true)
    }
    @IBAction func didChangeR(_ sender: UITextField) {
        if let text = sender.text{
            if text.count > 0{
                ringView.R = text.toDouble()!
            }
            
        }
        
    }
    @IBAction func didChangeL(_ sender: UITextField) {
        if let text = sender.text{
            if text.count > 0{
                ringView.L = text.toDouble()!
            }
            
        }
    }
    @IBAction func didChangeN(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
