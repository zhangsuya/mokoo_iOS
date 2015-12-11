//
//  EditPersonalCentalItemViewController.m
//  mokoo
//
//  Created by Mac on 15/9/17.
//  Copyright (c) 2015年 Mac. All rights reserved.
//
#import "XLForm.h"
#import "EditPersonalCentalItemViewController.h"

@interface EditPersonalCentalItemViewController ()

@end

@implementation EditPersonalCentalItemViewController

NSString * const kValidationName = @"kName";
NSString * const kValidationEmail = @"kEmail";
NSString * const kValidationPassword = @"kPassword";
NSString * const kValidationInteger = @"kInteger";


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeForm];
    }
    return self;
}


-(void)initializeForm
{
    XLFormDescriptor * formDescriptor = [XLFormDescriptor formDescriptorWithTitle:@"Text Fields"];
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    // Name Section
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Validation Required"];
    [formDescriptor addFormSection:section];
    
    // Name
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kValidationName rowType:XLFormRowDescriptorTypeText title:@"Name"];
    [row.cellConfigAtConfigure setObject:@"Required..." forKey:@"textField.placeholder"];
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    row.required = YES;
    row.value = @"Martin";
    [section addFormRow:row];
    
    // Email Section
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Validation Email"];
    [formDescriptor addFormSection:section];
    
    // Email
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kValidationEmail rowType:XLFormRowDescriptorTypeText title:@"Email"];
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    row.required = NO;
    row.value = @"not valid email";
    [row addValidator:[XLFormValidator emailValidator]];
    [section addFormRow:row];
    
    // password Section
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Validation Password"];
    section.footerTitle = @"between 6 and 32 charachers, 1 alphanumeric and 1 numeric";
    [formDescriptor addFormSection:section];
    
    // Password
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kValidationPassword rowType:XLFormRowDescriptorTypePassword title:@"Password"];
    [row.cellConfigAtConfigure setObject:@"Required..." forKey:@"textField.placeholder"];
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    row.required = YES;
    [row addValidator:[XLFormRegexValidator formRegexValidatorWithMsg:@"At least 6, max 32 characters" regex:@"^(?=.*\\d)(?=.*[A-Za-z]).{6,32}$"]];
    [section addFormRow:row];
    
    // number Section
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Validation Numbers"];
    section.footerTitle = @"greater than 50 and less than 100";
    [formDescriptor addFormSection:section];
    
    // Integer
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kValidationInteger rowType:XLFormRowDescriptorTypeInteger title:@"Integer"];
    [row.cellConfigAtConfigure setObject:@"Required..." forKey:@"textField.placeholder"];
    [row.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    row.required = YES;
    [row addValidator:[XLFormRegexValidator formRegexValidatorWithMsg:@"greater than 50 and less than 100" regex:@"^([5-9][0-9]|100)$"]];
    [section addFormRow:row];
    
    self.form = formDescriptor;
    self.view = self.tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.navigationItem.rightBarButtonItem setTarget:self];
//    [self.navigationItem.rightBarButtonItem setAction:@selector(validateForm:)];
    [self initializeForm];
}

#pragma mark - actions

-(void)validateForm:(UIBarButtonItem *)buttonItem
{
    NSArray * array = [self formValidationErrors];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XLFormValidationStatus * validationStatus = [[obj userInfo] objectForKey:XLValidationStatusErrorKey];
        if ([validationStatus.rowDescriptor.tag isEqualToString:kValidationName]){
            UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:[self.form indexPathOfFormRow:validationStatus.rowDescriptor]];
            cell.backgroundColor = [UIColor orangeColor];
            [UIView animateWithDuration:0.3 animations:^{
                cell.backgroundColor = [UIColor whiteColor];
            }];
        }
        else if ([validationStatus.rowDescriptor.tag isEqualToString:kValidationEmail]){
            UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:[self.form indexPathOfFormRow:validationStatus.rowDescriptor]];
            [self animateCell:cell];
        }
        else if ([validationStatus.rowDescriptor.tag isEqualToString:kValidationPassword]){
            UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:[self.form indexPathOfFormRow:validationStatus.rowDescriptor]];
            [self animateCell:cell];
        }
        else if ([validationStatus.rowDescriptor.tag isEqualToString:kValidationInteger]){
            UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:[self.form indexPathOfFormRow:validationStatus.rowDescriptor]];
            [self animateCell:cell];
        }
    }];
}


#pragma mark - Helper

-(void)animateCell:(UITableViewCell *)cell
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";
    animation.values =  @[ @0, @20, @-20, @10, @0];
    animation.keyTimes = @[@0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1];
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.additive = YES;
    
    [cell.layer addAnimation:animation forKey:@"shake"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
