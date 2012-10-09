//
//  ViewController.m
//  WaterFlowDemo
//
//  Created by Xin Fan on 10/9/12.
//  Copyright (c) 2012 Xin Fan. All rights reserved.
//

#import "ViewController.h"
#import "TMQuiltView.h"
#import "TMPhotoQuiltViewCell.h"

@interface ViewController ()
@property (nonatomic, retain) NSArray *images;
@end

@implementation ViewController

@synthesize images = _images;

- (void)dealloc
{
    [_images release];
    [super dealloc];
}
- (NSArray *)images {
    if (!_images) {
        NSMutableArray *imageNames = [NSMutableArray array];
        for(int i = 0; i < 100; i++) {
            [imageNames addObject:[NSString stringWithFormat:@"%d.jpeg", i % 10 + 1]];
        }
        _images = [imageNames retain];
    }
    return _images;
}

- (UIImage *)imageAtIndexPath:(NSIndexPath *)indexPath {
    return [UIImage imageNamed:[self.images objectAtIndex:indexPath.row]];
}

- (NSInteger)quiltViewNumberOfCells:(TMQuiltView *)TMQuiltView {
    return [self.images count];
}

- (TMQuiltViewCell *)quiltView:(TMQuiltView *)quiltView cellAtIndexPath:(NSIndexPath *)indexPath {
    TMPhotoQuiltViewCell *cell = (TMPhotoQuiltViewCell *)[quiltView dequeueReusableCellWithReuseIdentifier:@"PhotoCell"];
    if (!cell) {
        cell = [[[TMPhotoQuiltViewCell alloc] initWithReuseIdentifier:@"PhotoCell"] autorelease];
    }
    
    cell.photoView.image = [self imageAtIndexPath:indexPath];
    cell.titleLabel.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
    return cell;
}

#pragma mark - TMQuiltViewDelegate

- (NSInteger)quiltViewNumberOfColumns:(TMQuiltView *)quiltView {
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft
        || [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight) {
        return 5;
    } else {
        return 3;
    }
}

- (CGFloat)quiltView:(TMQuiltView *)quiltView heightForCellAtIndexPath:(NSIndexPath *)indexPath {
    return [self imageAtIndexPath:indexPath].size.height / [self quiltViewNumberOfColumns:quiltView];
}

//- (CGFloat)quiltViewMargin:(TMQuiltView *)quilView marginType:(TMQuiltViewMarginType)marginType
//{
//    if (marginType == )
//}

- (void)quiltView:(TMQuiltView *)quiltView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.quiltView.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
