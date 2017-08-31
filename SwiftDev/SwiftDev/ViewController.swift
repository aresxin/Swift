//
//  ViewController.swift
//  SwiftDev
//
//  Created by yangjinxin on 2017/2/27.
//  Copyright © 2017年 yangjinxin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak  var listView: UITableView!
    
    let lists = ["UserDefaults"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let name = UIDevice.modelName
        print("name is \(name)")

        let aar = [1,2,4]

        let  sss = UserDefaults.standard.string(forKey: "failLog")
        print("sss ----is \(String(describing: sss))")

        _ = aar[5]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.


    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = lists[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
}

extension ViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushViewController(index: indexPath.row)
    }
}

extension ViewController {
    func pushViewController(index: Int)  {
        let sBoardId = lists[index]
    
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: sBoardId) else {
            return
        }
        
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
