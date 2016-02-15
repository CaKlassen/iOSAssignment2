//
//  Wall.m
//  iOSAssignment2
//
//  Created by ChristoferKlassen on 2016-02-12.
//  Copyright © 2016 Chris Klassen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Wall.h"
#import "WalLData.h"
#import "Vector.h"

@interface Wall ()
{
	Vector3 *position;
}

@end


@implementation Wall

-(id)initWithPosition:(Vector3*)pos type:(int)type
{
	NSString *str = [NSString stringWithFormat:@"WallUV%d.png", type];
	
	self = [super initWithTextureFile:str pos:WallPositions posSize:sizeof(WallPositions) tex:WallTexels texSize:sizeof(WallTexels) norm:WallNormals normSize:sizeof(WallNormals)];
	position = [[Vector3 alloc] initWithValue:(pos.x * 2) yPos:(pos.y * 2) zPos:(pos.z * 2)];
	
	
	return self;
}

-(void)update
{
	
}


-(void)draw:(Program*)program camera:(Camera*)camera
{
	// Set up the model matrix
	GLKMatrix4 modelMatrix = GLKMatrix4Identity;
	modelMatrix = GLKMatrix4Multiply([camera getLookAt], modelMatrix);
	modelMatrix = GLKMatrix4Translate(modelMatrix, [position x], [position y], [position z]);
	
	_normalMatrix = GLKMatrix3InvertAndTranspose(GLKMatrix4GetMatrix3(modelMatrix), NULL);
	
	[self setTexture];
	
	GLKVector3 eyeDir = GLKVector3Make([[camera lookAt] x], [[camera lookAt] y], [[camera lookAt] z]);
	GLKMatrix4 viewProj = [camera perspective];
	
	[program setUniform:@"ViewProj" value:&viewProj size:sizeof(viewProj)];
	[program setUniform:@"World" value:&modelMatrix size:sizeof(modelMatrix)];
	[program setUniform:@"normalMatrix" value:&_normalMatrix size:sizeof(_normalMatrix)];
	[program setUniform:@"EyeDirection" value:&eyeDir size:sizeof(eyeDir)];
	
	[program useProgram:_vertexArray];
	
	//draw the model
	glDrawArrays(GL_TRIANGLES, 0, WallVertices);
}

@end