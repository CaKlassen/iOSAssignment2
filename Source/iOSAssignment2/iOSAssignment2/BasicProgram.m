//
//  BasicProgram.m
//  iOSAssignment2
//
//  Created by ChristoferKlassen on 2016-02-12.
//  Copyright © 2016 Chris Klassen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicProgram.h"

@interface BasicProgram ()
{
	enum
	{
		UNIFORM_MODELVIEWPROJECTION_MATRIX,
		UNIFORM_NORMAL_MATRIX,
		NUM_UNIFORMS
	};
	
	GLint uniforms[NUM_UNIFORMS];
}

@end


@implementation BasicProgram

-(id)init
{
	// Create the shaders
	self = [super initWithShaders:@"BasicShader" fragmentShader:@"BasicShader"];
	
	// Retrieve the uniform locations
	[self retrieveUniforms];
	
	return self;
}


-(void)retrieveUniforms
{
	uniforms[UNIFORM_MODELVIEWPROJECTION_MATRIX] = glGetUniformLocation(program, "modelViewProjectionMatrix");
	uniforms[UNIFORM_NORMAL_MATRIX] = glGetUniformLocation(program, "normalMatrix");
}


-(void)useProgram:(GLuint)vertexArray mvp:(GLKMatrix4)mvpMatrix normal:(GLKMatrix3)normalMatrix
{
	glUseProgram(program);
	
	glBindVertexArrayOES(vertexArray);
	
	glUniformMatrix4fv(uniforms[UNIFORM_MODELVIEWPROJECTION_MATRIX], 1, 0, mvpMatrix.m);
	glUniformMatrix3fv(uniforms[UNIFORM_NORMAL_MATRIX], 1, 0, normalMatrix.m);
}


@end