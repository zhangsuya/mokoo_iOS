//
//  SYPickView.m
//  mokoo
//
//  Created by Mac on 15/9/1.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "SYPickView.h"
#import "MokooMacro.h"
@interface SYPickView()
{
    NSInteger selectedIndex;
}
@end
@implementation SYPickView
//进行初始化
- (id)initWithFrame:(CGRect)frame
{
    self.containerView = [[UIView alloc]initWithFrame:frame];
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:0];
        //        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
        //        [self addGestureRecognizer:tapGesture];
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
//    self.backgroundColor = [UIColor clearColor];
//    self.layer.shouldRasterize = YES;
//    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
//    //    self.backgroundColor = [UIColor blackColor];
//    //    self.alpha = 0.7;
//    self.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight);
//    if (self.containerView.frame.size.height<241 || self.containerView.frame.size.width<320)
//        self.containerView.frame = CGRectMake(self.containerView.frame.origin.x, self.containerView.frame.origin.y, kDeviceWidth, 241);
//
//    
//    UILabel *topLine = nil;
//    if (!topLine) {
//        topLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 22, self.containerView.frame.size.width, 1)];
//        topLine.backgroundColor = [UIColor blackColor];
//        [self.containerView addSubview:topLine];
//    }
    
    
    if (!_myPickerView) {
        _myPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _myPickerView.showsSelectionIndicator = YES;
        _myPickerView.backgroundColor = [UIColor whiteColor];
        _myPickerView.delegate = self;
        _myPickerView.dataSource = self;
        [self addSubview:_myPickerView];
    }
    [_myPickerView selectRow:_selectedIndex inComponent:0 animated:NO];
//    UILabel *okBtn = nil;
//    UILabel *cancelBtn = nil;
//    UILabel *bottomLine = nil;
//    UILabel *midLine = nil;
//    if (!bottomLine) {
//        bottomLine = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(myPickerView.frame), self.containerView.frame.size.width, 1)];
//        bottomLine.backgroundColor = [UIColor blackColor];
//        [self.containerView addSubview:bottomLine];
//    }
//    if (!midLine) {
//        midLine = [[UILabel alloc]initWithFrame:CGRectMake(self.containerView.frame.size.width/2, CGRectGetMaxY(bottomLine.frame), 1, 21)];
//        midLine.backgroundColor = [UIColor blackColor];
//        [self.containerView addSubview:midLine];
//    }
//    if (!okBtn) {
//        okBtn = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(myPickerView.frame) +1, self.containerView.frame.size.width/2-1, 29)];
//        [okBtn setText:@"确定"];
//        [okBtn setFont:[UIFont systemFontOfSize:17]];
//        [okBtn setBackgroundColor:[UIColor whiteColor]];
//        okBtn.textAlignment = NSTextAlignmentCenter;
//        [self.containerView addSubview:okBtn];
//    }
//    if (!cancelBtn) {
//        cancelBtn = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2, CGRectGetMaxY(myPickerView.frame) +1, self.containerView.frame.size.width/2-1, 29)];
//        [cancelBtn setText:@"取消"];
//        [cancelBtn setFont:[UIFont systemFontOfSize:17]];
//        [cancelBtn setBackgroundColor:[UIColor whiteColor]];
//        cancelBtn.textAlignment = NSTextAlignmentCenter;
//        [self.containerView addSubview:cancelBtn];
//    }
    
    //    [okBtn addTarget:self action:@selector(okBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    //    [cancelBtn addTarget:self action:@selector(cancelBtnCilcked:) forControlEvents:UIControlEventTouchUpInside];
    //调整为现在的时间
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(okBtnClicked:)];
//    okBtn.userInteractionEnabled = YES;
//    [okBtn addGestureRecognizer:tap];
//    
//    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelBtnClicked:)];
//    cancelBtn.userInteractionEnabled = YES;
//    [cancelBtn addGestureRecognizer:tap1];
//    for (int i=0; i<indexArray.count; i++) {
//        [myPickerView selectRow:[indexArray[i] integerValue] inComponent:i animated:NO];
//    }
//    [self addSubview:self.containerView];
    //    self.layer.shadowOpacity = 0.4;
    //    self.layer.opacity = 0.5f;
    //    self.layer.transform = CATransform3DMakeScale(1.3f, 1.3f, 1.0);
    //    self.backgroundColor = [UIColor clearColor];
    //    self.backgroundColor = [UIColor greenColor];
    //    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
}
#pragma mark - 调整颜色
-(void)okBtnClicked:(UITapGestureRecognizer *)tap
{
    [self removeFromSuperview];
    if ([_delegate respondsToSelector:@selector(passValue:)] ) {
        [_delegate passValue:_selectedArray[selectedIndex]];
    }
    if ([_delegate respondsToSelector:@selector(passItem:)]) {
        [_delegate passItem:selectedIndex];
    }
}

-(void)cancelBtnClicked:(UITapGestureRecognizer *)tap
{
    [self removeFromSuperview];
    if ([_delegate respondsToSelector:@selector(cancelBtnClicked)] ) {
        [_delegate cancelBtnClicked];
    }
    
}


#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.selectedArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if ([_delegate respondsToSelector:@selector(passValue:)] ) {
        [_delegate passValue:[self.selectedArray objectAtIndex:row]];
    }
    if ([_delegate respondsToSelector:@selector(passItem:)]) {
        [_delegate passItem:selectedIndex];
    }
    return [self.selectedArray objectAtIndex:row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return kDeviceWidth;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    selectedIndex = row;
    [pickerView reloadAllComponents];
    
}

@end
