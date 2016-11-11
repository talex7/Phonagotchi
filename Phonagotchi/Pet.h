//
//  Pet.h
//  Phonagotchi
//
//  Created by Thomas Alexanian on 2016-11-10.
//  Copyright © 2016 Lighthouse Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pet : UIView

@property (nonatomic, readonly) BOOL isGrumpy;

-(void)changeGrumpiness;


@end
