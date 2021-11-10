//
//  ContentView.swift
//  Barkly
//
//  Created by Dhruv Chowdhary on 11/1/21.
//

import SwiftUI
import UIKit

let screenerBig = "ScreenerBig"
let imageBig = UIImage(named: screenerBig)
let imageViewBig = UIImageView(image: imageBig!)

let screenerSmall = "ScreenerSmall"
let imageSmall = UIImage(named: screenerSmall)
let imageViewSmall = UIImageView(image: imageSmall!)

let now = Date()
let calendar = Calendar.current
let monthName = DateFormatter().monthSymbols[calendar.component(.month, from: now) - 1]

var usernameSave = UserDefaults.standard.string(forKey: "username")
var me = true

struct ContentView: View {
    var body: some View {
        if UIScreen.main.bounds.height > 779 {
            Image(uiImage: textToImageBig(drawText:"\(monthName) " + "\(calendar.component(.day, from: now))," + " \(calendar.component(.year, from: now))", inImage: drawRectangleOnImageBig(image: imageBig!)))
                .resizable()
                .scaledToFill()
                .position(x: (imageBig?.size.width)!/4, y: (imageBig?.size.height)!/4 - 48)
                .overlay(ImageOverlayBig(), alignment: .center)
                .ignoresSafeArea(.keyboard)
        } else {
            Image(uiImage: textToImageSmall(drawText:"\(monthName) " + "\(calendar.component(.day, from: now))," + " \(calendar.component(.year, from: now))", inImage: drawRectangleOnImageSmall(image: imageSmall!)))
                .resizable()
                .scaledToFill()
                .position(x: (imageSmall?.size.width)!/4, y: (imageSmall?.size.height)!/4 - 20)
                .overlay(ImageOverlaySmall(), alignment: .center)
                .ignoresSafeArea(.keyboard)
        }
    }
}

struct ImageOverlayBig: View {
    @State public var username: String = usernameSave ?? ""
    var body: some View {
        ZStack {
            if !me {
                TextField("Enter Name", text: $username)
                    .position(x: imageBig!.size.width/2, y: (imageSmall!.size.height/4) - 634)
                    .frame(width: imageBig!.size.width, height: 42, alignment: .center)
                    .fixedSize(horizontal: true, vertical: true)
                    .foregroundColor(Color(UIColor.init(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)))
                    .font(.system(size: 28, weight: .bold, design: .serif))
                    .multilineTextAlignment(.center)
                    .disableAutocorrection(true)
                let _ = saveUser(username: username)
            }
        }
    }
}

struct ImageOverlaySmall: View {
    @State private var username: String = usernameSave ?? ""
    var body: some View {
        ZStack {
            if !me {
                TextField("Enter Name", text: $username)
                    .position(x: imageSmall!.size.width/2, y: (imageSmall!.size.height/4) - 549.5)
                    .frame(width: imageSmall!.size.width, height: 42, alignment: .center)
                    .fixedSize(horizontal: true, vertical: true)
                    .foregroundColor(Color(UIColor.init(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)))
                    .font(.system(size: 28, weight: .bold, design: .serif))
                    .multilineTextAlignment(.center)
                    .disableAutocorrection(true)
                let _ = saveUser(username: username)
            }
        }
    }
}

func saveUser(username: String) {
    usernameSave = username
    UserDefaults.standard.set(username, forKey: "username")
}

func drawRectangleOnImageBig(image: UIImage) -> UIImage {
    let imageSize = image.size
    let scale: CGFloat = 0
    UIGraphicsBeginImageContextWithOptions(imageSize, false, scale)

    image.draw(at: CGPoint.zero)

    let rectangleBlue = CGRect(x: 0, y: (imageSize.height/2) - 865, width: imageSize.width, height: 70)
    UIColor.init(red: 0/255, green: 51/255, blue: 98/255, alpha: 1).setFill()
    UIRectFill(rectangleBlue)
    
    if !me {
        let rectangleWhite = CGRect(x: 0, y: (imageSize.height/2) - 650, width: imageSize.width, height: 60)
        UIColor.init(red: 1, green: 1, blue: 1, alpha: 1).setFill()
        UIRectFill(rectangleWhite)
    }
    
    let rectangleGreen = CGRect(x: 0, y: (imageSize.height/2) - 460, width: imageSize.width, height: 70)
    UIColor.init(red: 185/255, green: 211/255, blue: 181/255, alpha: 1).setFill()
    UIRectFill(rectangleGreen)

    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
}

func drawRectangleOnImageSmall(image: UIImage) -> UIImage {
    let imageSize = image.size
    let scale: CGFloat = 0
    UIGraphicsBeginImageContextWithOptions(imageSize, false, scale)

    image.draw(at: CGPoint.zero)
    
    let rectangleBlue = CGRect(x: 0, y: (imageSize.height/2) - 690, width: imageSize.width, height: 70)
    UIColor.init(red: 0/255, green: 51/255, blue: 98/255, alpha: 1).setFill()
    UIRectFill(rectangleBlue)
    
    if !me {
        let rectangleWhite = CGRect(x: 0, y: (imageSize.height/2) - 480, width: imageSize.width, height: 70)
        UIColor.init(red: 1, green: 1, blue: 1, alpha: 1).setFill()
        UIRectFill(rectangleWhite)
    }
    
    let rectangleGreen = CGRect(x: 0, y: (imageSize.height/2) - 285, width: imageSize.width, height: 70)
    UIColor.init(red: 185/255, green: 211/255, blue: 181/255, alpha: 1).setFill()
    UIRectFill(rectangleGreen)
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
}

func textToImageBig(drawText text: String, inImage image: UIImage) -> UIImage {
    let textColor = UIColor.init(red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
    let textFont = UIFont(name: "NotoSansKannada-Light", size: 70)!

    let scale = UIScreen.main.scale
    UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

    let textFontAttributes = [
        NSAttributedString.Key.font: textFont,
        NSAttributedString.Key.foregroundColor: textColor,
        ] as [NSAttributedString.Key : Any]
   // image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
    image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))

    let rect1 = CGRect(x: image.size.width/2 - (text as NSString).size(withAttributes: textFontAttributes).width/2, y: (image.size.height/2) - 460, width: image.size.width, height: 70)
    text.draw(in: rect1, withAttributes: textFontAttributes)

    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return newImage!
}

func textToImageSmall(drawText text: String, inImage image: UIImage) -> UIImage {
    let textColor = UIColor.init(red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
    let textFont = UIFont(name: "NotoSansKannada-Regular", size: 70)!

    let scale = UIScreen.main.scale
    UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

    let textFontAttributes = [
        NSAttributedString.Key.font: textFont,
        NSAttributedString.Key.foregroundColor: textColor,
        ] as [NSAttributedString.Key : Any]
   // image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
    image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))

    let rect1 = CGRect(x: image.size.width/2 - (text as NSString).size(withAttributes: textFontAttributes).width/2, y: (image.size.height/2) - 285, width: image.size.width, height: 70)
    text.draw(in: rect1, withAttributes: textFontAttributes)

    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return newImage!
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
