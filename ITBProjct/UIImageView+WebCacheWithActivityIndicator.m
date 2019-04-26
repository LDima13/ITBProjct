//
//  UIImageView+WebCacheWithActivityIndicator.m
//  ITBProjct
//
//  Created by Dmitry Likhtarov on 26/04/2019.
//  Copyright © 2019 Dmitry Likhtarov. All rights reserved.
//

#import "UIImageView+WebCacheWithActivityIndicator.h"

@implementation UIImageView (WebCacheWithActivityIndicator)

@dynamic url;

- (void) setImageWithActivityIndicatorURL:( NSURL * _Nullable)url
{
    
    __block UIActivityIndicatorView* activ = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    // поставим ромашку в центре
    CGRect frame = activ.frame;
    frame.origin.x = (self.frame.size.width - frame.size.width) / 2;
    frame.origin.y = (self.frame.size.height - frame.size.height) / 2;
    [activ setFrame:frame];
    
    [self addSubview:activ];
    
    [activ startAnimating];
    
    [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"LaunchIcon"] options:0 completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        [activ stopAnimating];
        [activ removeFromSuperview];
        
    }];
    
}

@end
