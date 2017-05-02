//
//  EVAAllDeclarationCell.m
//  ProjectAPI.GOV.UA
//
//  Created by Admin on 28.04.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "EVAAllDeclarationCell.h"
#import "EVADeclaration.h"

@implementation EVAAllDeclarationCell

+(CGFloat) heightForText:(NSString *)text viewController: (UIViewController*) vc{
    CGFloat widthView = CGRectGetWidth(vc.view.bounds);
    
    CGFloat offset = 10.0;
    UIFont *font = [UIFont systemFontOfSize:14.f];
    
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


+ (CGFloat) heightForDeclaration:(EVADeclaration*) declaration viewController: (UIViewController*) vc {
    
    CGFloat heightImageButton = 35;
    
    CGFloat separatorHeight = 5;
    
    CGFloat height = separatorHeight + heightImageButton + 5;
    
    if (declaration.nameString) {
        CGFloat heightForText = [EVAAllDeclarationCell heightForText:declaration.nameString viewController:vc];
        height += heightForText + 5;
    }
    if (declaration.placeOfWorkString) {
        CGFloat heightForText = [EVAAllDeclarationCell heightForText:declaration.placeOfWorkString viewController:vc];
        height += heightForText + 5;
    }
    if (declaration.positionString) {
        CGFloat heightForText = [EVAAllDeclarationCell heightForText:declaration.positionString viewController:vc];
        height += heightForText + 5;
    }
    
    return height;
}


- (void) configureCellDeclaration:(EVADeclaration*) declaration viewController: (UIViewController*) vc {
    
    for (UIView* view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    // Separator
    CGRect frameForSeparator = CGRectMake(0, 5, self.frame.size.width, 5);
    UIView* separator = [[UIView alloc] initWithFrame:frameForSeparator];
    separator.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:separator];
    
    CGFloat originY = CGRectGetHeight(frameForSeparator);
    
    if (declaration.nameString) {
        
        CGFloat heightForText = [EVAAllDeclarationCell heightForText:declaration.nameString viewController:vc];
        CGRect frameForTextLabel = CGRectMake(10, originY+5, CGRectGetWidth(vc.view.bounds)-20, heightForText);
        self.nameLabel = [[UILabel alloc] initWithFrame:frameForTextLabel];
        self.nameLabel.numberOfLines = 0;
        self.nameLabel.font = [self.nameLabel.font fontWithSize:14];
        
        [self.contentView addSubview:self.nameLabel];
        originY += CGRectGetHeight(self.nameLabel.bounds)+5;
    }
    
    if (declaration.placeOfWorkString) {
        
        CGFloat heightForText = [EVAAllDeclarationCell heightForText:declaration.placeOfWorkString viewController:vc];
        CGRect frameForTextLabel = CGRectMake(10, originY+5, CGRectGetWidth(vc.view.bounds)-20, heightForText);
        self.placeOfWorkLabel = [[UILabel alloc] initWithFrame:frameForTextLabel];
        self.placeOfWorkLabel.numberOfLines = 0;
        self.placeOfWorkLabel.font = [self.placeOfWorkLabel.font fontWithSize:14];
        self.placeOfWorkLabel.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:self.placeOfWorkLabel];
        originY += CGRectGetHeight(self.placeOfWorkLabel.bounds)+5;
    }

    if (declaration.positionString) {
        
        CGFloat heightForText = [EVAAllDeclarationCell heightForText:declaration.positionString viewController:vc];
        CGRect frameForTextLabel = CGRectMake(10, originY+5, CGRectGetWidth(vc.view.bounds)-20, heightForText);
        self.positionLabel = [[UILabel alloc] initWithFrame:frameForTextLabel];
        self.positionLabel.numberOfLines = 0;
        self.positionLabel.font = [self.positionLabel.font fontWithSize:12];
        
        [self.contentView addSubview:self.positionLabel];
        originY += CGRectGetHeight(self.positionLabel.bounds)+5;
    }

    
    
    CGRect frameForPDFButton = CGRectMake(20, originY+5, 35, 35);
    CGRect frameForFavoritiesButton = CGRectMake(CGRectGetWidth(vc.view.bounds)-55, originY+5, 35, 35);
    
    self.pdfButton = [[UIButton alloc] initWithFrame:frameForPDFButton];
    [self.contentView addSubview:self.pdfButton];
    
    self.favoritiesButton = [[UIButton alloc] initWithFrame:frameForFavoritiesButton];
    [self.contentView addSubview:self.favoritiesButton];
    
    
    
}

@end
