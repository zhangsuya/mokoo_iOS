//
//  EditPersonCenterViewController.m
//  mokoo
//
//  Created by Mac on 15/9/17.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "EditPersonCenterViewController.h"
#import "MokooMacro.h"
#import "DemoTextField.h"
#import "PersonalTextField.h"
#import "RequestCustom.h"
#import "ModelInfosModel.h"
#import "ModelTypeModel.h"
#import "ExperienceTableViewCell.h"
#import "HJCActionSheet.h"
#import "AddExperienceViewController.h"
#import "UIView+SDExtension.h"
#import "MBProgressHUD.h"
#import "PersonalCenterViewController.h"
#import "notiNilView.h"
@interface EditPersonCenterViewController ()<UITableViewDataSource,UITableViewDelegate,HJCActionSheetDelegate,AddExperienceViewControllerDelegate,UITextFieldDelegate>
{
    notiNilView  *_loadFailView;
    UITextField *nickNameTF;
    
    UITextField *moodTF;
    
    PersonalTextField *heightTF;
    
    PersonalTextField *weightTF;
    
    PersonalTextField *BWHTF;
    
    PersonalTextField *shoesSizeTF;
    
    PersonalTextField *goodAtStyleTF;
    
    PersonalTextField *occupationalTypesTextField;
    
    PersonalTextField *countryTextField;
    
    PersonalTextField *destinationTextField;
    
    PersonalTextField *hairTextField;
    
    PersonalTextField *skinColorTextField;
    
    PersonalTextField *eyeField;
    
    PersonalTextField *shoulderField;
    
    PersonalTextField *legField;
    
    PersonalTextField *languageField;
    
    PersonalTextField *priceField;
    
    PersonalTextField *companyField;
    
    PersonalTextField *tmpTF;
    NSArray *typeArray;
    CGSize keyboardSize;
    NSMutableArray *existedHeight;
    UIView *contentSView;
}

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIButton *leftBtn;
@property (nonatomic,weak)UILabel *titleView;
@property (nonatomic,strong)ModelInfosModel *model;
@property (nonatomic,strong)NSMutableArray *experienceArray;
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation EditPersonCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    existedHeight = [NSMutableArray array];
    _experienceArray = [NSMutableArray array];
    [self.tableView registerNib:[UINib nibWithNibName:@"ExperienceTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyBoardHidden)];
    [self.view addGestureRecognizer:tap];
    [self initTypeArray];
    [self setUpNavigationItem];
    [self requestInfo];
    // Do any additional setup after loading the view.
}
-(void)dealloc
{
    nickNameTF.delegate = nil;
    moodTF.delegate = nil;
    heightTF.delegate = nil;
    weightTF.delegate = nil;
    BWHTF.delegate = nil;
    shoesSizeTF.delegate = nil;
    goodAtStyleTF.delegate = nil;
    occupationalTypesTextField.delegate = nil;
    countryTextField.delegate = nil;
    destinationTextField.delegate = nil;
    hairTextField.delegate = nil;
    skinColorTextField.delegate = nil;
    eyeField.delegate = nil;
    shoulderField.delegate = nil;
    legField.delegate = nil;
    languageField.delegate = nil;
    priceField.delegate = nil;
    companyField.delegate = nil;

}

-(void)initFailLoadView
{
    _loadFailView    = [[notiNilView alloc] init];
    _loadFailView    = [_loadFailView initLoadFailView];
    [self.view addSubview:_loadFailView];
    [_loadFailView.addSomethingBtn addTarget:self action:@selector(reloadTableViewData) forControlEvents:UIControlEventTouchUpInside];
    //    _loadFailView.hidden = YES;
}
-(void)keyBoardHidden
{
    [nickNameTF resignFirstResponder];
    
    [moodTF resignFirstResponder];
    
    [heightTF resignFirstResponder];
    
    [weightTF resignFirstResponder];
    
    [BWHTF resignFirstResponder];
    
    [shoesSizeTF resignFirstResponder];
    
    [goodAtStyleTF resignFirstResponder];
    
    [occupationalTypesTextField resignFirstResponder];
    
    [countryTextField resignFirstResponder];
    
    [destinationTextField resignFirstResponder];
    
    [hairTextField resignFirstResponder];
    
    [skinColorTextField resignFirstResponder];
    
    [eyeField resignFirstResponder];
    
    [shoulderField resignFirstResponder];
    
    [legField resignFirstResponder];
    
    [languageField resignFirstResponder];
    
    [priceField resignFirstResponder];
    
    [companyField resignFirstResponder];
//    [self.view.subviews makeObjectsPerformSelector:@selector(resignFirstResponder)];
    
}
-(void)initTypeArray
{
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    NSURL *url = [bundle URLForResource:@"SuYa" withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    NSString *path = [imageBundle pathForResource:@"Experience" ofType:@"plist"];
    NSDictionary *typeDict = [NSDictionary dictionaryWithContentsOfFile:path];
    //        NSArray *typeArray  = [NSArray arrayWithContentsOfFile:path];
    typeArray = [typeDict objectForKey:@"Type"];
}
-(void)setUpView
{
    
    CGFloat height = 10;
//    for (UIViewController *controller in self.navigationController.viewControllers ) {
//        if ([controller isKindOfClass:[PersonalCenterViewController class]]) {
//            _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight )];
//        }
//    }
//    if (_scrollView ) {
//        
//    }else
//    {
//        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kDeviceWidth, kDeviceHeight -64)];
//    }
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kDeviceWidth, kDeviceHeight-64)];
    _scrollView.scrollEnabled = YES;
    contentSView = [[UIView alloc] init];
    [_scrollView addSubview:contentSView];
    UIImageView *oneView = [[UIImageView alloc]initWithFrame:CGRectMake(16, 10, kDeviceWidth - 32, 42)];
    oneView.userInteractionEnabled = YES;
    height = height +48;
    oneView.image = [UIImage imageNamed:@""];
    UIImageView *twoView = [[UIImageView alloc]initWithFrame:CGRectMake(16, height, kDeviceWidth - 32, 42)];
    twoView.userInteractionEnabled = YES;
    twoView.image = [UIImage imageNamed:@""];
    height = height +48;

    UIImageView *threeView = [[UIImageView alloc]initWithFrame:CGRectMake(16, height, (kDeviceWidth - 32 -6)/2, 42)];
    threeView.userInteractionEnabled = YES;
    threeView.image = [UIImage imageNamed:@""];
    UIImageView *threeViews = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth/2 +3, height, (kDeviceWidth - 32 -6)/2, 42)];
    threeViews.userInteractionEnabled = YES;
    threeViews.image = [UIImage imageNamed:@""];
    height = height +48;

    UIImageView *fourView = [[UIImageView alloc]initWithFrame:CGRectMake(16, height, (kDeviceWidth - 32 -6)/2, 42)];
    fourView.userInteractionEnabled = YES;
    fourView.image = [UIImage imageNamed:@""];
    UIImageView *fourViews = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth/2 +3, height, (kDeviceWidth - 32 -6)/2, 42)];
    fourViews.userInteractionEnabled = YES;
    fourViews.image = [UIImage imageNamed:@""];
    height = height +48;

    UIImageView *fiveView = [[UIImageView alloc]initWithFrame:CGRectMake(16, height, kDeviceWidth - 32, 42)];
    fiveView.userInteractionEnabled = YES;
    fiveView.image = [UIImage imageNamed:@""];
    height = height +48;

    UIImageView *sixView = [[UIImageView alloc]initWithFrame:CGRectMake(16, height, kDeviceWidth - 32, 42)];
    sixView.image = [UIImage imageNamed:@""];
    sixView.userInteractionEnabled = YES;
    height = height +48;

    UIImageView *sevenView = [[UIImageView alloc]initWithFrame:CGRectMake(16, height, kDeviceWidth - 32, 42)];
    sevenView.userInteractionEnabled = YES;
    sevenView.image = [UIImage imageNamed:@""];
    height = height +48;

    UIImageView *eightView = [[UIImageView alloc]initWithFrame:CGRectMake(16, height, kDeviceWidth - 32, 42)];
    eightView.userInteractionEnabled = YES;
    eightView.image = [UIImage imageNamed:@""];
    height = height +48;

    UIImageView *nineView = [[UIImageView alloc]initWithFrame:CGRectMake(16, height, kDeviceWidth - 32, 42)];
    nineView.userInteractionEnabled = YES;
    nineView.image = [UIImage imageNamed:@""];
    height = height +48;

    UIImageView *tenView = [[UIImageView alloc]initWithFrame:CGRectMake(16, height, kDeviceWidth - 32, 42)];
    tenView.userInteractionEnabled = YES;
    tenView.image = [UIImage imageNamed:@""];
    height = height +48;

    UIImageView *onesView = [[UIImageView alloc]initWithFrame:CGRectMake(16, height, kDeviceWidth - 32, 42)];
    onesView.userInteractionEnabled = YES;
    onesView.image = [UIImage imageNamed:@""];
    height = height +48;

    UIImageView *twosView = [[UIImageView alloc]initWithFrame:CGRectMake(16, height, kDeviceWidth - 32, 42)];
    twosView.userInteractionEnabled = YES;
    twosView.image = [UIImage imageNamed:@""];
    height = height +48;

    UIImageView *threesView = [[UIImageView alloc]initWithFrame:CGRectMake(16, height, kDeviceWidth - 32, 42)];
    threesView.userInteractionEnabled = YES;
    threesView.image = [UIImage imageNamed:@""];
    height = height +48;

    UIImageView *foursView = [[UIImageView alloc]initWithFrame:CGRectMake(16, height, kDeviceWidth - 32, 42)];
    foursView.userInteractionEnabled = YES;
    foursView.image = [UIImage imageNamed:@""];
    height = height +48;

    UIImageView *fivesView = [[UIImageView alloc]initWithFrame:CGRectMake(16, height, kDeviceWidth - 32, 42)];
    fivesView.userInteractionEnabled = YES;
    fivesView.image = [UIImage imageNamed:@""];
    height = height +48;

    UIImageView *sixsView = [[UIImageView alloc]initWithFrame:CGRectMake(16, height, kDeviceWidth - 32, 42)];
    sixsView.userInteractionEnabled = YES;
    sixsView.image = [UIImage imageNamed:@""];
    height = height +48;
    if ([_experienceArray count] >0) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(16, height, kDeviceWidth - 32, 90 *[_experienceArray count] +15) style:UITableViewStylePlain];
//        [self.tableView registerNib:[UINib nibWithNibName:@"ExperienceTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//        self.tableView.scrollEnabled = NO;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
//        self.tableView.
        [self.tableView reloadData];
        height = height +90*[_experienceArray count] +52 ;

        [_scrollView addSubview:self.tableView];
    }else
    {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(16, height, kDeviceWidth - 32, 0) style:UITableViewStylePlain];
//        self.tableView.frame = CGRectZero;
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.tableView.scrollEnabled = NO;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        //        self.tableView.
//        [self.tableView reloadData];
        [_scrollView addSubview:self.tableView];

        height = height + 30;
    }
    UIButton *addTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addTypeBtn.tag = 102;
    addTypeBtn.frame = CGRectMake(0, height,161, 42);
    [addTypeBtn.titleLabel setTextColor:blackFontColor];
    [addTypeBtn setTitle:@"＋添加类别" forState:UIControlStateNormal];
    [addTypeBtn setTitleColor:blackFontColor forState:UIControlStateNormal];
    [addTypeBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [addTypeBtn.titleLabel setText:@"＋添加类别"];
//    addTypeBtn.backgroundColor = [UIColor whiteColor];
    addTypeBtn.layer.masksToBounds = YES;
    addTypeBtn.layer.borderColor = blackFontColor.CGColor;
    addTypeBtn.layer.borderWidth = 0.5;
    addTypeBtn.center = CGPointMake(kDeviceWidth/2, height);
    addTypeBtn.layer.cornerRadius = 3;
    [addTypeBtn addTarget:self action:@selector(addTypeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    height = height +42;
    [_scrollView addSubview:addTypeBtn];
    
    UIButton *submitTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitTypeBtn.tag = 103;
    submitTypeBtn.frame = CGRectMake(0, height, kDeviceWidth -32, 42);
    submitTypeBtn.center = CGPointMake(kDeviceWidth/2, height +21);
    [submitTypeBtn setBackgroundColor:[UIColor blackColor]];
    [submitTypeBtn setImage:[UIImage imageNamed:@"button_right_1.pdf"] forState:UIControlStateNormal];
    submitTypeBtn.layer.masksToBounds = YES;
    submitTypeBtn.layer.cornerRadius = 3;
    [submitTypeBtn addTarget:self action:@selector(submitTypeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    height = height +42 +21;
    [_scrollView addSubview:submitTypeBtn];
//    UIImageView *sevensView = [[UIImageView alloc]initWithFrame:CGRectMake(16, height, kDeviceWidth - 32, 42)];
//    sevensView.userInteractionEnabled = YES;
//    sevensView.image = [UIImage imageNamed:@""];
//    height = height +52;
//
//    UIImageView *eightsView = [[UIImageView alloc]initWithFrame:CGRectMake(16, height, kDeviceWidth - 32, 42)];
//    eightsView.image = [UIImage imageNamed:@""];
//    eightsView.userInteractionEnabled = YES;
//    height = height +52;
//
//    UIImageView *ninesView = [[UIImageView alloc]initWithFrame:CGRectMake(16, height, kDeviceWidth - 32, 42)];
//    ninesView.userInteractionEnabled = YES;
//    ninesView.image = [UIImage imageNamed:@""];
//    height = height +52;

//    legField = [[PersonalTextField alloc]initWithFrame:CGRectMake(16, height, kDeviceWidth - 32, 42)];
    
//    UIImageView *tensView = [[UIImageView alloc]initWithFrame:CGRectMake(16, height, kDeviceWidth - 32, 42)];
//    tensView.image = [UIImage imageNamed:@""];
//    height = height +52;
    _scrollView.contentSize = CGSizeMake(kDeviceWidth, height);
    contentSView.frame = CGRectMake(0, 0, kDeviceWidth, height);
    [contentSView addSubview:oneView];
    [contentSView addSubview:twoView];
    [contentSView addSubview:threeView];
    [contentSView addSubview:threeViews];
    [contentSView addSubview:fourView];
    [contentSView addSubview:fourViews];
    [contentSView addSubview:fiveView];
    [contentSView addSubview:sixView];
    [contentSView addSubview:sevenView];
    [contentSView addSubview:eightView];
    [contentSView addSubview:nineView];
    [contentSView addSubview:tenView];
    [contentSView addSubview:onesView];
    [contentSView addSubview:twosView];
    [contentSView addSubview:threesView];
    [contentSView addSubview:foursView];
    [contentSView addSubview:fivesView];
    [contentSView addSubview:sixsView];
    for (UIView *view in contentSView.subviews ) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [self initImageBoarderWithView:view];
        }
    }


    nickNameTF = [[UITextField alloc]initWithFrame:CGRectMake(16, 1, kDeviceWidth -32, 42)];
    [nickNameTF setText:_model.nick_name];
//    [nickNameTF setRequired:YES];
//    [oneView addSubview:vLabel];
    [oneView addSubview:nickNameTF];
    
    
    moodTF = [[UITextField alloc]initWithFrame:CGRectMake(16, 1, kDeviceWidth - 32, 42)];
    if (_model.sign.length ==0) {
//        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"user_type"] isEqualToString:@"2"]) {
////
//            moodTF.placeholder = @"TA比较懒,什么也没写...";
//        }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"user_type"] isEqualToString:@"2"])
        moodTF.placeholder = @"写一句话描述自己...";
    }else
    {
        [moodTF setText:_model.sign];
    }
//    [moodTF setRequired:YES];
//    [_scrollView addSubview:moodTF];
    [twoView addSubview:moodTF];
    
    UILabel *threeLabel = (UILabel *)[[self class] initLabelWithTitle:@"身高"];
    heightTF = [[PersonalTextField alloc]initWithFrame:CGRectMake(threeLabel.frame.size.width +16, 1, kDeviceWidth/2 -threeLabel.frame.size.width -34, 40)];
    [heightTF setTextAlignment:NSTextAlignmentRight];
    UILabel *rightView = [[UILabel alloc]init];
    rightView.frame = CGRectMake(0, -1, 25, 40);
    rightView.text = @"cm";
    [rightView setFont:[UIFont systemFontOfSize:14]];
    heightTF.rightView =rightView;
    heightTF.rightViewMode =UITextFieldViewModeAlways;
    [heightTF setText:[NSString stringWithFormat:@"%@",_model.height]];
    [heightTF setFont:[UIFont systemFontOfSize:14]];
    [heightTF setTextColor:placehoderFontColor];
    heightTF.keyboardType = UIKeyboardTypeNumberPad;
    UILabel *weightLab = [[UILabel alloc]init];
    [weightLab setText:@"体重"];
    [weightLab setFont:[UIFont systemFontOfSize:15]];
    [weightLab setTextColor:blackFontColor];
    CGSize textSize = [@"体重" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    weightLab.frame = CGRectMake(16, 0, textSize.width, 42);
    weightTF = [[PersonalTextField alloc]initWithFrame:CGRectMake(weightLab.frame.size.width +16 , 1, kDeviceWidth/2-weightLab.frame.size.width - 16-3-16, 40)];
    [weightTF setText:[NSString stringWithFormat:@"%@",_model.weight]];
    [weightTF setTextAlignment:NSTextAlignmentRight];
    [weightTF setFont:[UIFont systemFontOfSize:14]];
    [weightTF setTextColor:placehoderFontColor];
    weightTF.keyboardType = UIKeyboardTypeNumberPad;

    UILabel *rightViewTwo = [[UILabel alloc]init];
    rightViewTwo.frame = CGRectMake(0, -1, 25, 40);
    rightViewTwo.text = @"kg";
    [rightViewTwo setFont:[UIFont systemFontOfSize:14]];
    weightTF.rightView = rightViewTwo;
    weightTF.rightViewMode = UITextFieldViewModeAlways;
    [threeView addSubview:threeLabel];
    [threeView addSubview:heightTF];
    [threeViews addSubview:weightLab];
    [threeViews addSubview:weightTF];

    UILabel *BWHLabel = (UILabel *)[[self class] initLabelWithTitle:@"三围"];
    BWHTF = [[PersonalTextField alloc]initWithFrame:CGRectMake(BWHLabel.frame.size.width +16, 1, kDeviceWidth/2 -BWHLabel.frame.size.width -34 -3, 40)];
    [BWHTF setText:_model.three_size];
    [BWHTF setTextAlignment:NSTextAlignmentRight];
    [BWHTF setFont:[UIFont systemFontOfSize:14]];
    [BWHTF setTextColor:placehoderFontColor];
    BWHTF.isMulChooseView = YES;
    BWHTF.isThreeTextField = YES;
    UILabel *shoesSizeLab = [[UILabel alloc]init];
    [shoesSizeLab setText:@"鞋码"];
    [shoesSizeLab setFont:[UIFont systemFontOfSize:15]];
    [shoesSizeLab setTextColor:blackFontColor];
    CGSize shoesSizeLabSize = [@"鞋码" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    shoesSizeLab.frame = CGRectMake( 16, 0, shoesSizeLabSize.width, 42);
    shoesSizeTF = [[PersonalTextField alloc]initWithFrame:CGRectMake(shoesSizeLab.frame.size.width +16 , 1, kDeviceWidth/2-shoesSizeLab.frame.size.width  -32-3 -10, 40)];
    shoesSizeTF.text = _model.shoe_size;
    [shoesSizeTF setTextAlignment:NSTextAlignmentRight];
    [shoesSizeTF setFont:[UIFont systemFontOfSize:14]];
    [shoesSizeTF setTextColor:placehoderFontColor];
    shoesSizeTF.keyboardType = UIKeyboardTypeNumberPad;
    [fourView addSubview:BWHLabel];
    [fourView addSubview:BWHTF];
    [fourViews addSubview:shoesSizeLab];
    [fourViews addSubview:shoesSizeTF];
    
    UILabel *goodAtStyleLabel = (UILabel *)[[self class] initLabelWithTitle:@"擅长风格"];
    goodAtStyleTF = [[PersonalTextField alloc]initWithFrame:CGRectMake(goodAtStyleLabel.frame.size.width + 16, 1, kDeviceWidth - 32 -goodAtStyleLabel.frame.size.width -28 , 40)];
    [goodAtStyleTF setText:_model.style_name];
    [goodAtStyleTF setTextAlignment:NSTextAlignmentRight];
    [goodAtStyleTF setFont:[UIFont systemFontOfSize:14]];
    [goodAtStyleTF setTextColor:placehoderFontColor];
    goodAtStyleTF.isMulChooseView = YES;
    goodAtStyleTF.isStyleField = YES;
    goodAtStyleTF.mulSelectedItem = _model.style ;
    [fiveView addSubview:goodAtStyleLabel];
    [fiveView addSubview:goodAtStyleTF];
    
    UILabel *occupationalTypesLabel = (UILabel *)[[self class] initLabelWithTitle:@"职业类型"];
    occupationalTypesTextField = [[PersonalTextField alloc]initWithFrame:CGRectMake(occupationalTypesLabel.frame.size.width + 16, 1, kDeviceWidth - 32 -occupationalTypesLabel.frame.size.width-28 , 40)];
    [occupationalTypesTextField setText:_model.work_type_name];
    [occupationalTypesTextField setTextAlignment:NSTextAlignmentRight];
    [occupationalTypesTextField setFont:[UIFont systemFontOfSize:14]];
    [occupationalTypesTextField setTextColor:placehoderFontColor];
    occupationalTypesTextField.isMulChooseView = YES;
    [occupationalTypesTextField setTypeField:YES];
    occupationalTypesTextField.mulSelectedItem = _model.work_type;
    [sixView addSubview:occupationalTypesLabel];
    [sixView addSubview:occupationalTypesTextField];
    
    UILabel *countryLabel = (UILabel *)[[self class] initLabelWithTitle:@"国籍"];
    countryTextField = [[PersonalTextField alloc]initWithFrame:CGRectMake(countryLabel.frame.size.width + 16, 1, kDeviceWidth - 32 -countryLabel.frame.size.width-28 , 40)];
    [countryTextField setText:_model.country_name];
    [countryTextField setTextAlignment:NSTextAlignmentRight];
    [countryTextField setFont:[UIFont systemFontOfSize:14]];
    [countryTextField setTextColor:placehoderFontColor];
    countryTextField.isPickView = YES;
    [countryTextField setCountryField:YES];
    countryTextField.selectedItem = [_model.country integerValue];

    [sevenView addSubview:countryLabel];
    [sevenView addSubview:countryTextField];
    
    UILabel *destinationLabel = (UILabel *)[[self class] initLabelWithTitle:@"目前所在地"];
    destinationTextField = [[PersonalTextField alloc]initWithFrame:CGRectMake(destinationLabel.frame.size.width + 16, 1, kDeviceWidth - 32 -destinationLabel.frame.size.width-28 , 40)];
    [destinationTextField setText:_model.address_name];
    [destinationTextField setTextAlignment:NSTextAlignmentRight];
    [destinationTextField setFont:[UIFont systemFontOfSize:14]];
    [destinationTextField setTextColor:placehoderFontColor];
    destinationTextField.isPickView = YES;
    [destinationTextField setLocationField:YES];
    destinationTextField.selectedItem = [_model.address integerValue];
    [eightView addSubview:destinationLabel];
    [eightView addSubview:destinationTextField];
    
    UILabel *hairLabel = (UILabel *)[[self class] initLabelWithTitle:@"头发"];
    hairTextField = [[PersonalTextField alloc]initWithFrame:CGRectMake(hairLabel.frame.size.width + 16, 1, kDeviceWidth - 32 -hairLabel.frame.size.width-28 , 40)];
    [hairTextField setText:_model.hair_name];
    [hairTextField setTextAlignment:NSTextAlignmentRight];
    [hairTextField setFont:[UIFont systemFontOfSize:14]];
    [hairTextField setTextColor:placehoderFontColor];
    hairTextField.isPickView = YES;
    [hairTextField setHairField:YES];
    hairTextField.selectedItem = [_model.hair integerValue];
    [nineView addSubview:hairLabel];
    [nineView addSubview:hairTextField];
    
    UILabel *skinColorLabel = (UILabel *)[[self class] initLabelWithTitle:@"肤色"];
    skinColorTextField = [[PersonalTextField alloc]initWithFrame:CGRectMake(skinColorLabel.frame.size.width + 16, 1, kDeviceWidth - 32 -skinColorLabel.frame.size.width-28 , 40)];
    [skinColorTextField setText:_model.color_name];
    skinColorTextField.isPickView = YES;
    [skinColorTextField setSkinColorField:YES];
    [skinColorTextField setTextAlignment:NSTextAlignmentRight];
    [skinColorTextField setFont:[UIFont systemFontOfSize:14]];
    [skinColorTextField setTextColor: placehoderFontColor];
    skinColorTextField.isPickView = YES;
    [skinColorTextField setSkinColorField:YES];
    skinColorTextField.selectedItem = [_model.color integerValue];
    [tenView addSubview:skinColorLabel];
    [tenView addSubview:skinColorTextField];
    
    UILabel *eyeLabel = (UILabel *)[[self class] initLabelWithTitle:@"眼睛"];
    eyeField = [[PersonalTextField alloc]initWithFrame:CGRectMake(eyeLabel.frame.size.width + 16, 1, kDeviceWidth - 32 -eyeLabel.frame.size.width -28, 40)];
    [eyeField setText:_model.eye_name];
    [eyeField setTextAlignment:NSTextAlignmentRight];
    [eyeField setFont:[UIFont systemFontOfSize:14]];
    [eyeField setTextColor: placehoderFontColor];
    eyeField.isPickView = YES;
    [eyeField setEyeField:YES];
    eyeField.selectedItem = [_model.eye integerValue];
    [onesView addSubview:eyeLabel];
    [onesView addSubview:eyeField];
    
    UILabel *shoulderLabel = (UILabel *)[[self class] initLabelWithTitle:@"肩宽"];
    shoulderField = [[PersonalTextField alloc]initWithFrame:CGRectMake(shoulderLabel.frame.size.width + 16, 1, kDeviceWidth - 32 -shoulderLabel.frame.size.width-28 , 40)];
    [shoulderField setText:[NSString stringWithFormat:@"%@",_model.shoulder]];
    [shoulderField setTextAlignment:NSTextAlignmentRight];
    [shoulderField setFont:[UIFont systemFontOfSize:14]];
    [shoulderField setTextColor:placehoderFontColor];
    shoulderField.keyboardType = UIKeyboardTypeNumberPad;

    UILabel *rightViewThree = [[UILabel alloc]init];
    rightViewThree.frame = CGRectMake(0, 0, 25, 49);
    rightViewThree.text = @"cm";
    [rightViewThree setFont:[UIFont systemFontOfSize: 14]];
    [rightView setFont:[UIFont systemFontOfSize:14]];
    shoulderField.rightView = rightViewThree;
    shoulderField.rightViewMode = UITextFieldViewModeAlways;
    [twosView addSubview:shoulderLabel];
    [twosView addSubview:shoulderField];

    UILabel *legLabel = (UILabel *)[[self class] initLabelWithTitle:@"腿长"];
    legField = [[PersonalTextField alloc]initWithFrame:CGRectMake(legLabel.frame.size.width + 16, 1, kDeviceWidth - 32 -legLabel.frame.size.width-28 , 40)];
    [legField setText:[NSString stringWithFormat:@"%@",_model.legs]];
    [legField setTextAlignment:NSTextAlignmentRight];
    [legField setFont:[UIFont systemFontOfSize:14]];
    [legField setTextColor:placehoderFontColor];
    legField.keyboardType = UIKeyboardTypeNumberPad;

    UILabel *rightViewFour = [[UILabel alloc]init];
    rightViewFour.frame = CGRectMake(0, 0, 25, 49);
    [rightViewFour setFont:[UIFont systemFontOfSize:14]];
    rightViewFour.text = @"cm";
    legField.rightView = rightViewFour;
    legField.rightViewMode = UITextFieldViewModeAlways;
    legField.keyboardType = UIKeyboardTypeNumberPad;
    [threesView addSubview:legLabel];
    [threesView addSubview:legField];
    
    UILabel *languageLabel = (UILabel *)[[self class] initLabelWithTitle:@"语言"];
    languageField = [[PersonalTextField alloc]initWithFrame:CGRectMake(languageLabel.frame.size.width + 16, 1, kDeviceWidth - 32 -languageLabel.frame.size.width-28 , 40)];
    [languageField setText:_model.language_name];
    [languageField setTextAlignment:NSTextAlignmentRight];
    [languageField setFont:[UIFont systemFontOfSize:14]];
    [languageField setTextColor:placehoderFontColor];
    languageField.isPickView = YES;
    [languageField setLanguageField:YES];
    languageField.selectedItem = [_model.language integerValue];
    [foursView addSubview:languageLabel];
    [foursView addSubview:languageField];
    
    UILabel *priceLabel = (UILabel *)[[self class] initLabelWithTitle:@"价格"];
    priceField = [[PersonalTextField alloc]initWithFrame:CGRectMake(priceLabel.frame.size.width + 16, 1, kDeviceWidth - 32 -priceLabel.frame.size.width-28 , 40)];
    [priceField setText:_model.price_name];
    priceField.isPickView = YES;
    [priceField setPriceField:YES];
    priceField.selectedItem = [_model.price integerValue];
    [priceField setTextAlignment:NSTextAlignmentRight];
    [priceField setFont:[UIFont systemFontOfSize:14]];
    [priceField setTextColor:placehoderFontColor];
    [fivesView addSubview:priceLabel];
    [fivesView addSubview:priceField];
    
    UILabel *companyLabel = (UILabel *)[[self class] initLabelWithTitle:@"经纪人/公司"];
    companyField = [[PersonalTextField alloc]initWithFrame:CGRectMake(companyLabel.frame.size.width + 16, 1, kDeviceWidth - 32 -companyLabel.frame.size.width-28 , 40)];
    [companyField setText:_model.company];
    [companyField setTextAlignment:NSTextAlignmentRight];
    [companyField setFont:[UIFont systemFontOfSize:14]];
    
    [sixsView addSubview:companyLabel];
    [sixsView addSubview:companyField];
    
//    _skinColorTextField.isPickView = YES;
//    [_skinColorTextField setSkinColorField:YES];
//    _priceTextField.isPickView = YES;
//    [_priceTextField setPriceField:YES];
//    _languageTextField.isPickView = YES;
//    [_languageTextField setLanguageField:YES];
//    self.view = _scrollView;
    [self.view addSubview:_scrollView];
}
- (void)setUpNavigationItem
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 0, 50, 30);
    [titleLabel setText:@"编辑资料"];
    [titleLabel setTextColor:blackFontColor];
    [titleLabel setFont:[UIFont systemFontOfSize:17]];
    _titleView = titleLabel;
    
    self.navigationItem.titleView = titleLabel;
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(16, 16, 14, 13);
    [self.leftBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setImage:[UIImage imageNamed:@"top_back_b.pdf"]  forState:UIControlStateNormal];
    UIBarButtonItem *barLeftBtn = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    [self.navigationItem setLeftBarButtonItem:barLeftBtn];
    
    //    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    self.rightBtn.frame = CGRectMake(kDeviceWidth-38-16, 16, 38, 16);
    //    [self.rightBtn addTarget:self action:@selector(cameraBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.rightBtn setTitle:@"发送" forState:UIControlStateNormal];
    //    [self.rightBtn setTitleColor:grayFontColor forState:UIControlStateNormal];
    //    [self.rightBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    //    UIBarButtonItem *barRightBtn = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    //    [self.navigationItem setRightBarButtonItem:barRightBtn ];
    [self.navigationController.view setBackgroundColor:topBarBgColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+ (UILabel *)initLabelWithTitle:(NSString *)title
{
    UILabel *lab = [[UILabel alloc]init];
    [lab setText:title];
    [lab setFont:[UIFont systemFontOfSize:15]];
    [lab setTextColor:blackFontColor];
    CGSize textSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    lab.frame = CGRectMake(16, 0, textSize.width, 42);
    return lab;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [_experienceArray count] ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section !=0) {
        return 10;

    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExperienceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil){
        ModelTypeModel *model = _experienceArray[indexPath.section];
        //        cell = [[EventShowTableViewCell alloc]eventShowTableViewCell];
        cell = [[ExperienceTableViewCell alloc]initExperienceCellWithModel:model];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentTextView.userInteractionEnabled = NO;
    [existedHeight addObject:@(cell.sd_height)];
    if (indexPath.section ==[_experienceArray count] -1) {
        CGFloat height = 0;
        for (int i =0; i<[existedHeight count]; i++) {
            height = height +[existedHeight[i] floatValue] +10;
        }
        self.tableView.sd_height = height -10;
        UIButton *addTypeBtn = [_scrollView viewWithTag:102];
        addTypeBtn.sd_y = self.tableView.sd_y +self.tableView.sd_height +52;
        UIButton *submitTypeBtn = [_scrollView viewWithTag:103];
        submitTypeBtn.sd_y = addTypeBtn.sd_y + 63;
        _scrollView.contentSize = CGSizeMake(kDeviceWidth, submitTypeBtn.sd_y +42 +21);
        contentSView.frame = CGRectMake(0, 0, kDeviceWidth, submitTypeBtn.sd_y +42 +21);
    }
    [cell.rightBtn addTarget:self action:@selector(deleteExperience:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSBundle *bundle = [NSBundle bundleForClass:self.class];
//    NSURL *url = [bundle URLForResource:@"SuYa" withExtension:@"bundle"];
//    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
//    NSString *path = [imageBundle pathForResource:@"Experience" ofType:@"plist"];
//    NSDictionary *typeDict = [NSDictionary dictionaryWithContentsOfFile:path];
//    //        NSArray *typeArray  = [NSArray arrayWithContentsOfFile:path];
//    NSArray *typeArray = [typeDict objectForKey:@"Type"];
    
    ModelTypeModel *experienceModel = _experienceArray[indexPath.section];
    ExperienceTableViewCell *cell = [[ExperienceTableViewCell alloc]initExperienceCellWithModel:experienceModel];
    return cell.sd_height;
//    NSInteger index = [experienceModel.type integerValue];
//    UILabel *typeLabel = (UILabel *)[[self class] initLabelWithTitle:typeArray[index]];
//    CGSize textSize = [experienceModel.desc boundingRectWithSize:CGSizeMake(kDeviceWidth - 63 -32, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
//    if (textSize.height +14 < 42) {
//        return 84;
//    }else
//    {
//        return textSize.height +84;
//    }
//
//    
//    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddExperienceViewController *addVC = [[AddExperienceViewController alloc] init];
    addVC.delegate = self;
    ModelTypeModel *experienceModel = _experienceArray[indexPath.section];
    addVC.selected = [experienceModel.type integerValue] -1;
    addVC.typeName = typeArray[[experienceModel.type integerValue]-1];
    addVC.jlDesc = experienceModel.desc;
    addVC.jl_id = experienceModel.jl_id;
    [self.navigationController pushViewController:addVC animated:NO];

}
// 实现代理方法，需要遵守HJCActionSheetDelegate代理协议
- (void)actionSheet:(HJCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    AddExperienceViewController *addVC = [[AddExperienceViewController alloc] init];
    addVC.delegate = self;
    addVC.selected = buttonIndex -1;
    addVC.typeName = typeArray[buttonIndex -1];
    [self.navigationController pushViewController:addVC animated:NO];
    
}
//AddExperienceViewControllerdelegate
-(void)addSucced
{
    [self updateInfo];
//    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    [self requestInfo];
}
-(void)initDelegate
{
    
    nickNameTF.delegate = self;
    moodTF.delegate = self;
    heightTF.delegate = self;
    weightTF.delegate = self;
    BWHTF.delegate = self;
    shoesSizeTF.delegate = self;
    goodAtStyleTF.delegate = self;
    occupationalTypesTextField.delegate = self;
    countryTextField.delegate = self;
    destinationTextField.delegate = self;
    hairTextField.delegate = self;
    skinColorTextField.delegate = self;
    eyeField.delegate = self;
    shoulderField.delegate = self;
    legField.delegate = self;
    languageField.delegate = self;
    priceField.delegate = self;
    companyField.delegate = self;

}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField        // return NO to disallow editing.
{
    
    if ([textField isKindOfClass:[UITextField class]]&&[textField isKindOfClass:[PersonalTextField class]]) {
        tmpTF = (PersonalTextField *)textField;
        if (tmpTF.isMulChooseView) {
            //        [tmpTF resignFirstResponder];
            
            [self keyBoardHidden];
            //        [tmpTF becomeFirstResponder];
            //        return YES;
            
        }
    }
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField           // became first responder
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    //    tmpTF = (DemoTextField *)textField;
    //    if (tmpTF.isMulChooseView) {
    //        [self keyBoardHide];
    //
    //
    //    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (heightTF == textField||weightTF == textField||legField ==textField)
    {
        if ([toBeString length] > 3) {
            textField.text = [toBeString substringToIndex:2];
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"只能输入3位";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];
        }
    }else if(shoulderField == textField||shoesSizeTF ==textField)
    {
        if ([toBeString length] > 2) {
            textField.text = [toBeString substringToIndex:1];
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"只能输入2位";
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            
            [hud hide:YES afterDelay:1];
        }
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //取消第一响应者，就是结束输入病隐藏键盘
    [tmpTF resignFirstResponder];
    return YES;
}
-(void) keyboardDidShow:(NSNotification *) notification
{
//    if (_textField == nil) return;
//    if (keyboardIsShown) return;
//    if (![_textField isKindOfClass:[MHTextField class]]) return;
    
    NSDictionary* info = [notification userInfo];
    
    NSValue *aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    keyboardSize = [aValue CGRectValue].size;
    
    [self scrollToField];
    
//    self.keyboardIsShown = YES;
    
}
-(void) keyboardWillHide:(NSNotification *) notification
{
    NSTimeInterval duration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        if (-self.scrollView.contentOffset.y >keyboardSize.height) {
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        }
    }];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:self];
}
- (void)scrollToField
{
    CGRect textFieldRect = tmpTF.frame;
    
    CGRect aRect = self.scrollView.bounds;
    
    aRect.origin.y = -_scrollView.contentOffset.y;
    aRect.size.height -= keyboardSize.height  + 22;
    
    CGPoint textRectBoundary = CGPointMake(textFieldRect.origin.x, textFieldRect.origin.y + textFieldRect.size.height);
    
    if (!CGRectContainsPoint(aRect, textRectBoundary) || _scrollView.contentOffset.y > 0) {
        CGPoint scrollPoint = CGPointMake(0.0,  tmpTF.frame.origin.y + tmpTF.frame.size.height - aRect.size.height);
        
        if (scrollPoint.y < 0) scrollPoint.y = 0;
        
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}
-(void)tap
{

}
-(void)submitTypeBtnClicked
{
    if ([nickNameTF.text isEqualToString:@""] || [heightTF.text isEqualToString:@""] || [weightTF.text isEqualToString:@""] || [BWHTF.text isEqualToString:@""] || [shoesSizeTF.text isEqualToString:@""] || [goodAtStyleTF.text isEqualToString:@""] || [occupationalTypesTextField.text isEqualToString:@""] || [countryTextField.text isEqualToString:@""] || [destinationTextField.text isEqualToString:@""]) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请把资料填写完整";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
        return;
        
    }else if ([heightTF.text integerValue]<50||[heightTF.text integerValue]>300)
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"身高范围值为50-300cm";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
        return;
        
    }else if ([weightTF.text integerValue]<10||[weightTF.text integerValue]>300)
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"体重范围值为10-300kg";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
        return;
    }
    else if ([shoesSizeTF.text integerValue]<20||[shoesSizeTF.text integerValue]>50)
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"鞋码范围值为20-50";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
        return;
    }else if ((![shoulderField.text isEqualToString:@""])&&([shoulderField.text integerValue]<10||[shoulderField.text integerValue]>80) ) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"肩宽范围值为10-80cm";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
        return;
        
    }else if ((![legField.text isEqualToString:@""])&&([legField.text integerValue]<20||[legField.text integerValue]>150))
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"腿长范围值为20-150cm";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
        return;
        
    }
    else
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:[userDefaults objectForKey:@"user_id"],@"user_id",nickNameTF.text,@"nick_name",moodTF.text,@"sign",heightTF.text,@"height",weightTF.text,@"weight",BWHTF.text,@"three_size",shoesSizeTF.text,@"shoe_size",goodAtStyleTF.mulSelectedItem,@"style",occupationalTypesTextField.mulSelectedItem,@"work_type",[NSString stringWithFormat:@"%@",@(countryTextField.selectedItem)],@"country",[NSString stringWithFormat:@"%@",@(destinationTextField.selectedItem)],@"address",[NSString stringWithFormat:@"%@",@(hairTextField.selectedItem)], @"hair",[NSString stringWithFormat:@"%@",@(skinColorTextField.selectedItem)],@"color",[NSString stringWithFormat:@"%@",@(eyeField.selectedItem)],@"eye",shoulderField.text,@"shoulder",legField.text,@"legs",[NSString stringWithFormat:@"%@",@(priceField.selectedItem)],@"price",[NSString stringWithFormat:@"%@",@(languageField.selectedItem)],@"language",companyField.text,@"company",nil];
        
        [RequestCustom registerModelInfo:dict Complete:^(BOOL succed, id obj)
         {
             NSLog(@"%@",obj);
             if (succed) {
                 NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
                 if ([status isEqual:@"1"]) {
                     if ([_delegate respondsToSelector:@selector(editPersonCenterInfoRefrensh)]) {
                         [_delegate editPersonCenterInfoRefrensh];
                     }
                     [self.navigationController popViewControllerAnimated:NO];
                 }
             }
         }];

    }
}
-(void)vBtnClicked:(UIButton *)sender
{
    
}
-(void)backBtnClicked:(UIButton *)sender
{
    [self keyBoardHidden];
    if ([_delegate respondsToSelector:@selector(editPersonCenterInfoRefrensh)]) {
        [_delegate editPersonCenterInfoRefrensh];
    }
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)addTypeBtnClicked
{
    

    HJCActionSheet *sheet = [[HJCActionSheet alloc] initWithDelegate:self CancelTitle:@"取消" OtherTitles:typeArray[0], typeArray[1], typeArray[2],typeArray[3],typeArray[4],typeArray[5],typeArray[6], nil];
    [sheet show];
}
-(void)deleteExperience:(UIButton *)btn
{
    ExperienceTableViewCell *cell = (ExperienceTableViewCell *)[[btn superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    ModelTypeModel *model = self.experienceArray[indexPath.section];
    [RequestCustom delExperienceInfoById:model.jl_id complete:^(BOOL succed, id obj) {
        if (succed) {
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                [self.tableView beginUpdates];
                [self.experienceArray removeObjectAtIndex:[indexPath section]];
//                NSArray *_tempIndexPathArr = [NSArray arrayWithObject:indexPath];
                NSIndexSet *index = [NSIndexSet indexSetWithIndex:[indexPath section]];
                [self.tableView deleteSections:index withRowAnimation:UITableViewRowAnimationFade];
                
                [self.tableView endUpdates];
                self.tableView.sd_height = self.tableView.sd_height - [existedHeight[indexPath.section] floatValue] -10;
                UIButton *addTypeBtn = [_scrollView viewWithTag:102];
                addTypeBtn.sd_y = self.tableView.sd_y +self.tableView.sd_height +52;
                UIButton *submitTypeBtn = [_scrollView viewWithTag:103];
                submitTypeBtn.sd_y = addTypeBtn.sd_y + 63;
                _scrollView.contentSize = CGSizeMake(kDeviceWidth, submitTypeBtn.sd_y +42 +21);
            }
        }
        
    }];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)initImageBoarderWithView:(UIView *)view
{
    view.layer.borderColor = textFieldBoardColor.CGColor;
    view.layer.borderWidth = 0.5;
    [view setBackgroundColor:[UIColor whiteColor]];
}
-(void)requestInfo
{
    NSString *userId;
    if (_user_id) {
        userId = _user_id;
    }else
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        userId = [userDefaults objectForKey:@"user_id"];
    }
    [RequestCustom requestPersonalCenterModelUserInfoByUserId:userId complete:^(BOOL succed, id obj) {
        if (succed) {
            [_loadFailView removeFromSuperview];
            _loadFailView =nil;
            if ([obj objectForKey:@"data"]== [NSNull null]) {
            }
            NSDictionary *dataDict = [obj objectForKey:@"data"];
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                _model = [ModelInfosModel initModelInfosWithDict:dataDict];
                
                for (int i = 0; i<[_model.jingli count]; i ++) {
                    ModelTypeModel *experienceModel = [ModelTypeModel initModelTypeWithDict:_model.jingli[i]];
                    [_experienceArray addObject:experienceModel];
                }
                [self setUpView];
                [self initDelegate];
//                [self.tableView reloadData];
            }
        }else
        {
            [self initFailLoadView];
        }
        
    }];
}
-(void)updateInfo
{
    NSString *userId;
    if (_user_id) {
        userId = _user_id;
    }else
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        userId = [userDefaults objectForKey:@"user_id"];
    }
    [RequestCustom requestPersonalCenterModelUserInfoByUserId:userId complete:^(BOOL succed, id obj) {
        if (succed) {
            [_loadFailView removeFromSuperview];
            _loadFailView =nil;
            if ([obj objectForKey:@"data"]== [NSNull null]) {
            }
            NSDictionary *dataDict = [obj objectForKey:@"data"];
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                _model = [ModelInfosModel initModelInfosWithDict:dataDict];
                [_experienceArray removeAllObjects];
                [existedHeight removeAllObjects];
//                _experienceArray = [NSMutableArray array];
                for (int i = 0; i<[_model.jingli count]; i ++) {
                    ModelTypeModel *experienceModel = [ModelTypeModel initModelTypeWithDict:_model.jingli[i]];
                    [_experienceArray addObject:experienceModel];
                }
//                [self setUpView];
//                [self initDelegate];
//                self.tableView.sd_height = 90 *[_experienceArray count];
//                UIButton *addTypeBtn = [_scrollView viewWithTag:102];
//                addTypeBtn.sd_y = self.tableView.sd_y +self.tableView.sd_height +52;
//                UIButton *submitTypeBtn = [_scrollView viewWithTag:103];
//                submitTypeBtn.sd_y = addTypeBtn.sd_y + 63;
//                _scrollView.contentSize = CGSizeMake(kDeviceWidth, submitTypeBtn.sd_y +42 +21);
                _scrollView.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight);
                if ([_experienceArray count]==0) {
                    self.tableView.sd_height = 0;
                }else
                {
                    self.tableView.sd_height = 90 *[_experienceArray count] +15;
                }
//                self.tableView.sd_height = self.tableView.sd_height +90;
                [self.tableView reloadData];
                //                [self.tableView reloadData];
            }
        }else
        {
            [self initFailLoadView];
        }
        
    }];
}
-(void)reloadTableViewData
{
    [self requestInfo];
}
@end
