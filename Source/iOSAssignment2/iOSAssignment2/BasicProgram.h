//
//  BasicProgram.h
//  iOSAssignment2
//
//  Created by ChristoferKlassen on 2016-02-12.
//  Copyright © 2016 Chris Klassen. All rights reserved.
//

#ifndef BasicProgram_h
#define BasicProgram_h

#import "Program.h"


@interface BasicProgram : Program

-(id)init;
-(void)useProgram:(GLuint)vertexArray mvp:(GLKMatrix4)mvpMatrix normal:(GLKMatrix3)normalMatrix;

@end


#endif /* BasicProgram_h */
