//
//  PlaceholderTextView.m
//  SaleHelper
//
//  Created by gitBurning on 14/12/8.
//  Copyright (c) 2014年 Burning_git. All rights reserved.
//

#import "PlaceholderTextView.h"
#import "MokooMacro.h"
@interface PlaceholderTextView()<UITextViewDelegate>
{
    UILabel *PlaceholderLabel;
}

@end
@implementation PlaceholderTextView

- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self awakeFromNib];
    }
    return self;
}


- (void)awakeFromNib {
   
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidChange:) name:UITextViewTextDidChangeNotification object:self];

    float left=4,top=5;
//    CGSize textSize = [_placeholder boundingRectWithSize:CGSizeMake(kDeviceWidth -32 -4-4, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    self.placeholderColor = [UIColor lightGrayColor];
    PlaceholderLabel=[[UILabel alloc] initWithFrame:CGRectMake(left, top , CGRectGetWidth(self.frame)-2*left + 4, 20)];
//    PlaceholderLabel.font=self.placeholderFont?self.placeholderFont:self.font;
    PlaceholderLabel.font   = [UIFont systemFontOfSize:15.0];
//    PlaceholderLabel.textColor  = placehoderFontColor;
    PlaceholderLabel.textColor=self.placeholderColor?self.placeholderColor:placehoderFontColor;
    [self addSubview:PlaceholderLabel];
    PlaceholderLabel.lineBreakMode = NSLineBreakByCharWrapping;
    PlaceholderLabel.text=self.placeholder;
    PlaceholderLabel.numberOfLines  = 0;
    


}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void)setPlaceholder:(NSString *)placeholder{
    
    
    if (placeholder.length == 0 || [placeholder isEqualToString:@""]) {
        PlaceholderLabel.hidden=YES;
    }
    else
        PlaceholderLabel.text=placeholder;
    _placeholder=placeholder;

    
}

-(void)DidChange:(NSNotification*)noti{
    
    if (self.placeholder.length == 0 || [self.placeholder isEqualToString:@""]) {
        PlaceholderLabel.hidden=YES;
    }
    
    if (self.text.length > 0) {
        PlaceholderLabel.hidden=YES;
    }
    else{
        PlaceholderLabel.hidden=NO;
    }
    
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [PlaceholderLabel removeFromSuperview];
    
//    [super dealloc];

}

- (void)removeText {
    self.text = nil;
    PlaceholderLabel.hidden = NO;
}

@end


