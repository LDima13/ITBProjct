//
//  FirstViewController.m
//  ITBProjct
//
//  Created by Dmitry Likhtarov on 24/04/2019.
//  Copyright © 2019 Dmitry Likhtarov. All rights reserved.
//
// Поскольку у Giphy нет готового API для objective-c
// Использую сторонние библиотеку
// https://github.com/heyalexchoi/Giphy-iOS
// Альтернатива этому использовать прямые запросы к ихнему апи
// приметр кода можно посмотреть в моем коде для доступа к  VK
// https://github.com/LDima13/VkShowPost
// Но в рамках задания не конкретезироан метод
// поэтому идем по линии наименьших затрат времени:)
//


#import "FirstViewController.h"
#import "GifCollectionViewCell.h"
#import <Giphy-iOS/AXCGiphy.h>
#import "UIImageView+WebCacheWithActivityIndicator.h"
#import "DetailViewController.h"

@interface FirstViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *gifCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *foundLable;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSearch;
@property (nonatomic, strong) NSArray <AXCGiphy *> * gifs;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.foundLable.text = @"";
    
    [AXCGiphy setGiphyAPIKey:@"D3TLVC4AA5iSzJOaYn32CZU6B3rwF9d6"];
}

- (IBAction)searchPressed:(id)sender {
    NSString *text = self.textFieldSearch.text;
    if (text.length < 1) return;
    [self.activity startAnimating];
    // NSURLSessionDataTask * task =
    [[AXCGiphy searchGiphyWithTerm:text limit:25 offset:0 completion:^(NSArray *results, NSError *error) {
        NSLog(@"Найдено: %ld", results.count);
        self.gifs = results;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.activity stopAnimating];
            self.foundLable.text = [NSString stringWithFormat:@"Найдено: %ld", results.count];
            [self.gifCollectionView reloadData];
        }];
    }] resume];
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.gifs.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    GifCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GifCollectionViewCellReusableID forIndexPath:indexPath];
    
    cell.imageGif.url = self.gifs[indexPath.item].originalImage.url;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(nonnull UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    // Автоподгоним размер по ширине
    if (collectionView == self.gifCollectionView) {
        CGFloat wspace = 10;  // Примерное расстояние между ячейками, в IB или коде еще поставить такой же minSpace!
        CGFloat width = (collectionView.frame.size.width  - wspace * 4) / 3; // 2 колонки
        return CGSizeMake(width, width);
    }
    return CGSizeMake(100, 100);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    DetailViewController *vc = (DetailViewController*)[self.storyboard  instantiateViewControllerWithIdentifier:@"DetailViewController"];    
    [self presentViewController:vc animated:YES completion:^{
        vc.imageViewGif.url = self.gifs[indexPath.item].originalImage.url;
    }];
}

@end
