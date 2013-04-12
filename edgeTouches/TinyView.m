//
//  TinyView.m
//  TouchExample
//
//  Created by gBit on 3/7/13.
//  Copyright (c) 2013 gBit. All rights reserved.
//

#import "TinyView.h"

@implementation TinyView
{
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    originalPoint = [touch locationInView:self];
    
    self.backgroundColor = [UIColor yellowColor];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.superview];
    
//    NSLog(@"superview width: %f", self.superview.frame.size.width);
//    NSLog(@"superview height: %f", self.superview.frame.size.height);
//    NSLog(@"leftBound: %f", point.x - originalPoint.x);
//    NSLog(@"rightBound: %f", point.x - originalPoint.x + self.frame.size.width);
//    NSLog(@"topBound: %f", point.y - originalPoint.y);
//    NSLog(@"bottomBound: %f", point.y - originalPoint.y + self.frame.size.height);
    
    float leftBound = point.x - originalPoint.x;
    float topBound = point.y - originalPoint.y;
    float rightBound = point.x - originalPoint.x + self.frame.size.width;
    float bottomBound = point.y - originalPoint.y + self.frame.size.height;

    if ((leftBound > 0) && (topBound > 0) && (rightBound < self.superview.frame.size.width) && (bottomBound < self.superview.frame.size.height))
    {
        self.frame = CGRectMake(point.x - originalPoint.x, point.y - originalPoint.y, self.frame.size.width, self.frame.size.height);
        
    } else
    {
        [self touchesEnded:touches withEvent:event];
        
        UIAlertView *ouch;
        ouch = [[UIAlertView alloc] initWithTitle:@"Heads Up, Cowboy!!!"
                                          message:@"Your trusty stead can't go beyond this point. Time to mosey on back toward the center."
                                         delegate:self
                                cancelButtonTitle:@"You got it, partner"
                                otherButtonTitles: nil];
        
        [ouch show];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.backgroundColor = [UIColor magentaColor];
    [UIView animateWithDuration:0.2f
                     animations:^void
                                {
                                    self.backgroundColor = [UIColor orangeColor];
                                }
    ];
}

@end
