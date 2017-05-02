//
//  EVAFavoritesCell.m
//  ProjectAPI.GOV.UA
//
//  Created by Admin on 30.04.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "EVAFavoritesCell.h"
#import "DeclarationCoreData.h"

@implementation EVAFavoritesCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(CGFloat) heightForText:(NSString *)text viewController: (UIViewController*) vc{
    CGFloat widthView = CGRectGetWidth(vc.view.bounds);
    
    CGFloat offset = 10.0;
    UIFont *font = [UIFont systemFontOfSize:16.f];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(0, -1);
    shadow.shadowBlurRadius = 0.5;
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    [paragraph setLineBreakMode:NSLineBreakByWordWrapping];
    [paragraph setAlignment:NSTextAlignmentCenter];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                font, NSFontAttributeName,
                                paragraph, NSParagraphStyleAttributeName, nil];
    
    CGRect rect = [text boundingRectWithSize: CGSizeMake(widthView-2*offset, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    
    return CGRectGetHeight(rect);
    
}
////


+ (CGFloat) heightForDeclaration:(DeclarationCoreData*) declaration viewController: (UIViewController*) vc {
    
    CGFloat heightImageButton = 35;
    
    CGFloat separatorHeight = 10;
    
    CGFloat height = separatorHeight + 10;
    
    if (declaration.name) {
        CGFloat heightForText = [EVAFavoritesCell heightForText:declaration.name viewController:vc];
        height += heightForText + 5;
    }
    if (declaration.placeOfWork) {
        CGFloat heightForText = [EVAFavoritesCell heightForText:declaration.placeOfWork viewController:vc];
        height += heightForText + 5;
    }
    if (declaration.position) {
        CGFloat heightForText = [EVAFavoritesCell heightForText:declaration.position viewController:vc];
        height += heightForText + 5;
    }
    if (declaration.comment) {
        CGFloat heightForText = [EVAFavoritesCell heightForText:declaration.comment viewController:vc];
        
        if (heightForText > heightImageButton) {
            height += heightForText + 5;
        }else{
            height += heightImageButton + 5;
        }
    }else{
        height += heightImageButton + 5;
    }
    NSLog(@"%@", declaration.name);
    return height;
}


- (void) configureCellDeclaration:(DeclarationCoreData*) declaration viewController: (UIViewController*) vc {
    
    for (UIView* view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    // Separator
    CGRect frameForSeparator = CGRectMake(0, 0, self.frame.size.width, 10);
    UIView* separator = [[UIView alloc] initWithFrame:frameForSeparator];
    separator.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:separator];
    
    CGFloat originY = CGRectGetHeight(frameForSeparator);
    
    if (declaration.name) {
        
        CGFloat heightForText = [EVAFavoritesCell heightForText:declaration.name viewController:vc];
        CGRect frameForTextLabel = CGRectMake(10, originY+5, CGRectGetWidth(vc.view.bounds)-20, heightForText);
        self.nameFavoritesLabel = [[UILabel alloc] initWithFrame:frameForTextLabel];
        self.nameFavoritesLabel.numberOfLines = 0;
        self.nameFavoritesLabel.font = [self.nameFavoritesLabel.font fontWithSize:13];
        
        [self.contentView addSubview:self.nameFavoritesLabel];
        originY += CGRectGetHeight(self.nameFavoritesLabel.bounds)+5;
    }
    
    if (declaration.placeOfWork) {
        
        CGFloat heightForText = [EVAFavoritesCell heightForText:declaration.placeOfWork viewController:vc];
        CGRect frameForTextLabel = CGRectMake(10, originY+5, CGRectGetWidth(vc.view.bounds)-20, heightForText);
        self.placeOfWorkFavoritesLabel = [[UILabel alloc] initWithFrame:frameForTextLabel];
        self.placeOfWorkFavoritesLabel.numberOfLines = 0;
        self.placeOfWorkFavoritesLabel.font = [self.placeOfWorkFavoritesLabel.font fontWithSize:14];
        self.placeOfWorkFavoritesLabel.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:self.placeOfWorkFavoritesLabel];
        originY += CGRectGetHeight(self.placeOfWorkFavoritesLabel.bounds)+5;
    }
    
    if (declaration.position) {
        
        CGFloat heightForText = [EVAFavoritesCell heightForText:declaration.position viewController:vc];
        CGRect frameForTextLabel = CGRectMake(10, originY+5, CGRectGetWidth(vc.view.bounds)-20, heightForText);
        self.positionFavoritesLabel = [[UILabel alloc] initWithFrame:frameForTextLabel];
        self.positionFavoritesLabel.numberOfLines = 0;
        self.positionFavoritesLabel.font = [self.positionFavoritesLabel.font fontWithSize:12];
        
        [self.contentView addSubview:self.positionFavoritesLabel];
        originY += CGRectGetHeight(self.positionFavoritesLabel.bounds)+5;
    }
    
    if (declaration.comment) {
        
        CGFloat heightForText = [EVAFavoritesCell heightForText:declaration.comment viewController:vc];
        CGRect frameForTextLabel = CGRectMake(10, originY+5, CGRectGetWidth(vc.view.bounds)-70, heightForText);
        self.commentFavoritesLabel = [[UILabel alloc] initWithFrame:frameForTextLabel];
        self.commentFavoritesLabel.numberOfLines = 0;
        self.commentFavoritesLabel.font = [self.commentFavoritesLabel.font fontWithSize:13];
        self.commentFavoritesLabel.textColor = [UIColor darkGrayColor];

        [self.contentView addSubview:self.commentFavoritesLabel];
    }

    
    
    CGRect frameForAddCommentButton = CGRectMake(CGRectGetWidth(vc.view.bounds)-55, originY+5, 35, 35);
    
    self.addCommentButton = [[UIButton alloc] initWithFrame:frameForAddCommentButton];
    [self.addCommentButton setImage:[UIImage imageNamed:@"Comment.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.addCommentButton];
    
    
    
    
}

@end
