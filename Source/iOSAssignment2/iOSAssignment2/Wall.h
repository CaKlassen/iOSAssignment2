//
//  Wall.h
//  iOSAssignment2
//
//  Created by ChristoferKlassen on 2016-02-12.
//  Copyright © 2016 Chris Klassen. All rights reserved.
//

#ifndef Wall_h
#define Wall_h
#import "Model.h"
#import "Vector.h"


@interface Wall : Model

-(id)initWithPosition:(Vector3*)pos;

@end


#endif /* Wall_h */