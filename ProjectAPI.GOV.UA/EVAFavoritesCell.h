//
//  EVAFavoritesCell.h
//  ProjectAPI.GOV.UA
//
//  Created by Admin on 30.04.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DeclarationCoreData;

@interface EVAFavoritesCell : UITableViewCell

@property (strong, nonatomic)  UILabel *nameFavoritesLabel;
@property (strong, nonatomic)  UILabel *placeOfWorkFavoritesLabel;
@property (strong, nonatomic)  UILabel *positionFavoritesLabel;
@property (strong, nonatomic)  UILabel *commentFavoritesLabel;

@property (strong, nonatomic)  UIButton *addCommentButton;

+ (CGFloat) heightForDeclaration:(DeclarationCoreData*) declaration viewController: (UIViewController*) vc;
+(CGFloat) heightForText:(NSString *)text viewController: (UIViewController*) vc;
- (void) configureCellDeclaration:(DeclarationCoreData*) declaration viewController: (UIViewController*) vc;

@end
