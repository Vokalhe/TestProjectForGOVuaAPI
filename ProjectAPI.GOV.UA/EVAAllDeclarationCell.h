//
//  EVAAllDeclarationCell.h
//  ProjectAPI.GOV.UA
//
//  Created by Admin on 28.04.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EVADeclaration;

@interface EVAAllDeclarationCell : UITableViewCell

@property (strong, nonatomic)  UILabel *nameLabel;
@property (strong, nonatomic)  UILabel *placeOfWorkLabel;
@property (strong, nonatomic)  UILabel *positionLabel;

@property (strong, nonatomic)  UIButton *pdfButton;
@property (strong, nonatomic)  UIButton *favoritiesButton;

+ (CGFloat) heightForDeclaration:(EVADeclaration*) declaration viewController: (UIViewController*) vc;
+(CGFloat) heightForText:(NSString *)text viewController: (UIViewController*) vc;
- (void) configureCellDeclaration:(EVADeclaration*) declaration viewController: (UIViewController*) vc;

@end
