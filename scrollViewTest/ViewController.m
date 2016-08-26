//
//  ViewController.m
//  scrollViewTest
//
//  Created by Ashuro on 16/8/26.
//  Copyright © 2016年 Ashuro. All rights reserved.
//

#import "ViewController.h"

#define screen_width [UIScreen mainScreen].bounds.size.width
#define img_height 150

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic , strong) UIScrollView *mySC;
@property (nonatomic , strong) UIScrollView *oneSC;
@property (nonatomic , strong) UIScrollView *twoSC;
@property (nonatomic , strong) UIScrollView *threeSC;

@property (nonatomic , strong) UIImageView *oneIMG;
@property (nonatomic , strong) UIImageView *twoIMG;
@property (nonatomic , strong) UIImageView *threeIMG;

//DIRTY FLAG - 可优化
@property (nonatomic , assign) BOOL imgOneOpened;
@property (nonatomic , assign) BOOL imgTwoOpened;
@property (nonatomic , assign) BOOL imgThreeOpened;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //构建底板的大ScrollView
    self.mySC = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_width, img_height)];
    self.mySC.pagingEnabled = YES;
    self.mySC.scrollEnabled = YES;
    self.mySC.contentSize = CGSizeMake(screen_width * 3, 150);
    self.mySC.delegate = self;
    self.mySC.tag = 101;
    self.mySC.bounces = NO;
    UITapGestureRecognizer *imgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapIMGAction:)];
    [self.mySC addGestureRecognizer:imgTap];
    [self.topView addSubview:self.mySC];
    
    //构建循环的三个ScrollView;
    self.oneSC = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screen_width, img_height)];
    self.oneSC.scrollEnabled = YES;
    self.oneSC.contentSize = CGSizeMake(screen_width, img_height);
    self.oneSC.bounces = NO;
    self.oneSC.tag = 201;
    [self.mySC addSubview:self.oneSC];
    self.oneIMG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, img_height)];
    self.oneIMG.image = [UIImage imageNamed:@"demo1.jpg"];
    [self.oneSC addSubview:self.oneIMG];
    //
    self.twoSC = [[UIScrollView alloc]initWithFrame:CGRectMake(screen_width, 0, screen_width, img_height)];
    self.twoSC.scrollEnabled = YES;
    self.twoSC.contentSize = CGSizeMake(screen_width, img_height);
    self.twoSC.bounces = NO;
    self.twoSC.tag = 202;
    [self.mySC addSubview:self.twoSC];
    self.twoIMG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, img_height)];
    self.twoIMG.image = [UIImage imageNamed:@"demo2.jpg"];
    [self.twoSC addSubview:self.twoIMG];
    //
    self.threeSC = [[UIScrollView alloc]initWithFrame:CGRectMake(screen_width * 2, 0, screen_width, img_height)];
    self.threeSC.scrollEnabled = YES;
    self.threeSC.contentSize = CGSizeMake(screen_width, img_height);
    self.threeSC.bounces = NO;
    self.threeSC.tag = 203;
    [self.mySC addSubview:self.threeSC];
    self.threeIMG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, img_height)];
    self.threeIMG.image = [UIImage imageNamed:@"demo3.jpg"];
    [self.threeSC addSubview:self.threeIMG];
}


#pragma mark - 单击放大手势

- (void) tapIMGAction: (UITapGestureRecognizer *) sender {
    
    
    if (self.mySC.contentOffset.x == 0) {
        
        self.imgOneOpened = !self.imgOneOpened;
        
        if (self.imgOneOpened) {
            
            self.oneIMG.frame = CGRectMake(0, 0, self.oneIMG.image.size.width, self.oneIMG.image.size.height);
            self.oneIMG.contentMode = UIViewContentModeScaleAspectFill;
            self.oneSC.contentSize = self.oneIMG.image.size;
            [self.oneSC setContentOffset:CGPointMake(self.oneIMG.image.size.width/2, self.oneIMG.image.size.height/2)];
            
        } else {
            
            self.oneIMG.frame = CGRectMake(0, 0, screen_width, img_height);
            self.oneIMG.contentMode = UIViewContentModeScaleToFill;
            self.oneSC.contentSize = CGSizeMake(screen_width, img_height);
            
        }
        
    } else if (self.mySC.contentOffset.x == screen_width) {
        
        self.imgTwoOpened = !self.imgTwoOpened;
        
        if (self.imgTwoOpened) {
            
            self.twoIMG.frame = CGRectMake(0, 0, self.twoIMG.image.size.width, self.twoIMG.image.size.height);
            self.twoIMG.contentMode = UIViewContentModeScaleAspectFill;
            self.twoSC.contentSize = self.twoIMG.image.size;
            [self.twoSC setContentOffset:CGPointMake(self.twoIMG.image.size.width/2, self.twoIMG.image.size.height/2)];
            
        } else {
            
            self.twoIMG.frame = CGRectMake(0, 0, screen_width, img_height);
            self.twoIMG.contentMode = UIViewContentModeScaleToFill;
            self.twoSC.contentSize = CGSizeMake(screen_width, img_height);
            
        }
        
    } else {
        
        self.imgThreeOpened = !self.imgThreeOpened;
        
        if (self.imgThreeOpened) {
            
            self.threeIMG.frame = CGRectMake(0, 0, self.threeIMG.image.size.width, self.threeIMG.image.size.height);
            self.threeIMG.contentMode = UIViewContentModeScaleAspectFill;
            self.threeSC.contentSize = self.threeIMG.image.size;
            [self.threeSC setContentOffset:CGPointMake(self.threeIMG.image.size.width/2, self.threeIMG.image.size.height/2)];
            
        } else {
            
            self.threeIMG.frame = CGRectMake(0, 0, screen_width, img_height);
            self.threeIMG.contentMode = UIViewContentModeScaleToFill;
            self.threeSC.contentSize = CGSizeMake(screen_width, img_height);
            
        }
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
