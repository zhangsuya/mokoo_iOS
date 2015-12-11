//
//  ModelCardViewController.m
//  mokoo
//
//  Created by Mac on 15/9/14.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ModelCardViewController.h"
#import "MJExtension.h"
#import "MCCollectionViewCell.h"
#import "ModelCardCollectionViewLayout.h"
#import "ModelCardModel.h"
#import "MJRefresh.h"
@interface ModelCardViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,MCwaterFlowDelegate>
@property(nonatomic,retain)UICollectionView * collectView;
@property(nonatomic,strong)NSMutableArray * shops;
@end

@implementation ModelCardViewController
-(NSMutableArray *)shops
{
    if (_shops==nil) {
        self.shops = [NSMutableArray array];
    }
    return _shops;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据
    NSArray * shopsArray = [ModelCardModel objectArrayWithFilename:@"1.plist"];
    [self.shops addObjectsFromArray:shopsArray];
    //注册cell
    ModelCardCollectionViewLayout * layOut = [[ModelCardCollectionViewLayout alloc] init];
    layOut.degelate =self;
    //调整collectView的frame
    UICollectionView * collectView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layOut];
    collectView.delegate =self;
    collectView.dataSource =self;
    [self.view addSubview:collectView];
    [collectView registerNib:[UINib nibWithNibName:@"ZWCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    self.collectView = collectView;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shops.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MCCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    cell.shop = self.shops[indexPath.item];
    return cell;
}
//代理方法
-(CGFloat)MCwaterFlow:(ModelCardCollectionViewLayout *)waterFlow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPach
{
    ModelCardModel * shop = self.shops[indexPach.item];
    return shop.height/shop.width*width;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
