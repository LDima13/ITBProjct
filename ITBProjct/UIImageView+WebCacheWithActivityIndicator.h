//
//  UIImageView+WebCacheWithActivityIndicator.h
//  ITBProjct
//
//  Created by Dmitry Likhtarov on 26/04/2019.
//  Copyright © 2019 Dmitry Likhtarov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (WebCacheWithActivityIndicator)

// Пока грузится картинка из урл
// отображаем заставку - изображение с именем @"LaunchIcon"
// и крутится ромашка
// если изображение не загрузилось, то просто отключим ромашку
// и оставив заставку
//


@property (setter = setImageWithActivityIndicatorURL:) NSURL * _Nullable url;

@end

NS_ASSUME_NONNULL_END
