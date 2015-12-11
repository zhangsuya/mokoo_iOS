//
//  ShowCell.m
//  mokoo
//
//  Created by Mac on 15/8/23.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ShowCell.h"
#import "MokooMacro.h"
#import "ImageListModel.h"
#import "UIImageView+WebCache.h"
#import "XHImageViewer.h"
#import "UIButton+EnlargeTouchArea.h"
@interface ShowCell()
{
    
}

@end
@implementation ShowCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(UITableViewCell *)initShowCell
{
    ShowCell *cell = [[ShowCell alloc]init];
    cell.avatarImageView = [[UIImageView alloc]init];
    cell.vImageView = [[UIImageView alloc]init];
    cell.titleLabel = [[UILabel alloc]init];
    cell.dateLabel = [[UILabel alloc]init];
    cell.contentLabel = [[UILabel alloc]init];
    cell.addressImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"location_s.pdf"] ];
    cell.addressLabel = [[UILabel alloc]init];
    cell.deleteBtn = [[UIButton alloc]init];
    cell.likeBtn = [[MCFireworksButton alloc]init];
    cell.likeCountLabel = [[UILabel alloc]init];
    cell.commentBtn = [[UIButton alloc]init];
    cell.commentCountLabel = [[UILabel alloc]init];
    cell.imageViewArray = [NSMutableArray array];
    
    cell.backgroundColor = viewBgColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.likeBtn setEnlargeEdgeWithTop:10 right:20 bottom:5 left:10];
    [cell.commentBtn setEnlargeEdgeWithTop:10 right:20 bottom:5 left:5];
    [cell.deleteBtn setEnlargeEdgeWithTop:5 right:20 bottom:5 left:20];
    return cell;
}
- (id)initShowCellWithModel:(ShowCellModel *)model
{
    ShowCell *cell = [[ShowCell alloc]initShowCell];
    if (model.user_img !=nil) {
        cell.avatarImageView.frame = CGRectMake(15, 13, 42, 42);
        cell.avatarImageView.autoresizingMask = UIViewAutoresizingNone;
        cell.avatarImageView.layer.masksToBounds = YES;
        cell.avatarImageView.layer.cornerRadius = cell.avatarImageView.frame.size.width/2;
        [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.user_img] placeholderImage:[UIImage imageNamed:@"head.pdf"]];
        //        [cell.imageView setBackgroundColor:[UIImage]]
        [cell.contentView addSubview:cell.avatarImageView];
    }
    if ([model.is_verify isEqualToString:@"1"]) {
        cell.vImageView.frame = CGRectMake(44, 43, 14, 14);
        [cell.vImageView setImage:[UIImage imageNamed:@"v.pdf"]];
        [cell.contentView addSubview:cell.vImageView];
    }
    if (model.nick_name != nil) {
        cell.titleLabel.frame = CGRectMake(67, 15, kDeviceWidth - 67, 21);
        cell.titleLabel.text = model.nick_name;
        [cell.contentView addSubview:cell.titleLabel];
    }
    if (model.time != nil) {
        cell.dateLabel.frame = CGRectMake(67, 40, kDeviceWidth - 67, 14);
        cell.dateLabel.text = model.time;
        _height = 62.0f;
        [cell.contentView addSubview:cell.dateLabel];
    }
    if (model.title !=nil) {
        CGSize textSize = [model.title boundingRectWithSize:CGSizeMake(kDeviceWidth - 67 -13, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        //        cell.contentLabel.frame = CGRectMake(67, 62, textSize.width, textSize.height);
        cell.contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        cell.contentLabel.numberOfLines = 0;//以上两行代码保证文本多行显示
        cell.contentLabel.frame = CGRectMake(67, 62, textSize.width, textSize.height);
        cell.contentLabel.text = model.title;
        _height = _height + textSize.height +5;
        [cell.contentView addSubview:cell.contentLabel];
    }
    
    if (model.address !=nil&&model.address.length!=0 ) {
        
        CGSize textSize = [model.address boundingRectWithSize:CGSizeMake(kDeviceWidth - 81 -13, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil].size;
        cell.addressImageView.frame = CGRectMake(67, _height, 9, 12);
        cell.addressLabel.lineBreakMode = NSLineBreakByCharWrapping;
        cell.addressLabel.numberOfLines = 0;//以上两行代码保证文本多行显示
        cell.addressLabel.frame = CGRectMake(81, _height, textSize.width, textSize.height);
        cell.addressLabel.text = model.address;
        [cell.contentView addSubview:cell.addressImageView];
        [cell.contentView addSubview:cell.addressLabel];

        _height = _height + textSize.height ;

    }
    if ([model.imglist count]!=0) {
        if (model.imglist.count == 1) {
            
            ImageListModel *imageModel  = [ImageListModel initListModelWithDict:(NSDictionary *)(model.imglist[0])];
            UIImageView *imageview  = [[UIImageView alloc] initWithFrame:CGRectMake(67, _height +8, 145, 210)];
            [imageview   sd_setImageWithURL:[NSURL URLWithString:imageModel.url] placeholderImage:[UIImage imageNamed:@"pic_loading.pdf"]];
            imageview.clipsToBounds = YES;
            imageview.contentMode   = UIViewContentModeScaleAspectFill;
            [cell.contentView addSubview:imageview];
            //            [_viewPartTwo addSubview:imageview];
            //            _viewPartTwo.frame  = CGRectMake(LEFT_PART, viewoneMaxY, PART_WIDTH, 210);
            imageview.userInteractionEnabled    = YES;
            imageview.tag       = 0;
            
            if ([cell.imageViewArray count] == 0) {
                [cell.imageViewArray addObject:imageview];
            }
            for (int i = 0; i<[cell.imageViewArray count]; i ++) {
                UIImageView *tmpView =(UIImageView *)cell.imageViewArray[i];
                if (tmpView.tag != imageview.tag) {
                    [cell.imageViewArray addObject:imageview];
                }
            }
            _height = _height +218;
            
        } else if (model.imglist.count ==4) {
            for (NSInteger i = 0; i < 4; i++) {
                ImageListModel    *imageModel = [ImageListModel initListModelWithDict:(NSDictionary *)(model.imglist[i])];
                NSInteger   numwith     = i%2;
                NSInteger   numheight   = i/2;
                UIImageView *imageview  = [[UIImageView alloc] initWithFrame:CGRectMake(67 +(HEIGHT_TWO_IMAG_WITH+5)*numwith, (HEIGHT_TWO_IMAG_WITH+5)*numheight +_height +5, HEIGHT_TWO_IMAG_WITH, HEIGHT_TWO_IMAG_WITH)];
                [imageview sd_setImageWithURL:[NSURL URLWithString:imageModel.url] placeholderImage:[UIImage imageNamed:@"pic_loading.pdf"]];
                imageview.clipsToBounds = YES;
                imageview.contentMode   = UIViewContentModeScaleAspectFill;
                [cell.contentView addSubview:imageview];
                //                [_viewPartTwo addSubview:imageview];
                imageview.userInteractionEnabled    = YES;
                imageview.tag   =  i;
                
                if ([cell.imageViewArray count] == 0) {
                    [cell.imageViewArray addObject:imageview];
                }
                for (int i = 0; i<[cell.imageViewArray count]; i ++) {
                    UIImageView *tmpView =(UIImageView *)cell.imageViewArray[i];
                    if (tmpView.tag != imageview.tag) {
                        [cell.imageViewArray addObject:imageview];
                    }
                }
                
            }
            _height = _height + HEIGHT_TWO_IMAG_WITH*2+5 +5;
            
            
        } else {
            NSInteger imagcount;
            if ([model.imglist count] > 9) {
                imagcount = 9;
            } else {
                imagcount = [model.imglist count];
            }
            
            for (NSInteger i = 0; i < imagcount; i++) {
                ImageListModel    *imageModel = [ImageListModel initListModelWithDict:(NSDictionary *)(model.imglist[i])];
                NSInteger   numwith     = i%3;
                NSInteger   numheight   = i/3;
                UIImageView *imageview   =[[UIImageView alloc] initWithFrame: CGRectMake(67 + (HEIGHT_TWO_IMAG_WITH+5)*numwith, (HEIGHT_TWO_IMAG_WITH+5)*numheight +_height +5, HEIGHT_TWO_IMAG_WITH, HEIGHT_TWO_IMAG_WITH)];
                NSURL *url = [NSURL URLWithString:imageModel.url];
                [imageview sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"pic_loading.pdf"]];
                imageview.clipsToBounds = YES;
                imageview.contentMode   = UIViewContentModeScaleAspectFill;
                [cell.contentView addSubview:imageview];
                //                [_viewPartTwo addSubview:imageview];
                imageview.tag   = i;
                imageview.userInteractionEnabled    = YES;
               
                if ([cell.imageViewArray count] == 0) {
                    [cell.imageViewArray addObject:imageview];
                }
                for (int i = 0; i<[cell.imageViewArray count]; i ++) {
                    UIImageView *tmpView =(UIImageView *)cell.imageViewArray[i];
                    if (tmpView.tag != imageview.tag) {
                        [cell.imageViewArray addObject:imageview];
                    }
                }
                if (i == imagcount - 1) {
                    _height = _height + (HEIGHT_TWO_IMAG_WITH +5) *(numheight + 1)-5;
                }
            }
            _height = _height +8;
        }
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([[userDefaults objectForKey:@"user_id"] isEqualToString:model.user_id]) {
        cell.deleteBtn.frame = CGRectMake(60, _height + 15, 40, 21);
        [cell.contentView addSubview:cell.deleteBtn];
        
    }
    cell.likeBtn.frame = CGRectMake(kDeviceWidth -123 , _height + 13, 21, 21);
    [cell.contentView addSubview:cell.likeBtn];
    
    
    if ([model.is_zan isEqualToString:@"1"]) {
        [cell.likeBtn setImage:[UIImage imageNamed:@"icon_good_on.pdf"] forState:UIControlStateNormal];
        cell.likeBtn.isSelected = YES;
        cell.likeCountLabel.textColor = likeOnBtnColor;
    }
    if (model.good_count !=nil) {
        cell.likeCountLabel.frame = CGRectMake(kDeviceWidth -94, _height + 13, 21, 21);
        cell.likeCountLabel.text = model.good_count;
        [cell.contentView addSubview:cell.likeCountLabel];
    }
    cell.commentBtn.frame = CGRectMake(kDeviceWidth -64, _height + 13, 21, 21);
    [cell.contentView addSubview:cell.commentBtn];
    if (model.comment_count != nil) {
        cell.commentCountLabel.frame = CGRectMake(kDeviceWidth -35, _height + 13, 21, 21);
        cell.commentCountLabel.text = model.comment_count;
        [cell.contentView addSubview:cell.commentCountLabel];
    }
    _height = _height + 13 +21 +13;
    cell.height = _height;
    CALayer *lineLayer = [[CALayer alloc]init];
    lineLayer.frame = CGRectMake(0, _height -0.5, kDeviceWidth, 0.5);
    lineLayer.backgroundColor = [placehoderFontColor CGColor];
    [cell.contentView.layer addSublayer:lineLayer];
    cell.frame = CGRectMake(0, 0, kDeviceWidth, _height);
    return cell;
}
- (id)initShowCellWithModel:(ShowCellModel *)model yOrign:(CGFloat)yOrign
{
    ShowCell *cell = [[ShowCell alloc]initShowCell];
    cell.alpha = 0;
    if (model.user_img !=nil) {
        cell.avatarImageView.frame = CGRectMake(15, yOrign +13, 42, 42);
        cell.avatarImageView.autoresizingMask = UIViewAutoresizingNone;
        cell.avatarImageView.layer.masksToBounds = YES;
        cell.avatarImageView.layer.cornerRadius = cell.avatarImageView.frame.size.width/2;
        [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.user_img] placeholderImage:[UIImage imageNamed:@"head.pdf"]];
        //        [cell.imageView setBackgroundColor:[UIImage]]
        [cell.contentView addSubview:cell.avatarImageView];
    }
    if ([model.is_verify isEqualToString:@"1"]) {
        cell.vImageView.frame = CGRectMake(44, yOrign +43, 14, 14);
        [cell.vImageView setImage:[UIImage imageNamed:@"v.pdf"]];
        [cell.contentView addSubview:cell.vImageView];
    }
    if (model.nick_name != nil) {
        cell.titleLabel.frame = CGRectMake(67, yOrign +15, kDeviceWidth - 67, 21);
        cell.titleLabel.text = model.nick_name;
        [cell.contentView addSubview:cell.titleLabel];
    }
    if (model.time != nil) {
        cell.dateLabel.frame = CGRectMake(67, yOrign +40, kDeviceWidth - 67, 14);
        cell.dateLabel.text = model.time;
        _height = 62.0f;
        [cell.contentView addSubview:cell.dateLabel];
    }
    if (model.title !=nil&&model.title.length!=0) {
        CGSize textSize = [model.title boundingRectWithSize:CGSizeMake(kDeviceWidth - 67 -13, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        //        cell.contentLabel.frame = CGRectMake(67, 62, textSize.width, textSize.height);
        cell.contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        cell.contentLabel.numberOfLines = 0;//以上两行代码保证文本多行显示
        cell.contentLabel.frame = CGRectMake(67, 62, textSize.width, textSize.height);
        cell.contentLabel.text = model.title;
        _height = _height + textSize.height +5;
        [cell.contentView addSubview:cell.contentLabel];
    }
    
    if (model.address !=nil&&model.address.length!=0 ) {
        
        CGSize textSize = [model.address boundingRectWithSize:CGSizeMake(kDeviceWidth - 81 -13, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil].size;
        cell.addressImageView.frame = CGRectMake(67, _height, 9, 12);
        cell.addressLabel.lineBreakMode = NSLineBreakByCharWrapping;
        cell.addressLabel.numberOfLines = 0;//以上两行代码保证文本多行显示
        cell.addressLabel.frame = CGRectMake(81, _height, textSize.width, textSize.height);
        cell.addressLabel.text = model.address;
        [cell.contentView addSubview:cell.addressImageView];
        [cell.contentView addSubview:cell.addressLabel];
        
        _height = _height + textSize.height ;
        
    }
    
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void)
     {
         cell.avatarImageView.frame = CGRectMake(15, 13, 42, 42);
         cell.vImageView.frame = CGRectMake(44, 43, 14, 14);
         cell.titleLabel.frame = CGRectMake(67, 15, kDeviceWidth - 67, 21);
         cell.dateLabel.frame = CGRectMake(67, 40, kDeviceWidth - 67, 14);
         cell.alpha = 1;
     }
                     completion:NULL];
    if ([model.imglist count]!=0) {
        if (model.imglist.count == 1) {
            
            ImageListModel *imageModel  = [ImageListModel initListModelWithDict:(NSDictionary *)(model.imglist[0])];
            UIImageView *imageview  = [[UIImageView alloc] initWithFrame:CGRectMake(67, _height +8, 145, 210)];
            [imageview   sd_setImageWithURL:[NSURL URLWithString:imageModel.url] placeholderImage:[UIImage imageNamed:@"pic_loading.pdf"]];
            imageview.clipsToBounds = YES;
            imageview.contentMode   = UIViewContentModeScaleAspectFill;
            [cell.contentView addSubview:imageview];
            //            [_viewPartTwo addSubview:imageview];
            //            _viewPartTwo.frame  = CGRectMake(LEFT_PART, viewoneMaxY, PART_WIDTH, 210);
            imageview.userInteractionEnabled    = YES;
            imageview.tag       = 0;
            
            if ([cell.imageViewArray count] == 0) {
                [cell.imageViewArray addObject:imageview];
            }
            for (int i = 0; i<[cell.imageViewArray count]; i ++) {
                UIImageView *tmpView =(UIImageView *)cell.imageViewArray[i];
                if (tmpView.tag != imageview.tag) {
                    [cell.imageViewArray addObject:imageview];
                }
            }
            _height = _height +218;
            
        } else if (model.imglist.count ==4) {
            for (NSInteger i = 0; i < 4; i++) {
                ImageListModel    *imageModel = [ImageListModel initListModelWithDict:(NSDictionary *)(model.imglist[i])];
                NSInteger   numwith     = i%2;
                NSInteger   numheight   = i/2;
                UIImageView *imageview  = [[UIImageView alloc] initWithFrame:CGRectMake(67 +(HEIGHT_TWO_IMAG_WITH+5)*numwith, (HEIGHT_TWO_IMAG_WITH+5)*numheight +_height +5, HEIGHT_TWO_IMAG_WITH, HEIGHT_TWO_IMAG_WITH)];
                [imageview sd_setImageWithURL:[NSURL URLWithString:imageModel.url] placeholderImage:[UIImage imageNamed:@"pic_loading.pdf"]];
                imageview.clipsToBounds = YES;
                imageview.contentMode   = UIViewContentModeScaleAspectFill;
                [cell.contentView addSubview:imageview];
                //                [_viewPartTwo addSubview:imageview];
                imageview.userInteractionEnabled    = YES;
                imageview.tag   =  i;
                
                if ([cell.imageViewArray count] == 0) {
                    [cell.imageViewArray addObject:imageview];
                }
                for (int i = 0; i<[cell.imageViewArray count]; i ++) {
                    UIImageView *tmpView =(UIImageView *)cell.imageViewArray[i];
                    if (tmpView.tag != imageview.tag) {
                        [cell.imageViewArray addObject:imageview];
                    }
                }
                
            }
            _height = _height + HEIGHT_TWO_IMAG_WITH*2+5 +5;
            
            
        } else {
            NSInteger imagcount;
            if ([model.imglist count] > 9) {
                imagcount = 9;
            } else {
                imagcount = [model.imglist count];
            }
            
            for (NSInteger i = 0; i < imagcount; i++) {
                ImageListModel    *imageModel = [ImageListModel initListModelWithDict:(NSDictionary *)(model.imglist[i])];
                NSInteger   numwith     = i%3;
                NSInteger   numheight   = i/3;
                UIImageView *imageview   =[[UIImageView alloc] initWithFrame: CGRectMake(67 + (HEIGHT_TWO_IMAG_WITH+5)*numwith, (HEIGHT_TWO_IMAG_WITH+5)*numheight +_height +5, HEIGHT_TWO_IMAG_WITH, HEIGHT_TWO_IMAG_WITH)];
                NSURL *url = [NSURL URLWithString:imageModel.url];
                [imageview sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"pic_loading.pdf"]];
                imageview.clipsToBounds = YES;
                imageview.contentMode   = UIViewContentModeScaleAspectFill;
                [cell.contentView addSubview:imageview];
                //                [_viewPartTwo addSubview:imageview];
                imageview.tag   = i;
                imageview.userInteractionEnabled    = YES;
                
                if ([cell.imageViewArray count] == 0) {
                    [cell.imageViewArray addObject:imageview];
                }
                for (int i = 0; i<[cell.imageViewArray count]; i ++) {
                    UIImageView *tmpView =(UIImageView *)cell.imageViewArray[i];
                    if (tmpView.tag != imageview.tag) {
                        [cell.imageViewArray addObject:imageview];
                    }
                }
                if (i == imagcount - 1) {
                    _height = _height + (HEIGHT_TWO_IMAG_WITH +5) *(numheight + 1)-5;
                }
            }
            _height = _height +8;
        }
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([[userDefaults objectForKey:@"user_id"] isEqualToString:model.user_id]) {
        cell.deleteBtn.frame = CGRectMake(60, _height + 15, 40, 21);
        [cell.contentView addSubview:cell.deleteBtn];
        
    }
    cell.likeBtn.frame = CGRectMake(kDeviceWidth -123 , _height + 13, 21, 21);
    [cell.contentView addSubview:cell.likeBtn];
    
    
    if ([model.is_zan isEqualToString:@"1"]) {
        [cell.likeBtn setImage:[UIImage imageNamed:@"icon_good_on.pdf"] forState:UIControlStateNormal];
        cell.likeBtn.isSelected = YES;
        cell.likeCountLabel.textColor = likeOnBtnColor;
    }
    if (model.good_count !=nil) {
        cell.likeCountLabel.frame = CGRectMake(kDeviceWidth -94, _height + 13, 21, 21);
        cell.likeCountLabel.text = model.good_count;
        [cell.contentView addSubview:cell.likeCountLabel];
    }
    cell.commentBtn.frame = CGRectMake(kDeviceWidth -64, _height + 13, 21, 21);
    [cell.contentView addSubview:cell.commentBtn];
    if (model.comment_count != nil) {
        cell.commentCountLabel.frame = CGRectMake(kDeviceWidth -35, _height + 13, 21, 21);
        cell.commentCountLabel.text = model.comment_count;
        [cell.contentView addSubview:cell.commentCountLabel];
    }
    _height = _height + 13 +21 +13;
    cell.height = _height;
    CALayer *lineLayer = [[CALayer alloc]init];
    lineLayer.frame = CGRectMake(0, _height -0.5, kDeviceWidth, 0.5);
    lineLayer.backgroundColor = [placehoderFontColor CGColor];
    [cell.contentView.layer addSublayer:lineLayer];
    cell.frame = CGRectMake(0, 0, kDeviceWidth, _height);
    return cell;
}

-(void)tapCli:(UIGestureRecognizer *)tap
{
    ShowCell *cell = (ShowCell *)[[tap.view superview] superview];
    XHImageViewer *imageViewer = [[XHImageViewer alloc] init];
    //    imageViewer.delegate = self;
    [imageViewer showWithImageViews:cell.imageViewArray selectedView:(UIImageView *)tap.view];
    
}
-(void)setAvatarImageView:(UIImageView *)avatarImageView
{

    _avatarImageView = avatarImageView;
}
-(void)setTitleLabel:(UILabel *)titleLabel
{
    [titleLabel setFont:[UIFont systemFontOfSize:15]];
    [titleLabel setTextColor:blackFontColor];
    _titleLabel = titleLabel;
}
-(void)setAddressLabel:(UILabel *)addressLabel
{
    [addressLabel setTextColor:yellowShowColor];
    [addressLabel setFont: [UIFont systemFontOfSize:10]];
    _addressLabel = addressLabel;
}
-(void)setDateLabel:(UILabel *)dateLabel
{
    [dateLabel setTextColor:grayFontColor];
    [dateLabel setFont: [UIFont systemFontOfSize:10]];
    _dateLabel = dateLabel;
}
-(void)setContentLabel:(UILabel *)contentLabel
{
    [contentLabel setFont:[UIFont systemFontOfSize:15]];
    [contentLabel setTextColor:blackFontColor];
    _contentLabel = contentLabel;
}
-(void)setDeleteBtn:(UIButton *)deleteBtn
{
    [deleteBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [deleteBtn setTitleColor:grayFontColor forState:UIControlStateNormal];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    _deleteBtn = deleteBtn;
}
-(void)setLikeBtn:(MCFireworksButton *)likeBtn
{
    [likeBtn setImage:[UIImage imageNamed:@"icon_good.pdf"] forState:UIControlStateNormal];
    likeBtn.particleScale = 0.05;
    likeBtn.particleScaleRange = 0.02;
    _likeBtn = likeBtn;
}
- (void)setCommentBtn:(UIButton *)commentBtn
{
    [commentBtn setImage:[UIImage imageNamed:@"icon_review.pdf"] forState:UIControlStateNormal];
    _commentBtn = commentBtn;
}
-(void)setLikeCountLabel:(UILabel *)likeCountLabel
{
    [likeCountLabel setFont:[UIFont systemFontOfSize:12]];
    [likeCountLabel setTextColor:blackFontColor];
    _likeCountLabel = likeCountLabel;
    
}
-(void)setCommentCountLabel:(UILabel *)commentCountLabel
{
    [commentCountLabel setFont:[UIFont systemFontOfSize:12]];
    [commentCountLabel setTextColor:blackFontColor];
    _commentCountLabel = commentCountLabel;
}
@end
