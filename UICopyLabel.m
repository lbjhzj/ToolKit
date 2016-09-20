//
//  UICopeLabel.m
//  test
//
//  Created by Jeson on 2016/8/29.
//  Copyright © 2016年 Foxconn. All rights reserved.
//

#import "UICopyLabel.h"

@interface UICopyLabel ()<UIGestureRecognizerDelegate>

@property UIPasteboard *pBoard;

@end

@implementation UICopyLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.numberOfLines = 0;
//        [self attachTapGesture];
//        self.pBoard = [UIPasteboard generalPasteboard];
    }
    return self;
}

- (void)attachTapGesture{
    self.userInteractionEnabled = YES;
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapAction:)];
    //    tap.numberOfTapsRequired = 1;
    //    [self addGestureRecognizer:tap];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapAction:)];
    [self addGestureRecognizer:longPress];
    
}

- (void)handleTapAction:(UITapGestureRecognizer *)sender {
    [self becomeFirstResponder];
    UIMenuItem *copyMenuItem = [[UIMenuItem alloc]initWithTitle:@"複製" action:@selector(copyAction:)];
    //    UIMenuItem *pasteMenueItem = [[UIMenuItem alloc]initWithTitle:@"粘贴" action:@selector(pasteAction:)];
    //    UIMenuItem *cutMenuItem = [[UIMenuItem alloc]initWithTitle:@"剪切" action:@selector(cutAction:)];
    
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    
    
    [menuController setMenuItems:[NSArray arrayWithObjects:copyMenuItem, nil]];
    [menuController setTargetRect:self.frame inView:self.superview];
    [menuController setMenuVisible:YES animated: YES];
    
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(copyAction:)) {
        return YES;
    }
    if (action == @selector(pasteAction:)) {
        return YES;
    }
    if (action == @selector(cutAction:)) {
        return YES;
    }
    return NO; //隐藏系统默认的菜单项
}

#pragma mark 实现方法

- (void)copyAction:(id)sender {
    self.pBoard.string = self.text;
    NSLog(@"粘贴的内容为%@", self.pBoard.string);
}

- (void)pasteAction:(id)sender {
    self.text = self.pBoard.string;
}

- (void)cutAction:(id)sender {
    self.pBoard.string = self.text;
    self.text = nil;
}

@end