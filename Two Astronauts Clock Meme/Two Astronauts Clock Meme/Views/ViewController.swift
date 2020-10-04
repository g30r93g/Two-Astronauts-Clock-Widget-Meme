//
//  ViewController.swift
//  Two Astronauts Clock Meme
//
//  Created by George Nick Gorzynski on 03/10/2020.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak private var sizePicker: UISegmentedControl!
    @IBOutlet weak private var sizeWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak private var widgetPreview: UIView!
    @IBOutlet weak private var timeLabel: UILabel!
    
    // MARK: Properties
    private var timeUpdateTimer: Timer!
    
    // MARK: View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setupView()
    }
    
    // MARK: Methods
    private func setupView() {
        self.timeUpdateTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            guard let displayedTime = self.timeLabel.text else { return }
            
            let currentTimeFormatter = DateFormatter()
            currentTimeFormatter.dateFormat = "HH:mm"
            
            let currentTime = currentTimeFormatter.string(from: Date())
            
            if currentTime != displayedTime {
                DispatchQueue.main.async {
                    self.timeLabel.text = currentTime
                }
            }
        }
    }
    
    private func showAttribution() {
        let license = """
        \n
        MIT License

        Copyright (c) 2020 1di4r

        Permission is hereby granted, free of charge, to any person obtaining a copy
        of this software and associated documentation files (the "Software"), to deal
        in the Software without restriction, including without limitation the rights
        to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
        copies of the Software, and to permit persons to whom the Software is
        furnished to do so, subject to the following conditions:

        The above copyright notice and this permission notice shall be included in all
        copies or substantial portions of the Software.

        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
        IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
        FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
        AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
        LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
        OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
        SOFTWARE.
        """
        
        let alert = UIAlertController(title: "\nAttribution Message", message: "\nThis widget was inspired by GitHub user 1di4r's project called 'ReachInfo', where widgets appear in reachability. This is one of the widgets provided by ReachInfo. The images are licensed from 1di4r under the MIT license. The following copyright notice is the license from https://github.com/1DI4R/ReachInfo/blob/master/LICENSE: \(license)", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: IBActions
    @IBAction private func sizePickerChangedValue(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.sizeWidthConstraint.constant = 200
            self.widgetPreview.setNeedsUpdateConstraints()
            
            UIView.animate(withDuration: 0.3) {
                self.widgetPreview.layoutIfNeeded()
            }
        case 1:
            self.sizeWidthConstraint.constant = 300
            self.widgetPreview.setNeedsUpdateConstraints()
            
            UIView.animate(withDuration: 0.3) {
                self.widgetPreview.layoutIfNeeded()
            }
        default:
            break
        }
    }
    
    @IBAction private func showAttributionTapped(_ sender: UIButton) {
        self.showAttribution()
    }

}
