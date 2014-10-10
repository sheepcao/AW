//
//  sharePhotoViewController.h
//  completeImage
//
//  Created by 张力 on 14-6-23.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "sharePhotoViewController.h"
#import "globalVar.h"
//#import "AfterTakePicViewController.h"

@interface sharePhotoViewController : UIViewController< UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>

@property (strong, nonatomic)  UIImageView *frontImage;
@property (strong, nonatomic)  UIImageView *backImage;
@property (weak, nonatomic)  NSString *frontImageName;
@property (nonatomic ,strong)UIView *SharePhotoView;
//@property (nonatomic ,strong) UIButton *saveImage;
@property (nonatomic ,strong) UIButton *photograph;
@property (nonatomic ,strong) UIButton *share;
@property (nonatomic ,strong) UIButton *retakePic;
@property (nonatomic ,strong) UIButton *savePic;

@property (nonatomic ,strong) UILabel *welcome;
@property (nonatomic ,strong) UIImagePickerController *picker;
@property BOOL afterShutter;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

- (IBAction)saveImage:(id)sender;
- (IBAction)photograph:(id)sender;
- (IBAction)returnToGame:(UIButton *)sender;

@end
