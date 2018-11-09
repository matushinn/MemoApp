//
//  ViewController.swift
//  MarubatsuApp
//
//  Created by Work on 2016/10/06.
//  Copyright © 2016年 sparta-asano.jp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var batsuButton: UIButton!
    @IBOutlet weak var maruButton: UIButton!
    // 表示中の問題番号を格納
    var currentQuestionNum: Int = 0
    
    var questions:[[String:Any]] = []
    
    // 問題
//    let questions: [[String: Any]] = [
//        [
//            "question": "iPhoneアプリを開発する統合環境はZcodeである",
//            "answer": false
//        ],
//        [
//            "question": "Xcode画面の右側にはユーティリティーズがある",
//            "answer": true
//        ],
//        [
//            "question": "UILabelは文字列を表示する際に利用する",
//            "answer": true
//        ]
//    ]
//
    // 問題を表示する関数
    func showQuestion() {
        //問題がある時
        if (questions.count > currentQuestionNum){
            let question = questions[currentQuestionNum]
            
            if let que = question["question"] as? String {
                questionLabel.text = que
            }
            //Buttonを使えるようにする
            batsuButton.isEnabled = true
            maruButton.isEnabled = true
            
       } else { //問題がない時
            questionLabel.text = "問題がありません。作成して下さい。"
            //BUttonを使えなくする
            batsuButton.isEnabled = false
            maruButton.isEnabled = false
            
        }
    }
    
    // 回答をチェックする関数
    // 正解なら次の問題を表示します
    func checkAnswer(yourAnswer: Bool) {
        let question = questions[currentQuestionNum]
        
        if let ans = question["answer"] as? Bool {
            
            if yourAnswer == ans {
                // 正解
                // currentQuestionNumを1足して次の問題に進む
                currentQuestionNum += 1
                showAlert(message: "正解！")
            } else {
                // 不正解
                showAlert(message: "不正解…")
            }
            
        }
        
        // currentQuestionNumの値が問題数以上だったら最初の問題に戻す
        if currentQuestionNum >= questions.count {
            currentQuestionNum = 0
        }
        
        // 問題を表示します。
        // 正解であれば次の問題が、不正解であれば同じ問題が再表示されます。
        showQuestion()
    }
    
    // アラートを表示する関数
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showQuestion()
    }
    override func viewWillAppear(_ animated: Bool) {
        let userDefaults = UserDefaults.standard
        
        if (userDefaults.object(forKey: "questions") != nil){
            questions = userDefaults.object(forKey: "questions") as! [[String:Any]]
            showQuestion()
        }
    }

    @IBAction func tappedNoButton(_ sender: UIButton) {
        checkAnswer(yourAnswer: false)
    }
    
    @IBAction func tappedYesButton(_ sender: UIButton) {
        checkAnswer(yourAnswer: true)
    }
}

