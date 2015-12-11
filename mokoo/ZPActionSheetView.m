//
//  ZPActionSheetView.m
//  NothingIsImpossible
//
//  Created by hztuen on 15/8/19.
//  Copyright (c) 2015年 hztuen. All rights reserved.
//

#import "ZPActionSheetView.h"

@implementation ZPActionSheetView

@synthesize delegate;

-(void)setFrame:(CGRect)frame
{
    CGSize size=[UIScreen mainScreen].bounds.size;
    CGRect newFrame = CGRectMake(0,0,size.width,size.height);
    
    [super setFrame:newFrame];
}

-(id)init
{
    if (self =[super init])
    {
        CGSize size=[UIScreen mainScreen].bounds.size;
        UIImageView *bgIV=[[UIImageView alloc]initWithFrame:self.frame];
        bgIV.backgroundColor=[UIColor blackColor];
        bgIV.alpha=0.1;
        [self addSubview:bgIV];
        NSLog(@"size=%f",size.width);
        CGRect newFrame = CGRectMake(0,size.height,size.width,125);
         view=[[UIView alloc]initWithFrame:newFrame];
        [self addSubview:view];
        view.backgroundColor=[UIColor whiteColor];
        
        UIImageView *line1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 40, size.width,1)];
        line1.backgroundColor=[UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1];
        [view addSubview:line1];
        
        UIImageView *line2=[[UIImageView alloc]initWithFrame:CGRectMake(0, 81, size.width,5)];
        line2.backgroundColor=[UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1];
        [view addSubview:line2];

        UIButton* button1=[[UIButton alloc]initWithFrame:CGRectMake(0,0, size.width, 40)];
        [button1 setTitle:@"拍照" forState:UIControlStateNormal];
        button1.titleLabel.font=[UIFont systemFontOfSize:13];
        
         [view addSubview:button1];
        [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button1.tag=0;
        [button1 addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton* button2=[[UIButton alloc]initWithFrame:CGRectMake(0,41, size.width, 40)];
        [button2 setTitle:@"从手机相册中取出" forState:UIControlStateNormal];
        button2.titleLabel.font=[UIFont systemFontOfSize:13];
        button2.tag=1;
        [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
         [view addSubview:button2];
        [button2 addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton* button3=[[UIButton alloc]initWithFrame:CGRectMake(0,90, size.width, 40)];
        [button3 setTitle:@"取消" forState:UIControlStateNormal];
        button3.titleLabel.font=[UIFont systemFontOfSize:13];
         [button3 addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
        [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

         [view addSubview:button3];
        button=[[UIButton alloc]initWithFrame:CGRectMake(0,0, size.width, size.height-125)];
        [button addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
        button.userInteractionEnabled=NO;
        [self addSubview:button];
        [self pushView];
        }
    return self;
}

 -(void)pushView
{
     [UIView animateWithDuration:0.2 animations:^{
         view.frame = CGRectMake(0,self.frame.size.height-125,view.frame.size.width,view.frame.size.height);
    } completion:^(BOOL finished) {
        button.userInteractionEnabled=YES;
    }];
}

-(void)popView
{
    [UIView animateWithDuration:0.2 animations:^{
        view.frame = CGRectMake(0,self.frame.size.height,view.frame.size.width,view.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(IBAction)cancelClick:(id)sender
{
     [self popView];
}

-(IBAction)sureClick:(UIButton*)sender
{
    [delegate zpActionSheet:self :sender.tag];
    [self popView];
}

@end
