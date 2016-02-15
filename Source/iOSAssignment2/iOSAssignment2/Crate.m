//
//  Crate.m
//  iOSAssignment2
//
//  Created by ChristoferKlassen on 2016-02-13.
//  Copyright © 2016 Chris Klassen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Crate.h"
#import "CrateData.h"
#import "Vector.h"

@interface Crate ()
{
	Vector3 *position;
	float rotation;
}

@end


@implementation Crate

static const NSString* FILE_NAME = @"CrateUV.png";
static const float ROTATE_SPEED = 0.01;


-(id)initWithPosition:(Vector3*)pos
{
	self = [super initWithTextureFile:FILE_NAME pos:CratePositions posSize:sizeof(CratePositions) tex:CrateTexels texSize:sizeof(CrateTexels) norm:CrateNormals normSize:sizeof(CrateNormals)];
	position = pos;
	
	rotation = 0;
	
	return self;
}

-(void)update
{
	rotation += ROTATE_SPEED;
}


-(void)draw:(Program*)program camera:(Camera*)camera
{
	// Set up the model matrix
	GLKMatrix4 modelMatrix = GLKMatrix4Identity;
	modelMatrix = GLKMatrix4Multiply([camera getLookAt], modelMatrix);
	modelMatrix = GLKMatrix4Translate(modelMatrix, [position x], [position y], [position z]);
	modelMatrix = GLKMatrix4RotateY(modelMatrix, rotation);
	
	_normalMatrix = GLKMatrix3InvertAndTranspose(GLKMatrix4GetMatrix3(modelMatrix), NULL);
	
	_modelViewProjectionMatrix = GLKMatrix4Multiply(camera.perspective, modelMatrix);
	
	[self setTexture];
	[program useProgram:_vertexArray mvp:_modelViewProjectionMatrix normal:_normalMatrix];
	
	//draw the model
	glDrawArrays(GL_TRIANGLES, 0, CrateVertices);
}

@end
