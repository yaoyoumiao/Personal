//
//  ViewController.m
//  Personal
//
//  Created by yaoyoumiao on 16/2/17.
//  Copyright © 2016年 ZTE. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+ImageEffects.h"
#import "UIView+JKPicker.h"

static CGFloat kBgHeight = 200;
@interface ViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, weak) NSLayoutConstraint *headerH;
@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden = YES;
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.contentInset = UIEdgeInsetsMake(kBgHeight, 0, 0, 0);
    [self.view addSubview:_myTableView];
    [self.view addSubview:self.headImageView];
    self.headImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.headerH = [NSLayoutConstraint constraintWithItem:self.headImageView
                                                attribute:NSLayoutAttributeHeight
                                                relatedBy:NSLayoutRelationEqual
                                                   toItem:nil
                                                attribute:NSLayoutAttributeNotAnAttribute
                                               multiplier:1
                                                 constant:kBgHeight];
    [self.view addConstraint:self.headerH];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_headImageView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_myTableView
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_headImageView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:0]];
}

#pragma mark - lazyload
- (UIImageView *)headImageView
{
    if(!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, kBgHeight)];
        _headImageView.image = [[UIImage imageNamed:@"newBgImage@2x.jpg"] applyDarkEffect];
    }
    return _headImageView;
}

#pragma mark - scroll delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat h = kBgHeight - (scrollView.contentOffset.y + kBgHeight);
    if(h < 64) {
        h = 64;
    }
    self.headerH.constant = h;
}

#pragma mark - table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 19;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.textLabel.text = @"新年快乐";
    return cell;
}

@end
