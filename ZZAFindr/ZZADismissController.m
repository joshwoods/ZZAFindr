//
//  ZZADismissController.m
//  ZZAFindr
//
//  Created by Josh Woods on 8/29/14.
//  Copyright (c) 2014 sdoowhsoj. All rights reserved.
//

#import "ZZADismissController.h"

@implementation ZZADismissController

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //create to and from controllers
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    //establish the to controller as the final frame
    CGRect finalFrame = [transitionContext finalFrameForViewController:toViewController];
    
    //create the container view for both views
    UIView *containerView = [transitionContext containerView];
    
    //establish the to controller as the final frame and set it's alpha to .5
    toViewController.view.frame = finalFrame;
    toViewController.view.alpha = 0.5;
    
    //add to controller to subview and send it to the back of the line :P
    [containerView addSubview:toViewController.view];
    [containerView sendSubviewToBack:toViewController.view];
    
    //create a frame that is 1/4 the size of the regular controller and establish where it will be going
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect shrunkenFrame = CGRectInset(fromViewController.view.frame, fromViewController.view.frame.size.width/4, fromViewController.view.frame.size.height/4);
    CGRect fromFinalFrame = CGRectOffset(shrunkenFrame, 0, screenBounds.size.height);
    
    //how long is this going on for??!!
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    //create a snapshot of the from controller and add to subview
    UIView *intermediateView = [fromViewController.view snapshotViewAfterScreenUpdates:NO];
    intermediateView.frame = fromViewController.view.frame;
    [containerView addSubview:intermediateView];
    
    //will the real fromviewcontroller, please stand up? just kidding, get out of here.
    [fromViewController.view removeFromSuperview];
    
    [UIView animateKeyframesWithDuration:duration
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic
                              animations:^{
                                  [UIView addKeyframeWithRelativeStartTime:0.0
                                                          relativeDuration:0.5
                                                                animations:^{
                                                                    intermediateView.frame = shrunkenFrame;
                                                                    toViewController.view.alpha = 0.5;
                                                                }];
                                  [UIView addKeyframeWithRelativeStartTime:0.5
                                                          relativeDuration:0.5
                                                                animations:^{
                                                                    intermediateView.frame = fromFinalFrame;
                                                                    toViewController.view.alpha = 1.0;
                                                                }];
                              }completion:^(BOOL finished){
                                  [intermediateView removeFromSuperview];
                                  [transitionContext completeTransition:YES];
                              }];
}

@end
