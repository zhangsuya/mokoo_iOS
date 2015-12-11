//
//  ImageViewCell.m
//  WaterFlowViewDemo
//
//  Created by Smallsmall on 12-6-12.
//  Copyright (c) 2012年 activation group. All rights reserved.
//

#import "ImageViewCell.h"
#import "UIImageView+WebCache.h"
#import "MokooMacro.h"
#define TOPMARGIN 5.0f
#define LEFTMARGIN 5.0f

#define IMAGEVIEWBG [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0]

@implementation ImageViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithIdentifier:(NSString *)indentifier
{
	if(self = [super initWithIdentifier:indentifier])
	{
        imageView = [[UIImageView alloc] init];
//        imageView.backgroundColor = IMAGEVIEWBG;
        imageView.backgroundColor = viewBgColor;
        [self addSubview:imageView];
        [imageView release];
        //去掉边框
//        imageView.layer.borderWidth = 1;
//        imageView.layer.borderColor = [[UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0] CGColor];
	}
	
	return self;
}

-(void)setImageWithURL:(NSURL *)imageUrl{

//    [imageView sd_setImageWithURL:imageUrl];
    [imageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"pic_loading.pdf"]];
}

-(void)setImage:(UIImage *)image{

    imageView.image = image;
}

//保持图片上下左右有固定间距
-(void)relayoutViews{

    float originX = 0.0f;
    float originY = 0.0f;
    float width = 0.0f;
    float height = 0.0f;
    
    originY = TOPMARGIN;
    height = CGRectGetHeight(self.frame) - TOPMARGIN;
    if (self.indexPath.column == 0) {
        
        originX = LEFTMARGIN;
        width = CGRectGetWidth(self.frame) - LEFTMARGIN - 1/2.0*LEFTMARGIN;
    }else if (self.indexPath.column < self.columnCount - 1){
    
        originX = LEFTMARGIN/2.0;
        width = CGRectGetWidth(self.frame) - LEFTMARGIN;
    }else{
    
        originX = LEFTMARGIN/2.0;
        width = CGRectGetWidth(self.frame) - LEFTMARGIN - 1/2.0*LEFTMARGIN;
    }
    imageView.frame = CGRectMake( originX, originY,width, height);
    
    [super relayoutViews];

}

@end
