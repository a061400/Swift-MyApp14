//
//  ViewController.swift
//  MyApp14
//
//  Created by 謝尚霖 on 2017/9/25.
//  Copyright © 2017年 謝尚霖. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let fileMgr = FileManager.default
    
    @IBOutlet weak var imgv: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nowDir = fileMgr.currentDirectoryPath
        print(nowDir) //root directory => /
        do {
             let dirs = try fileMgr.contentsOfDirectory(atPath: nowDir)
            //正常無誤
            print("\(dirs.count)")
            for v in dirs {
                print(v)
            }
        } catch  {
            //處理錯誤邏輯
            print("error")
        }
        
        print("01----------------------------------")
    
        let urls = fileMgr.urls(for: .documentDirectory, in: .userDomainMask)
        
        print("\(urls.count)")
        
        if let urlDocument = urls.first {
            print(urlDocument)
        }
        
        print("02----------------------------------")
        
        let home = NSHomeDirectory()
        print(home)
        let dir1 = home + "/Documents/dir1"
        if !fileMgr.fileExists(atPath: dir1){
            
            do{
            try fileMgr.createDirectory(atPath: dir1, withIntermediateDirectories: true, attributes: nil)
                print("create success")
            }catch{
                    print("create failure")
                }
        }else{
            print("Exist")
        }
        
        
           print("03----------------------------------")
        
        let file1 = dir1 + "/brad.txt"
        let data = "Hello, World\n abcde \n fghlij \n 345343\n".data(using: .utf8)
        if fileMgr.createFile(atPath: file1, contents: data, attributes: nil){
            print("Create file success")
        }else{
            print("Create file failure")
        }
        print("--------複製目錄")
        let dir2 = home + "/Documents/dir2"
        
        
        do{
        try fileMgr.copyItem(atPath: dir1, toPath: dir2)
            print("Copy Success")
        }catch{
            print("Copy Failure")
        }
        
        
        
            print("--------------------移動目錄 dir1 => dir2 下面")
        let dir1new = home + "/Documents/dir2/dir1"
        do{
       try fileMgr.moveItem(atPath: dir1, toPath: dir1new)
            print("Move Success")
        }catch {
            print("Move Failure")
        }
        
        print("--------------------刪除目錄 dir1new")
        do{
        try fileMgr.removeItem(atPath: dir1new)
        print("Remove Success")
        }catch{
           print("Remove failure")
        }
        
           print("------------------------玩file1的屬性 以下設定為不備份")
        
        
        let file2 = home + "/Documents/dir2/brad.txt"
        var file2Url = URL (fileURLWithPath: file2)
        print(file2Url)
        
       
        
        do{
            var value = URLResourceValues()
            value.isExcludedFromBackup = true
        try file2Url.setResourceValues(value)
            print("Set Success")
        }catch{
            print("Set Failure")
        }
        
        print("------------------------read file content")
        
        do {
        let cont = try String(contentsOfFile: file2, encoding: .utf8)
        print(cont)
        }catch{
            print("error")
        }
        
        print("------------------------read binary content")
        let readImg = NSHomeDirectory() + "/Documents/dir2/apple.png"
        
        let imgUrl = URL(fileURLWithPath: readImg)
        
        do{
        let imgData = try Data(contentsOf: imgUrl)
           let img = UIImage(data: imgData)
            print("read image success")
            imgv.image = img
        }catch{
             print("read image failure")
        }
        
        
        
        
        
        
    }

    


}

