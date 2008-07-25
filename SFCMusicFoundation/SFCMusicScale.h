//
//  MusicScale.h
//  MusicFoundation
//
//  Una escala esta compuesta por un grupo de notas dentro de una octava
//  que en secuencia ofrecen una cierta armonia. Hay escalas mayores y menores
//  y una escala siempre tiene una tonica, que es la nota dominante de la misma.
//  Las escalas mayores y menores siempre tienen los mismos intervalos
//  entre las notas, asi que con indicar la tonica se puede derivar el resto
//  de las notas de la escala.
//  Created by Enrique Zamudio Lopez on 18/07/08.
//  Copyright 2008 Desarrollo de Soluciones Abiertas, S.C.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFCMusicNote.h"

@interface SFCMusicScale : NSObject {

    unsigned short type; //major, minor natural, minor harmonic, minor melodic, minor pentatonic
    SFCMusicNote *fund;
    NSArray *notes;
}

//TODO: Si van bemoles o sostenidos depende de la nota y del tipo de escala

+ (SFCMusicScale *)majorScaleFromNote:(SFCMusicNote *)base;
+ (SFCMusicScale *)minorNaturalScaleFromNote:(SFCMusicNote *)base;
+ (SFCMusicScale *)minorHarmonicScaleFromNote:(SFCMusicNote *)base;
+ (SFCMusicScale *)minorMelodicScaleFromNote:(SFCMusicNote *)base;

//Una pentatonica es una menor con solamente 5 notas
+ (SFCMusicScale *)pentatonicScaleFromNote:(SFCMusicNote *)base;

- initWithType:(unsigned short)aType baseNote:(SFCMusicNote *)note;

- (NSArray *)notes;

- (SFCMusicNote *)baseNote;

//Devuelve la escala relativa al receptor; si es una mayor, devuelve la menor
//relativa y si es una menor, devuelve la mayor.
//Para una pentatonica se devuelve la misma escala (no hay pentatonicas mayores).
- (SFCMusicScale *)relativeScale;

//Devuelve la siguiente escala ascendente, en caso de escalas mayores.
- (SFCMusicScale *)nextUpperScale;
//Devuelve la siguiente escala descendente, en caso de escalas mayores.
- (SFCMusicScale *)nextLowerScale;

//Devuelve el intervalo de la nota indicada, considerando la fundamental de la escala
//como intervalo I. Si la nota no esta en la escala, devuelve 0.
//No considera enarmonicos.
- (unsigned short)intervalOfNote:(SFCMusicNote *)note;

//Devuelve el intervalo entre las notas indicadas. Se toma en cuenta la octava
//de cada una asi que se pueden devolver intervalos compuestos. Un numero positivo
//es un intervalo ascendente y un numero negativo es un intervalo descendente.
- (short)intervalBetweenNote:(SFCMusicNote *)n1 andNote:(SFCMusicNote *)n2;

//Devuelve la nota en el intervalo indicado, a partir de la fundamental.
//Es equivalente a llamar noteAtInterval:fromNote: con la fundamental como parametro.
- (SFCMusicNote *)noteAtInterval:(short)interval;

//Devuelve la nota en el intervalo indicado, relativo al intervalo de referencia.
//Por ejemplo si se pasa como referencia el intervalo IV y se pide el intervalo III,
//se obtiene la nota en el intervalo VI. Permite intervalos compuestos. Para intervalos
//descendentes se usan numeros negativos.
- (SFCMusicNote *)noteAtInterval:(short)interval fromInterval:(unsigned short)ref;

@end
