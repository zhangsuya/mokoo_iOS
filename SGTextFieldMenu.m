//
//  SGTextFieldMenu.m
//  mokoo
//
//  Created by Mac on 15/8/28.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "SGTextFieldMenu.h"
#import "CustomTextField.h"
#import "MokooMacro.h"
#import "HomeChooseTextField.h"
#import "UIButton+EnlargeTouchArea.h"
@interface SGTextFieldMenu()
@property (nonatomic,strong) UIButton *titleLabel;
@property (nonatomic,strong) UILabel *sexLabel;
@property (nonatomic,strong) HomeChooseTextField *sexTextField;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) HomeChooseTextField *priceTextField;
@property (nonatomic,strong) UILabel *location;
@property (nonatomic,strong) HomeChooseTextField *locationTextField;
@property (nonatomic,strong) UILabel *heightLabel;
@property (nonatomic,strong) HomeChooseTextField *heightTextField;
//@property (nonatomic,strong) UILabel *fanNumLabel;
//@property (nonatomic,strong) HomeChooseTextField *fanNumTextField;
@property (nonatomic,strong) UILabel *isCompanyLabel;
@property (nonatomic, strong) void (^actionHandle)(NSDictionary *);
@property (nonatomic,strong) UIButton *isCompanyBtn;
@property (nonatomic,strong) UIButton *submiteBtn;
@property (nonatomic,strong) UIButton *selectBtn;
@property (nonatomic,strong) NSDictionary *selectedDict;
@end

@implementation SGTextFieldMenu

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initTextFieldViewWithDict:(NSDictionary *)dict{
    self = [self initWithFrame:[[UIScreen mainScreen] bounds]];
    _titleLabel = [[UIButton alloc] initWithFrame:CGRectZero];
    [_titleLabel setImage:[UIImage imageNamed:@"close.pdf"] forState:UIControlStateNormal];
    [_titleLabel setEnlargeEdgeWithTop:10 right:10 bottom:20 left:20];
    _sexLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _sexLabel.textAlignment = NSTextAlignmentRight;
    [_sexLabel setFont:[UIFont systemFontOfSize:15]];
    _sexLabel.text = @"性别";
    _sexTextField = [[HomeChooseTextField alloc]initWithFrame:CGRectZero];
//    [_sexTextField setBackground:[UIImage imageNamed:@"refine_box_g_l.pdf"]];
    _sexTextField.borderStyle = UITextBorderStyleNone;
    [_sexTextField setTextAlignment:NSTextAlignmentCenter];
    _sexTextField.placeholder = @"女";
    _sexTextField.isPickView = YES;
    _sexTextField.isScreen = YES;
    [_sexTextField setSexField:YES];
    [_sexTextField setFont:[UIFont systemFontOfSize:15]];

    
    _priceLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    [_priceLabel setFont:[UIFont systemFontOfSize:15]];

    _priceLabel.text = @"价格";
    _priceTextField = [[HomeChooseTextField alloc]initWithFrame:CGRectZero];
    [_priceTextField setTextAlignment:NSTextAlignmentCenter];
    _priceTextField.placeholder = @"1500-2000元/时";
//    [_priceTextField setBackground:[UIImage imageNamed:@"refine_box_g_l.pdf"]];
    [_priceTextField setFont:[UIFont systemFontOfSize:15]];
    _priceTextField.isPickView = YES;
    _priceTextField.isScreen = YES;
    [_priceTextField setPriceField:YES];

    
    _location = [[UILabel alloc]initWithFrame:CGRectZero];
    _location.textAlignment = NSTextAlignmentRight;
    _location.text = @"所在地";
    [_location setFont:[UIFont systemFontOfSize:15]];

    _locationTextField = [[HomeChooseTextField alloc]initWithFrame:CGRectZero];
    [_locationTextField setTextAlignment:NSTextAlignmentCenter];
    _locationTextField.placeholder = @"不限";
//    [_locationTextField setBackground:[UIImage imageNamed:@"refine_box_g_l.pdf"]];
    [_locationTextField setFont:[UIFont systemFontOfSize:15]];
    _locationTextField.isPickView = YES;
    _locationTextField.isScreen = YES;
    [_locationTextField setLocationField:YES];

    _heightLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _heightLabel.textAlignment = NSTextAlignmentRight;
    _heightLabel.text = @"身高段";
    [_heightLabel setFont:[UIFont systemFontOfSize:15]];
    

    _heightTextField = [[HomeChooseTextField alloc]initWithFrame:CGRectZero];
    [_heightTextField setTextAlignment:NSTextAlignmentCenter];
    _heightTextField.placeholder = @"不限";
//    [_heightTextField setBackground:[UIImage imageNamed:@"refine_box_g_l.pdf"]];
    [_heightTextField setFont:[UIFont systemFontOfSize:15]];
    _heightTextField.isPickView = YES;
    _heightTextField.isScreen = YES;
    [_heightTextField setHeightField:YES];
    
//    _fanNumLabel = [[UILabel alloc]initWithFrame:CGRectZero];
//    _fanNumLabel.textAlignment = NSTextAlignmentRight;
//    _fanNumLabel.text = @"粉丝数";
//    [_fanNumLabel setFont:[UIFont systemFontOfSize:15]];
//
//    _fanNumTextField =[[HomeChooseTextField alloc]initWithFrame:CGRectZero];
//    [_fanNumTextField setTextAlignment:NSTextAlignmentCenter];
//    _fanNumTextField.placeholder = @"不限";
//    [_fanNumTextField setBackground:[UIImage imageNamed:@"refine_box_g_l.pdf"]];
//    [_fanNumTextField setFont:[UIFont systemFontOfSize:15]];

    _isCompanyLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _isCompanyLabel.textAlignment = NSTextAlignmentRight;
    _isCompanyLabel.text = @"有经纪人/公司";
    [_isCompanyLabel setFont:[UIFont systemFontOfSize:15]];
    
    _isCompanyBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    [_isCompanyBtn setImage:[UIImage imageNamed:@"refine_circle_off.pdf"] forState:UIControlStateNormal];
    _submiteBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    [_submiteBtn setImage:[UIImage imageNamed:@"refine_right.pdf"] forState:UIControlStateNormal];
    [_submiteBtn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_titleLabel];
    [self addSubview:_sexLabel];
    [self addSubview:_sexTextField];
    [self addSubview:_priceTextField];
    [self addSubview:_priceLabel];
    [self addSubview:_locationTextField];
    [self addSubview:_location];
    [self addSubview:_heightLabel];
    [self addSubview:_heightTextField];
//    [self addSubview:_fanNumTextField];
//    [self addSubview:_fanNumLabel];
    [self addSubview:_isCompanyLabel];
    [self addSubview:_isCompanyBtn];
    [self addSubview:_submiteBtn];
    NSArray *sexArray = @[@"不限",@"男",@"女"];
    NSArray *priceArray = @[@"不限",@"500/小时",@"800/小时",@"1000/小时",@"1200/小时",@"1500/小时及以上",@"其他"];
    NSArray *heightArray = @[@"不限",@"155cm以上",@"160cm以上",@"165cm以上",@"168cm以上",@"170cm以上",@"175cm以上",@"180cm以上",@"185cm以上"];
    NSArray *locationArray =  @[@"不限",@"北京",@"上海",@"广州",@"成都",@"重庆",@"西安"];
    if (dict) {
        _sexTextField.selectedItem = [[dict objectForKey:@"sex"] integerValue] ;
        _priceTextField.selectedItem = [[dict objectForKey:@"price"] integerValue] ;
        _locationTextField.selectedItem = [[dict objectForKey:@"city"] integerValue] ;
        _heightTextField.selectedItem = [[dict objectForKey:@"height"] integerValue];
        _sexTextField.text = sexArray[[[dict objectForKey:@"sex"] integerValue]];
        _priceTextField.text = priceArray[[[dict objectForKey:@"price"] integerValue]];
        _locationTextField.text = locationArray[[[dict objectForKey:@"city"] integerValue]];
        _heightTextField.text = heightArray[[[dict objectForKey:@"height"] integerValue]];
        if ([[dict objectForKey:@"is_company"] isEqualToString:@"1"]) {
            _selectBtn = _isCompanyBtn;
            
            
            
            _selectBtn.selected = YES;
            [_selectBtn setImage:[UIImage imageNamed:@"refine_circle_on.pdf"] forState:UIControlStateNormal];
        }
        _selectedDict =dict;
    }
    
    return self;
}

- (void)setStyle:(SGActionViewStyle)style{
    _style = style;
    
    self.backgroundColor = BaseMenuBackgroundColor(style);
    //    self.titleLabel.textColor = BaseMenuTextColor(style);
    //    [self.cancelButton setTitleColor:BaseMenuActionTextColor(style) forState:UIControlStateNormal];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = (CGRect){CGPointMake(self.bounds.size.width - 13 -14, 14), CGSizeMake(13 , 13)};
    
    self.sexLabel.frame = (CGRect){CGPointMake(0, 65), 79,30};
    self.priceLabel.frame = (CGRect){CGPointMake(0, 105), 79,30};
    self.location.frame = (CGRect){CGPointMake(0, 145), 79,30};
    self.heightLabel.frame = (CGRect){CGPointMake(0, 185), 79,30};
//    self.fanNumLabel.frame = (CGRect){CGPointMake(0, 225), 79,30};
    self.isCompanyLabel.frame = (CGRect){CGPointMake(0, 225), 130,30};
    
    self.sexTextField.frame = (CGRect){CGPointMake(93, 65), kDeviceWidth - 176,30};
    self.priceTextField.frame = (CGRect){CGPointMake(93, 105), kDeviceWidth - 176,30};
    self.locationTextField.frame = (CGRect){CGPointMake(93, 145), kDeviceWidth - 176,30};
    self.heightTextField.frame = (CGRect){CGPointMake(93, 185), kDeviceWidth - 176,30};
//    self.fanNumTextField.frame = (CGRect){CGPointMake(93, 225), kDeviceWidth - 176,30};
    self.isCompanyBtn.frame = (CGRect){CGPointMake(93 +(kDeviceWidth - 176)/2 -9, 232), 18,18};
    self.submiteBtn.frame = (CGRect){CGPointMake((kDeviceWidth - 32)/2 -14.5, 322), 45,45};
    [self.titleLabel addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.isCompanyBtn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.isCompanyBtn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    //    self.cancelButton.frame = CGRectMake(self.bounds.size.width*0.05, 65 + self.contentScrollView.bounds.size.height, self.bounds.size.width*0.9, 44);
    
    //    self.bounds = (CGRect){CGPointMake(16, 0), CGSizeMake(self.bounds.size.width -16 , 65 + self.contentScrollView.bounds.size.height + self.cancelButton.bounds.size.height)};
    self.bounds = (CGRect){CGPointMake(16, 0), CGSizeMake(self.bounds.size.width -16 , kDeviceHeight -173 )};
    
}

#pragma mark -

- (void)triggerSelectedAction:(void (^)(NSDictionary *))actionHandle
{
    self.actionHandle = actionHandle;
}
#pragma mark -

- (void)tapAction:(id)sender
{
    if (self.actionHandle) {
        if ([sender isEqual:self.titleLabel]) {
            double delayInSeconds = 0.15;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                if (_selectedDict) {
                    self.actionHandle(_selectedDict);

                }else
                {
                    self.actionHandle(0);
                }
            });
        }else if([sender isEqual:self.isCompanyBtn]){
            [self selectButton:(UIButton *)sender];
        }else if([sender isEqual:self.submiteBtn]){
            _selectedDict = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%@",@(_sexTextField.selectedItem)],@"sex",[NSString stringWithFormat:@"%@",@(_priceTextField.selectedItem)],@"price",[NSString stringWithFormat:@"%@",@(_locationTextField.selectedItem)],@"city",[NSString stringWithFormat:@"%@",@(_heightTextField.selectedItem)],@"height",_isCompanyBtn.selected? @"1":@"0",@"is_company",nil];
            double delayInSeconds = 0.15;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                self.actionHandle(_selectedDict);
            });
        }
    }
}
- (void)selectButton:(UIButton *)button
{
    if (_selectBtn.selected) {
        _selectBtn.selected = NO;
        [_selectBtn setImage:[UIImage imageNamed:@"refine_circle_off.pdf"] forState:UIControlStateNormal];
        
    }else
    {
        _selectBtn = button;
        _selectBtn.selected = YES;
        [_selectBtn setImage:[UIImage imageNamed:@"refine_circle_on.pdf"] forState:UIControlStateNormal];
    }
    

    //    _selectBtn.titleLabel.font = _selectedTextFont;
}
@end
