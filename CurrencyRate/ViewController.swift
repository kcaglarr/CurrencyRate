//
//  ViewController.swift
//  CurrencyRate
//
//  Created by Kerim Çağlar on 29/11/2016.
//  Copyright © 2016 Kerim Çağlar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sellingDollar: UILabel!
    
    @IBOutlet weak var buyingDollar: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let url = NSURL(string: "http://www.doviz.com/api/v1/currencies/all/latest")
        let task = URLSession.shared.dataTask(with: url as! URL){(data,response,error) -> Void in
            
            if error != nil
            {
                print(error!)
            }
            else
            {
                if let urlContent = data
                {
                    do
                    {
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        if let currencyRate = jsonResult as? NSArray
                        {
                            for i in 0..<1 //currencyRate.count ile hepsi alınabilir
                            {
                                if let dollarBuying = (currencyRate[i] as? NSDictionary)?["buying"] as? Double
                                {
                                    print("Alis:\(dollarBuying)")
                                    
                                    DispatchQueue.main.async(execute:{
                                        self.buyingDollar.text = String(dollarBuying)
                                    })

                                }
                                if let dollarSelling = (currencyRate[i] as? NSDictionary)?["selling"] as? Double
                                {
                                    print("Satis:\(dollarSelling)")
                                    DispatchQueue.main.async(execute: {
                                        self.sellingDollar.text = String(dollarSelling)
                                    })
                                }
                                

                            }
                        }


                    }
                    
                    catch
                    {
                        print("HATA")
                    }

                }
            }
        }
        
        task.resume()
    }
}

