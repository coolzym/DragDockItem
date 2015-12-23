//
//  ButtonArray.h
//  DragDockItem
//
//  Created by zhang minzhang min on 15/12/23.
//  Copyright © 2015年 zhang min. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MyButton;
@interface ButtonItem : NSObject

@property (readonly,nonatomic) NSArray *buttonArray; /*<! 按钮集合 */

@property (readonly,nonatomic) NSString *buttonDictKey; /*!< 按钮在字典中的key */
@property (readonly,nonatomic) NSString *buttonFlagDictKey; /*!< 按钮标识在字典中的key */

+(ButtonItem *)sharkButtonItem;

/**
 *  改变字典中按钮的标识
 *
 *  @param oneButton 要改变的按钮
 *  @param twoButton 要改变的按钮
 */
-(void)changeButtonFlagWithOneButton:(MyButton *)oneButton twoButton:(MyButton *)twoButton;

@end
