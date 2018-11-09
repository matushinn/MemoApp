//
//  QuestionViewController.swift
//  MarubatsuApp
//
//  Created by 大江祥太郎 on 2018/11/03.
//  Copyright © 2018年 sparta-asano.jp. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var questionField: UITextField!
    @IBOutlet weak var marubatsuControl: UISegmentedControl!
    //var questions : [[String:Any]] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        questionField.delegate = self
    }
    
    @IBAction func tapBackToTopButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapSaveButton(_ sender: Any) {
        var answer:Bool = true
        
        if questionField.text != ""{
            //questionFieldが空ではない時の処理
            if marubatsuControl.selectedSegmentIndex == 0{
                answer = false
            }else {
                //今回は二択なのでelse
                answer = true
            }
            
            let userDefaults = UserDefaults.standard
            //既にある問題を読み込んでくる
            if userDefaults.object(forKey: "questions") != nil {
            var questions = userDefaults.object(forKey: "questions") as! [[String:Any]]
                
                //配列に追加
                questions.append([
                    "question" : questionField.text!,
                    "answer" : answer
                    ])
                //"questions"キーでquestionsを保存
                userDefaults.set(questions, forKey: "questions")
                
                showAlert(message: "問題が保存されました！")
            //print(questions)
                questionField.text = ""
            }
            else{
                var questions:[[String:Any]] = []
                //配列に追加
                questions.append([
                    "question" : questionField.text!,
                    "answer" : answer
                    ])
                //"questions"キーでquestionsを保存
                userDefaults.set(questions, forKey: "questions")
                
                showAlert(message: "問題が保存されました！")
                print(questions)
                questionField.text = ""
                
            }
        }else{
            //何も文字が入力されていない時
            showAlert(message: "問題文を入力してください")
            
        }
     
    }
    
    @IBAction func tapAllDeleteButton(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        
        //保存されている問題と解答をすべて削除
        userDefaults.removeObject(forKey: "questions")
        
        /*    問題と解答を削除したので、キーが"questions"のオブジェクトの値がnilになる
         *  -> 読み込まれたときのエラーを回避するために値に空の配列を入れておく
         */
        userDefaults.set([], forKey: "questions")
        showAlert(message: "問題をすべて削除しました。")

    }
    // アラートを表示する関数
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }
    //Delegateを使ったメソッド
    //改行時に処理する
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
