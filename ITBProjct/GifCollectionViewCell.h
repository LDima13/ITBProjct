//
//  GifCollectionViewCell.h
//  ITBProjct
//
//  Created by Dmitry Likhtarov on 24/04/2019.
//  Copyright © 2019 Dmitry Likhtarov. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * _Nonnull GifCollectionViewCellReusableID = @"GifCollectionViewCellReusableID";
NS_ASSUME_NONNULL_BEGIN

@interface GifCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageGif;

@end

NS_ASSUME_NONNULL_END
