//
//  MNFirstViewController.m
//  ImageMap
//
//  Created by Moo on 8/8/13.
//  Copyright (c) 2013 micmoo. All rights reserved.
//

#import "MNFirstViewController.h"

@interface MNFirstViewController ()

@end

@implementation MNFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [map loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost/ipad.htm"]]];
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Images" style:UIBarButtonItemStylePlain target:self action:@selector(showImages:)];
    [toolbar setItems:[NSArray arrayWithObject:anotherButton]];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)showImages:(id)sender {
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad"
                                                  bundle:nil];
    UIViewController* pdvc = [sb instantiateViewControllerWithIdentifier:@"Gallery"];

    popover = [[UIPopoverController alloc] initWithContentViewController:pdvc];
    [popover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
