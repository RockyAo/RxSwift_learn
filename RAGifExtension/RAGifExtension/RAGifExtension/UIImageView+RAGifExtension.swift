//
//  UIImageView+RAGifExtension.swift
//  RAGifExtension
//
//  Created by Rocky on 2017/3/19.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import UIKit
import ImageIO

extension UIImageView{
    
    
    
    /// 分解Gif图片
    ///
    /// - Parameter gifPath: gif图片路径
    /// - Returns: 单个图片数组
    class func decodeGifImage(gifPath:String!) -> Array<UIImage>{
    
        var gifData:Data?
        
        do {
            
            try gifData = Data(contentsOf: URL(fileURLWithPath: gifPath))
            
        }  catch {
                
            print("初始化数据失败 \(error)")
        }
        
        guard let gdata = gifData else {
            
            print("gif数据初始化失败")
            
            return []
        }
    
        let imageSource:CGImageSource = CGImageSourceCreateWithData(gdata as CFData, nil)!
        
        let imageCount = CGImageSourceGetCount(imageSource)
        
        
        var imageArray = [UIImage]()
        
        for i in 0..<imageCount{
            
            guard let imageref = CGImageSourceCreateImageAtIndex(imageSource, i, nil) else{
            
                print("分解图片失败")
                
                break
            }
            
            let image = UIImage(cgImage: imageref, scale: UIScreen.main.scale, orientation: UIImageOrientation.up)
            
            imageArray.append(image)
        }
        
        return imageArray
    }
    
    
    
}
