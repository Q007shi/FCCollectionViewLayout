//
//  FCCollectionViewSwiftLayout.swift
//  FCCollectionViewLayout
//
//  Created by 石富才 on 2020/8/17.
//

import UIKit

class FCCollectionViewDecorationViewMessageSwiftModel: NSObject{
    private var _decorationViewLayoutAttributes: UICollectionViewLayoutAttributes?
    var reuseIdentifier: String!
    var zIndex: Int = 0
    var section: Int = 0
    var decorationViewEdgeInsets: NSValue?
    var decorationViewSize: NSValue?
    var decorationViewCenter: Bool = false
    
    //********** 自定义 UICollectionViewLayoutAttributes
    var customLayoutAttributesClass : UICollectionViewLayoutAttributes.Type?
    var customParams: NSDictionary?
    
    //**********
    
    var decorationViewLayoutAttributes: UICollectionViewLayoutAttributes!{
        get{
            if let temmpDecorationViewLayoutAttributes = _decorationViewLayoutAttributes {
                return temmpDecorationViewLayoutAttributes
            }else{
                
                if customLayoutAttributesClass != nil{
                    
                }else{
                    _decorationViewLayoutAttributes = UICollectionViewLayoutAttributes(forDecorationViewOfKind: reuseIdentifier, with: IndexPath(item: 0, section: section))
                }
            }
            return _decorationViewLayoutAttributes
        }
        set{
            _decorationViewLayoutAttributes = newValue
        }
    }
}

class FCCollectionViewSwiftLayout: UICollectionViewLayout {
    
    override func prepare() {
        
    }
    
}

extension FCCollectionViewSwiftLayout{
    ///布局方式
    public enum FCCollectionViewSwiftLayoutType: Int{
        case Flow = 0
        case Water = 1
    }
}

public protocol FCCollectionViewSwiftLayoutDelegate: UICollectionViewDelegateFlowLayout{
    
}
